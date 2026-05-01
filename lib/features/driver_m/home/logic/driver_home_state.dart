import 'package:voya/features/passenger/home/data/models/trip_model.dart';

abstract class DriverHomeState {}

class DriverHomeInitial extends DriverHomeState {}

class DriverHomeLoading extends DriverHomeState {}

class DriverHomeSuccess extends DriverHomeState {
  final List<TripModel> waitingTrips;
  final List<TripModel> completedTrips;
  final List<TripModel> rejectedTrips;

  DriverHomeSuccess({
    required this.waitingTrips,
    required this.completedTrips,
    required this.rejectedTrips,
  });
}

class DriverHomeError extends DriverHomeState {
  final String message;
  DriverHomeError(this.message);
}
