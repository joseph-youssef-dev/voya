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

      final message = (response is Map<String, dynamic> &&
              response.containsKey('message'))
          ? response['message']
          : 'Driver Registration Successful';

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

      emit(DriverRegisterSuccess(message: message.toString()));
    } catch (e) {
      emit(DriverRegisterFailure(errorMessage: e.toString()));
    }
  }
}
