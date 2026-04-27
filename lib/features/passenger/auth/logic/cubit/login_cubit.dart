import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voya/core/databases/cache/cache_helper.dart';
import 'package:voya/core/constants/app_strings.dart';
import 'package:voya/core/enums/role_enum.dart';
import 'package:voya/core/errors/error_model.dart';
import '../../data/api/login_api_service.dart';
import '../../data/models/login_request_model.dart';
import 'package:voya/core/errors/expentions.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginApiService apiService;

  LoginCubit({required this.apiService}) : super(LoginInitial());

  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    emit(LoginLoading());
    try {
      final request = LoginRequestModel(
        email: email.trim(),
        password: password.trim(),
      );
      final response = await apiService.login(request);

      // Strictly check for success and token presence
      if (response is Map<String, dynamic>) {
        final bool isSuccess = response['isSuccess'] ?? true;
        final int statusCode = response['statusCode'] ?? 200;

        // Find token in response or data object
        final data = response['data'] ?? response;
        final token = data['token'] ?? data['accessToken'];

        if (!isSuccess || statusCode != 200 || token == null) {
          final errorMessage = response['message'] ?? 'Invalid email or password.';
          throw ServerException(ErrorModel(errorMessage: errorMessage.toString(), status: statusCode));
        }
      } else {
        throw ServerException(ErrorModel(errorMessage: 'Unexpected server response', status: 500));
      }

      final message =
          (response is Map<String, dynamic> && response.containsKey('message'))
          ? response['message']
          : 'Login Successful';

      if (response is Map<String, dynamic> && response.containsKey('data')) {
        final data = response['data'];
        if (data['token'] != null) {
          await CacheHelper().saveData(key: 'token', value: data['token']);
        }
        if (data['refreshToken'] != null) {
          await CacheHelper().saveData(
            key: 'refreshToken',
            value: data['refreshToken'],
          );
        }
      } else if (response is Map<String, dynamic>) {
        if (response['token'] != null) {
          await CacheHelper().saveData(key: 'token', value: response['token']);
        }
        if (response['refreshToken'] != null) {
          await CacheHelper().saveData(
            key: 'refreshToken',
            value: response['refreshToken'],
          );
        }
      }

      await CacheHelper().saveData(key: 'email', value: email.trim());
      await CacheHelper().saveData(key: 'isLoggedIn', value: true);
      await CacheHelper().saveData(
        key: kUserRole,
        value: UserRole.passenger.name,
      );

      emit(LoginSuccess(message: message.toString()));
    } on ServerException catch (e) {
      emit(LoginFailure(errorMessage: e.errorModel.errorMessage));
    } catch (e) {
      emit(
        LoginFailure(
          errorMessage: 'An unexpected error occurred: ${e.toString()}',
        ),
      );
    }
  }
}
