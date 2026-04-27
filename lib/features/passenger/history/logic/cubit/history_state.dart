import 'package:voya/features/passenger/history/data/models/my_trip_model.dart';

abstract class HistoryState {}

class HistoryInitial extends HistoryState {}

class HistoryLoading extends HistoryState {}

class HistorySuccess extends HistoryState {
  final List<MyTripModel> trips;
  HistorySuccess({required this.trips});
}

class HistoryFailure extends HistoryState {
  final String errorMessage;
  HistoryFailure({required this.errorMessage});
}

class UpdateBookingLoading extends HistoryState {}

class UpdateBookingSuccess extends HistoryState {
  final String message;
  UpdateBookingSuccess({required this.message});
}

class UpdateBookingFailure extends HistoryState {
  final String errorMessage;
  UpdateBookingFailure({required this.errorMessage});
}
