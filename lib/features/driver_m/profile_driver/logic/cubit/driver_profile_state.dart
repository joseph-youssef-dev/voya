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
