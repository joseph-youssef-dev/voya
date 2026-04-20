import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/api/register_api_service.dart';
import '../../data/models/register_request_model.dart';
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
        ssn: ssn,
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
        profileImage: profileImage,
        birthDate: birthDate,
        phone: phone,
        town: town,
      );
      final response = await apiService.registerPassenger(request);
      
      final message = (response is Map<String, dynamic> && response.containsKey('message')) 
          ? response['message'] 
          : 'Registration Successful';

      emit(RegisterSuccess(message: message.toString()));
      
    } catch (e) {
      emit(RegisterFailure(errorMessage: e.toString()));
    }
  }
}
