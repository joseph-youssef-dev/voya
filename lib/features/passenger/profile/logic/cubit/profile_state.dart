import 'package:voya/features/passenger/profile/data/models/passenger_profile_model.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileSuccess extends ProfileState {
  final PassengerProfileModel profile;
  ProfileSuccess({required this.profile});
}

class ProfileFailure extends ProfileState {
  final String errorMessage;
  ProfileFailure({required this.errorMessage});
}
