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
      
      // Filter waiting vs completed (Assuming status or date check)
      // For now, let's just put all in waiting if they are in the future
      final now = DateTime.now();
      final waiting = trips.where((t) {
        try {
          return DateTime.parse(t.startDate).isAfter(now);
        } catch (_) {
          return true; // Default to waiting if date parse fails
        }
      }).toList();
      
      final completed = trips.where((t) {
        try {
          return DateTime.parse(t.startDate).isBefore(now);
        } catch (_) {
          return false;
        }
      }).toList();

      emit(DriverHomeSuccess(
        waitingTrips: waiting,
        completedTrips: completed,
      ));
    } catch (e) {
      emit(DriverHomeError(e.toString()));
    }
  }
}
