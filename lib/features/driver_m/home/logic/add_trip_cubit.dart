import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voya/core/errors/expentions.dart';
import '../data/api/trip_api_service.dart';
import 'add_trip_state.dart';

class AddTripCubit extends Cubit<AddTripState> {
  final TripApiService apiService;

  AddTripCubit({required this.apiService})
    : super(
        AddTripStateData(
          seats: 1,
          from: '',
          to: '',
          date: '',
          time: '',
          price: '',
          notes: '',
          duration: '',
        ),
      ) {
    fetchVehicles();
  }

  Future<void> fetchVehicles() async {
    emit(data.copyWith(isLoadingVehicles: true));
    try {
      final vehicles = await apiService.getVehicles();
      emit(data.copyWith(vehicles: vehicles, isLoadingVehicles: false));
    } catch (e) {
      emit(data.copyWith(isLoadingVehicles: false));
    }
  }

  AddTripStateData get data => state as AddTripStateData;

  void updateSeats(int newSeats) {
    if (newSeats >= 1 && newSeats <= 100) {
      emit(data.copyWith(seats: newSeats));
    }
  }

  void updateField({
    int? tripId,
    String? from,
    String? to,
    String? date,
    String? time,
    String? price,
    String? notes,
    String? duration,
    int? vehicleID,
  }) {
    emit(
      data.copyWith(
        tripId: tripId,
        from: from,
        to: to,
        date: date,
        time: time,
        price: price,
        notes: notes,
        duration: duration,
        vehicleID: vehicleID,
      ),
    );
  }

  void initForUpdate(dynamic trip) {
    // Expecting trip to be TripModel or similar with these fields
    // startDate format: "2023-10-27T10:30:00"
    String date = '';
    String time = '';
    if (trip.startDate != null && trip.startDate.contains('T')) {
      final parts = trip.startDate.split('T');
      date = parts[0];
      final timeParts = parts[1].split(':');
      if (timeParts.length >= 2) {
        int hour = int.parse(timeParts[0]);
        String period = "AM";
        if (hour >= 12) {
          period = "PM";
          if (hour > 12) hour -= 12;
        } else if (hour == 0) {
          hour = 12;
        }
        time = "$hour:${timeParts[1]} $period";
      }
    }

    emit(
      data.copyWith(
        tripId: trip.id,
        from: trip.fromCity,
        to: trip.toCity,
        date: date,
        time: time,
        price: trip.pricePerSet.toString(),
        notes: trip.details,
        duration: trip.duration.toString(),
        vehicleID: trip.vechileId != 0 ? trip.vechileId : null,
      ),
    );
  }

  void resetForm() {
    emit(
      data.copyWith(
        tripId: null,
        from: '',
        to: '',
        date: '',
        time: '',
        price: '',
        notes: '',
        duration: '',
        vehicleID: null,
      ),
    );
  }

  Future<bool> publishTrip() async {
    if (data.from.isEmpty ||
        data.to.isEmpty ||
        data.date.isEmpty ||
        data.price.isEmpty ||
        data.vehicleID == null) {
      emit(data.copyWith(errorMessage: "Please fill all required fields"));
      return false;
    }

    emit(data.copyWith(isPublishing: true, errorMessage: null));

    try {
      // Convert time from "10:30 AM" to "10:30:00" (24h format)
      String formattedTime = "00:00:00";
      if (data.time.isNotEmpty) {
        final parts = data.time.split(' ');
        if (parts.length == 2) {
          final timeParts = parts[0].split(':');
          int hour = int.parse(timeParts[0]);
          final minute = timeParts[1];
          final period = parts[1].toUpperCase();

          if (period == "PM" && hour != 12) hour += 12;
          if (period == "AM" && hour == 12) hour = 0;

          formattedTime = "${hour.toString().padLeft(2, '0')}:$minute:00";
        }
      }

      final startDate = "${data.date}T$formattedTime";
      
      if (data.tripId != null) {
        await apiService.updateTrip(
          id: data.tripId!,
          details: data.notes.trim(),
          fromCity: data.from.trim(),
          toCity: data.to.trim(),
          startDate: startDate,
          pricePerSet: double.tryParse(data.price.trim()) ?? 0.0,
          duration: data.duration.trim(),
          vehicleID: data.vehicleID ?? 0,
        );
      } else {
        await apiService.createTrip(
          details: data.notes.trim(),
          fromCity: data.from.trim(),
          toCity: data.to.trim(),
          startDate: startDate,
          pricePerSet: double.tryParse(data.price.trim()) ?? 0.0,
          duration: data.duration.trim(),
          vehicleID: data.vehicleID!,
        );
      }
      emit(data.copyWith(isPublishing: false));
      return true;
    } catch (e) {
      String message = e.toString();
      if (e is ServerException) {
        message = e.errorModel.errorMessage;
      }
      emit(data.copyWith(isPublishing: false, errorMessage: message));
      return false;
    }
  }
}
