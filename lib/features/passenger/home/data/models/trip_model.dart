class TripModel {
  final int id;
  final String fromCity;
  final String toCity;
  final String details;
  final double duration;
  final String startDate;
  final double pricePerSet;
  final String driverName;
  final String vehicleModel;
  final double distance;
  final int availableSeats;
  final List<dynamic> features;

  TripModel({
    required this.id,
    required this.fromCity,
    required this.toCity,
    required this.details,
    required this.duration,
    required this.startDate,
    required this.pricePerSet,
    required this.driverName,
    required this.vehicleModel,
    required this.distance,
    required this.availableSeats,
    required this.features,
  });

  factory TripModel.fromJson(Map<String, dynamic> json) {
    return TripModel(
      id: json['id'] ?? 0,
      fromCity: json['fromCity'] ?? '',
      toCity: json['toCity'] ?? '',
      details: json['details'] ?? '',
      duration: (json['duration'] ?? 0.0).toDouble(),
      startDate: json['startDate'] ?? '',
      pricePerSet: (json['pricePerSet'] ?? 0.0).toDouble(),
      driverName: json['driverName'] ?? '',
      vehicleModel: json['vehicleModel'] ?? '',
      distance: (json['distance'] ?? 0.0).toDouble(),
      availableSeats: json['availableSeats'] ?? 0,
      features: json['features'] ?? [],
    );
  }
}
