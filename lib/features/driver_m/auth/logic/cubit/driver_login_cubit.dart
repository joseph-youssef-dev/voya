import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voya/core/databases/cache/cache_helper.dart';
import 'package:voya/core/constants/app_strings.dart';
import 'package:voya/core/enums/role_enum.dart';
import '../../data/api/driver_login_api_service.dart';
import '../../data/models/driver_login_request_model.dart';
import 'driver_login_state.dart';

class DriverLoginCubit extends Cubit<DriverLoginState> {
  final DriverLoginApiService apiService;

  DriverLoginCubit({required this.apiService}) : super(DriverLoginInitial());

  Future<void> loginDriver({
    required String email,
    required String password,
  }) async {
    emit(DriverLoginLoading());
    try {
      final request = DriverLoginRequestModel(email: email, password: password);
      final response = await apiService.login(request);

      final message = (response is Map<String, dynamic> &&
              response.containsKey('message'))
          ? response['message']
          : 'Login Successful';

      // Save token
      if (response is Map<String, dynamic> && response.containsKey('data')) {
        final data = response['data'];
        if (data is Map<String, dynamic> && data.containsKey('token')) {
          await CacheHelper().saveData(key: 'token', value: data['token']);
        }
      } else if (response is Map<String, dynamic> &&
          response.containsKey('token')) {
        await CacheHelper().saveData(key: 'token', value: response['token']);
      }

      await CacheHelper().saveData(key: 'isLoggedIn', value: true);
      await CacheHelper().saveData(key: kUserRole, value: UserRole.driver.name);

      emit(DriverLoginSuccess(message: message.toString()));
    } catch (e) {
      emit(DriverLoginFailure(errorMessage: e.toString()));
    }
  }
}
