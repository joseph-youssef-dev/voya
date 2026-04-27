abstract class BookingState {}

class BookingInitial extends BookingState {}

class BookingLoading extends BookingState {}

class BookingSuccess extends BookingState {
  final String message;
  BookingSuccess({required this.message});
}

class BookingFailure extends BookingState {
  final String errorMessage;
  BookingFailure({required this.errorMessage});
}

class BookingSeatsChanged extends BookingState {
  final int seats;
  final double totalPrice;
  BookingSeatsChanged({required this.seats, required this.totalPrice});
}
