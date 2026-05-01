import 'package:voya/features/driver_m/profile_driver/data/models/driver_profile_model.dart';

abstract class DriverProfileState {}

class DriverProfileInitial extends DriverProfileState {}

class DriverProfileLoading extends DriverProfileState {}

class DriverProfileSuccess extends DriverProfileState {
  final DriverProfileModel profile;
  DriverProfileSuccess({required this.profile});
}

class DriverProfileFailure extends DriverProfileState {
  final String errorMessage;
  DriverProfileFailure({required this.errorMessage});
}

class DriverProfileUpdateLoading extends DriverProfileState {}

class DriverProfileUpdateSuccess extends DriverProfileState {
  final String message;
  DriverProfileUpdateSuccess({required this.message});
}

class DriverProfileUpdateFailure extends DriverProfileState {
  final String errorMessage;
  DriverProfileUpdateFailure({required this.errorMessage});
}

class DriverVehicleActionLoading extends DriverProfileState {}

class DriverVehicleActionSuccess extends DriverProfileState {
  final String message;
  DriverVehicleActionSuccess({required this.message});
}

class DriverVehicleActionFailure extends DriverProfileState {
  final String errorMessage;
  DriverVehicleActionFailure({required this.errorMessage});
}
