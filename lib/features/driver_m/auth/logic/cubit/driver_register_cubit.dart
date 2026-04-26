import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/api/driver_register_api_service.dart';
import '../../data/models/driver_register_request_model.dart';
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
        ssn: ssn,
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
        profileImage: profileImage,
        phone: phone,
        town: town,
        birthDate: birthDate,
        vehicle: VehicleRequestModel(
          model: vehicleModel,
          color: vehicleColor,
          numberOfPassengers: numberOfPassengers,
          images: vehicleImages,
        ),
        driverLicense: DriverLicenseRequestModel(
          licenseNumber: licenseNumber,
          expiryDate: licenseExpiryDate,
          licenseImage: licenseImage,
        ),
      );

      final response = await apiService.registerDriver(request);

      final message = (response is Map<String, dynamic> &&
              response.containsKey('message'))
          ? response['message']
          : 'Registration Successful';

      emit(DriverRegisterSuccess(message: message.toString()));
    } catch (e) {
      emit(DriverRegisterFailure(errorMessage: e.toString()));
    }
  }
}
