import 'package:voya/features/passenger/home/data/models/trip_model.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final List<TripModel> trips;
  HomeSuccess({required this.trips});
}

class HomeFailure extends HomeState {
  final String errorMessage;
  HomeFailure({required this.errorMessage});
}
