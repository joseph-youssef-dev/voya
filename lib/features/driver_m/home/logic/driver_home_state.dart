import 'package:voya/features/passenger/home/data/models/trip_model.dart';

abstract class DriverHomeState {}

class DriverHomeInitial extends DriverHomeState {}

class DriverHomeLoading extends DriverHomeState {}

class DriverHomeSuccess extends DriverHomeState {
  final List<TripModel> pendingTrips;
  final List<TripModel> openTrips;
  final List<TripModel> completedTrips;
  final List<TripModel> rejectedTrips;

  DriverHomeSuccess({
    required this.pendingTrips,
    required this.openTrips,
    required this.completedTrips,
    required this.rejectedTrips,
  });
}

class DriverHomeError extends DriverHomeState {
  final String message;
  DriverHomeError(this.message);
}
