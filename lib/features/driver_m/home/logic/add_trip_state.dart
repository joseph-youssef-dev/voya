import 'package:voya/features/driver_m/profile_driver/data/models/driver_profile_model.dart';

abstract class AddTripState {}

class AddTripInitial extends AddTripState {}

class AddTripStateData extends AddTripState {
  final int? tripId;
  final int seats;
  final String from;
  final String to;
  final String date;
  final String time;
  final String price;
  final String notes;
  final String duration;
  final int? vehicleID;
  final List<VehicleModel> vehicles;
  final bool isLoadingVehicles;
  final bool isPublishing;
  final String? errorMessage;

  AddTripStateData({
    this.tripId,
    required this.seats,
    required this.from,
    required this.to,
    required this.date,
    required this.time,
    required this.price,
    required this.notes,
    this.duration = '',
    this.vehicleID,
    this.vehicles = const [],
    this.isLoadingVehicles = false,
    this.isPublishing = false,
    this.errorMessage,
  });

  AddTripStateData copyWith({
    int? tripId,
    int? seats,
    String? from,
    String? to,
    String? date,
    String? time,
    String? price,
    String? notes,
    String? duration,
    int? vehicleID,
    List<VehicleModel>? vehicles,
    bool? isLoadingVehicles,
    bool? isPublishing,
    String? errorMessage,
    bool clearError = false,
  }) {
    return AddTripStateData(
      tripId: tripId ?? this.tripId,
      seats: seats ?? this.seats,
      from: from ?? this.from,
      to: to ?? this.to,
      date: date ?? this.date,
      time: time ?? this.time,
      price: price ?? this.price,
      notes: notes ?? this.notes,
      duration: duration ?? this.duration,
      vehicleID: vehicleID ?? this.vehicleID,
      vehicles: vehicles ?? this.vehicles,
      isLoadingVehicles: isLoadingVehicles ?? this.isLoadingVehicles,
      isPublishing: isPublishing ?? this.isPublishing,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}
