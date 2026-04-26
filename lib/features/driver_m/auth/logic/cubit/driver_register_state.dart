abstract class DriverRegisterState {}

class DriverRegisterInitial extends DriverRegisterState {}

class DriverRegisterLoading extends DriverRegisterState {}

class DriverRegisterSuccess extends DriverRegisterState {
  final String message;
  DriverRegisterSuccess({required this.message});
}

class DriverRegisterFailure extends DriverRegisterState {
  final String errorMessage;
  DriverRegisterFailure({required this.errorMessage});
}
