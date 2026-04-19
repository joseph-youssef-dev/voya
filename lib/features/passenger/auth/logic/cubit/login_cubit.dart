import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      
      // If no exception is thrown by ApiConsumer, it's a success string or map.
      final message = (response is Map<String, dynamic> && response.containsKey('message')) 
          ? response['message'] 
          : 'Login Successful';
      emit(LoginSuccess(message: message.toString()));
      
    } catch (e) {
      // Assuming exceptions are thrown properly from DioConsumer
      emit(LoginFailure(errorMessage: e.toString()));
    }
  }
}
