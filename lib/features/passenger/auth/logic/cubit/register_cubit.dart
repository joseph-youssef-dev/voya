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
      
      final message = (response is Map<String, dynamic> && response.containsKey('message')) 
          ? response['message'] 
          : 'Registration Successful';

      if (response is Map<String, dynamic> && response.containsKey('data')) {
        final data = response['data'];
        if (data['token'] != null) {
          await CacheHelper().saveData(key: 'token', value: data['token']);
        }
        if (data['refreshToken'] != null) {
          await CacheHelper().saveData(key: 'refreshToken', value: data['refreshToken']);
        }
      } else if (response is Map<String, dynamic>) {
        if (response['token'] != null) {
          await CacheHelper().saveData(key: 'token', value: response['token']);
        }
        if (response['refreshToken'] != null) {
          await CacheHelper().saveData(key: 'refreshToken', value: response['refreshToken']);
        }
      }

      emit(RegisterSuccess(message: message.toString()));
      
    } catch (e) {
      emit(RegisterFailure(errorMessage: e.toString()));
    }
  }
}
