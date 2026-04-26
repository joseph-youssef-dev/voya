abstract class DriverLoginState {}

class DriverLoginInitial extends DriverLoginState {}

class DriverLoginLoading extends DriverLoginState {}

class DriverLoginSuccess extends DriverLoginState {
  final String message;
  DriverLoginSuccess({required this.message});
}

class DriverLoginFailure extends DriverLoginState {
  final String errorMessage;
  DriverLoginFailure({required this.errorMessage});
}
