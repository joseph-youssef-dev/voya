import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voya/features/driver_m/home/data/api/trip_api_service.dart';
import 'package:voya/features/passenger/home/data/models/trip_model.dart';
import 'driver_home_state.dart';

class DriverHomeCubit extends Cubit<DriverHomeState> {
  final TripApiService apiService;

  DriverHomeCubit({required this.apiService}) : super(DriverHomeInitial());

  Future<void> fetchTrips() async {
    emit(DriverHomeLoading());
    try {
      final tripsData = await apiService.getDriverTrips();
      final trips = tripsData.map((e) => TripModel.fromJson(e)).toList();
      
      final completed = trips.where((t) => t.availableSeats == 0).toList();

      final pending = trips.where((t) {
        return t.availableSeats > 0 && t.status.toLowerCase() == 'waiting';
      }).toList();

      final open = trips.where((t) {
        return t.availableSeats > 0 && t.status.toLowerCase() == 'accepted';
      }).toList();

      final rejected = trips.where((t) {
        return t.availableSeats > 0 && 
               ['rejected', 'failed', 'canceled'].contains(t.status.toLowerCase());
      }).toList();

      emit(DriverHomeSuccess(
        pendingTrips: pending,
        openTrips: open,
        completedTrips: completed,
        rejectedTrips: rejected,
      ));
    } catch (e) {
      emit(DriverHomeError(e.toString()));
    }
  }
}
