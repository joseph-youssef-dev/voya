abstract class SharedAuthState {}

class SharedAuthInitial extends SharedAuthState {}

class SharedAuthLoading extends SharedAuthState {}

class SharedAuthSuccess extends SharedAuthState {
  final String message;
  SharedAuthSuccess({required this.message});
}

class SharedAuthVerifySuccess extends SharedAuthSuccess {
  SharedAuthVerifySuccess({required super.message});
}

class SharedAuthResendSuccess extends SharedAuthSuccess {
  SharedAuthResendSuccess({required super.message});
}

class SharedAuthFailure extends SharedAuthState {
  final String errorMessage;
  SharedAuthFailure({required this.errorMessage});
}
