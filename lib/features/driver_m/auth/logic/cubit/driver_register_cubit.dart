import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/api/driver_register_api_service.dart';
import '../../data/models/driver_register_request_model.dart';
import 'package:voya/core/databases/cache/cache_helper.dart';
import 'driver_register_state.dart';

class DriverRegisterCubit extends Cubit<DriverRegisterState> {
  final DriverRegisterApiService apiService;

  DriverRegisterCubit({required this.apiService})
      : super(DriverRegisterInitial());

  Future<void> registerDriver({
    required String ssn,
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    File? profileImage,
    required String phone,
    required String town,
    required String birthDate,
    required String vehicleModel,
    required String vehicleColor,
    required String vehicleLicense,
    required int numberOfPassengers,
    List<File> vehicleImages = const [],
    required String licenseNumber,
    required String licenseExpiryDate,
    File? licenseImage,
  }) async {
    emit(DriverRegisterLoading());
    try {
      final request = DriverRegisterRequestModel(
        ssn: ssn.trim(),
        email: email.trim(),
        password: password.trim(),
        firstName: firstName.trim(),
        lastName: lastName.trim(),
        profileImage: profileImage,
        phone: phone.trim(),
        town: town.trim(),
        birthDate: birthDate.trim(),
        vehicle: VehicleRequestModel(
          model: vehicleModel.trim(),
          color: vehicleColor.trim(),
          vehicleLicense: vehicleLicense.trim(),
          numberOfPassengers: numberOfPassengers,
          images: vehicleImages,
        ),
        driverLicense: DriverLicenseRequestModel(
          licenseNumber: licenseNumber.trim(),
          expiryDate: licenseExpiryDate.trim(),
          licenseImage: licenseImage,
        ),
      );

      final response = await apiService.registerDriver(request);

      if (response is Map<String, dynamic>) {
        final isSuccess = response['isSuccess'] ?? response['IsSuccess'];
        if (isSuccess == false) {
          final errorMsg = (response['message'] ?? response['Message'] ?? 'Registration failed').toString();
          emit(DriverRegisterFailure(errorMessage: errorMsg));
          return;
        }
      }

      final String message = (response is Map<String, dynamic> &&
              (response.containsKey('message') || response.containsKey('Message')))
          ? (response['message'] ?? response['Message']).toString()
          : 'Driver Registration Successful';

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

      emit(DriverRegisterSuccess(message: message));
    } catch (e) {
      emit(DriverRegisterFailure(errorMessage: e.toString()));
    }
  }
}
