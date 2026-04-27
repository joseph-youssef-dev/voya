abstract class SharedAuthState {}

class SharedAuthInitial extends SharedAuthState {}

class SharedAuthLoading extends SharedAuthState {}

class SharedAuthSuccess extends SharedAuthState {
  final String message;
  SharedAuthSuccess({required this.message});
}

class SharedAuthFailure extends SharedAuthState {
  final String errorMessage;
  SharedAuthFailure({required this.errorMessage});
}
