import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/api/driver_profile_api_service.dart';
import 'driver_profile_state.dart';

class DriverProfileCubit extends Cubit<DriverProfileState> {
  final DriverProfileApiService apiService;

  DriverProfileCubit({required this.apiService})
    : super(DriverProfileInitial());

  Future<void> fetchProfile() async {
    emit(DriverProfileLoading());
    try {
      final profile = await apiService.getProfile();
      emit(DriverProfileSuccess(profile: profile));
    } catch (e) {
      emit(DriverProfileFailure(errorMessage: e.toString()));
    }
  }

  Future<void> updateProfile({
    required String firstName,
    required String lastName,
    required String birthDate,
    required String phone,
    required String town,
    required String ssn,
    String? profileImagePath,
  }) async {
    emit(DriverProfileUpdateLoading());
    try {
      await apiService.updateProfile(
        firstName: firstName,
        lastName: lastName,
        birthDate: birthDate,
        phone: phone,
        town: town,
        ssn: ssn,
        profileImagePath: profileImagePath,
      );
      emit(DriverProfileUpdateSuccess(message: 'Profile updated successfully'));
      fetchProfile();
    } catch (e) {
      emit(DriverProfileUpdateFailure(errorMessage: e.toString()));
    }
  }

  Future<void> addVehicle({
    required String model,
    required String color,
    required String vehicleLicense,
    required int numberOfPassengers,
  }) async {
    emit(DriverVehicleActionLoading());
    try {
      await apiService.addVehicle(
        model: model,
        color: color,
        vehicleLicense: vehicleLicense,
        numberOfPassengers: numberOfPassengers,
      );
      emit(DriverVehicleActionSuccess(message: 'Vehicle added successfully'));
      fetchProfile();
    } catch (e) {
      emit(DriverVehicleActionFailure(errorMessage: e.toString()));
    }
  }

  Future<void> updateVehicle({
    required int id,
    required String model,
    required String color,
    required String vehicleLicense,
    required int numberOfPassengers,
  }) async {
    emit(DriverVehicleActionLoading());
    try {
      await apiService.updateVehicle(
        id: id,
        model: model,
        color: color,
        vehicleLicense: vehicleLicense,
        numberOfPassengers: numberOfPassengers,
      );
      emit(DriverVehicleActionSuccess(message: 'Vehicle updated successfully'));
      fetchProfile();
    } catch (e) {
      emit(DriverVehicleActionFailure(errorMessage: e.toString()));
    }
  }

  Future<void> deleteVehicle(int id) async {
    emit(DriverVehicleActionLoading());
    try {
      await apiService.deleteVehicle(id);
      emit(DriverVehicleActionSuccess(message: 'Vehicle deleted successfully'));
      fetchProfile();
    } catch (e) {
      emit(DriverVehicleActionFailure(errorMessage: e.toString()));
    }
  }
}
