import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voya/core/databases/cache/cache_helper.dart';
import 'package:voya/core/constants/app_strings.dart';
import 'package:voya/core/enums/role_enum.dart';
import '../../data/api/login_api_service.dart';
import '../../data/models/login_request_model.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginApiService apiService;

  LoginCubit({required this.apiService}) : super(LoginInitial());

  Future<void> loginUser({required String email, required String password}) async {
    emit(LoginLoading());
    try {
      final request = LoginRequestModel(email: email, password: password);
      final response = await apiService.login(request);
      
      final message = (response is Map<String, dynamic> && response.containsKey('message')) 
          ? response['message'] 
          : 'Login Successful';

      if (response is Map<String, dynamic> && response.containsKey('data')) {
        final data = response['data'];
        if (data is Map<String, dynamic> && data.containsKey('token')) {
          await CacheHelper().saveData(key: 'token', value: data['token']);
        } else if (response.containsKey('token')) {
          await CacheHelper().saveData(key: 'token', value: response['token']);
        }
      } else if (response is Map<String, dynamic> && response.containsKey('token')) {
        await CacheHelper().saveData(key: 'token', value: response['token']);
      }

      await CacheHelper().saveData(key: 'isLoggedIn', value: true);
      await CacheHelper().saveData(key: kUserRole, value: UserRole.passenger.name);

      emit(LoginSuccess(message: message.toString()));
      
    } catch (e) {
      emit(LoginFailure(errorMessage: e.toString()));
    }
  }
}
