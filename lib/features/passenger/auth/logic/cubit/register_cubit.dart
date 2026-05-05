import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/api/register_api_service.dart';
import '../../data/models/register_request_model.dart';
import 'package:voya/core/databases/cache/cache_helper.dart';
import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterApiService apiService;

  RegisterCubit({required this.apiService}) : super(RegisterInitial());

  Future<void> registerUser({
    required String ssn,
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    File? profileImage,
    required String birthDate,
    required String phone,
    required String town,
  }) async {
    emit(RegisterLoading());
    try {
      final request = RegisterRequestModel(
        ssn: ssn.trim(),
        email: email.trim(),
        password: password.trim(),
        firstName: firstName.trim(),
        lastName: lastName.trim(),
        profileImage: profileImage,
        birthDate: birthDate.trim(),
        phone: phone.trim(),
        town: town.trim(),
      );
      final response = await apiService.registerPassenger(request);
      
      if (response is Map<String, dynamic>) {
        final isSuccess = response['isSuccess'] ?? response['IsSuccess'];
        if (isSuccess == false) {
          final errorMsg = (response['message'] ?? response['Message'] ?? 'Registration failed').toString();
          emit(RegisterFailure(errorMessage: errorMsg));
          return;
        }
      }
      
      final String message = (response is Map<String, dynamic> && (response.containsKey('message') || response.containsKey('Message'))) 
          ? (response['message'] ?? response['Message']).toString() 
          : 'Registration Successful';

      if (response is Map<String, dynamic> && response.containsKey('data')) {
        final data = response['data'];
        if (data is Map<String, dynamic>) {
          if (data['token'] != null) {
            await CacheHelper().saveData(key: 'token', value: data['token'].toString());
          }
          if (data['refreshToken'] != null) {
            await CacheHelper().saveData(key: 'refreshToken', value: data['refreshToken'].toString());
          }
        }
      } else if (response is Map<String, dynamic>) {
        if (response['token'] != null) {
          await CacheHelper().saveData(key: 'token', value: response['token'].toString());
        }
        if (response['refreshToken'] != null) {
          await CacheHelper().saveData(key: 'refreshToken', value: response['refreshToken'].toString());
        }
      }
      await CacheHelper().saveData(key: 'email', value: email.trim());
      await CacheHelper().saveData(key: 'userRole', value: 'passenger');

      emit(RegisterSuccess(message: message));
      
    } catch (e) {
      emit(RegisterFailure(errorMessage: e.toString()));
    }
  }
}
