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
  final String status;

  final int vechileId;

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
    required this.status,
    required this.vechileId,
  });

  factory TripModel.fromJson(Map<String, dynamic> json) {
    return TripModel(
      id: json['id'] ?? json['Id'] ?? 0,
      fromCity: json['fromCity'] ?? json['FromCity'] ?? '',
      toCity: json['toCity'] ?? json['ToCity'] ?? '',
      details: json['details'] ?? json['Details'] ?? '',
      duration: (json['duration'] ?? json['Duration'] ?? 0.0).toDouble(),
      startDate: json['startDate'] ?? json['StartDate'] ?? '',
      pricePerSet: (json['pricePerSet'] ?? json['PricePerSet'] ?? 0.0).toDouble(),
      driverName: json['driverName'] ?? json['DriverName'] ?? '',
      vehicleModel: json['vehicleModel'] ?? json['VehicleModel'] ?? '',
      distance: (json['distance'] ?? json['Distance'] ?? 0.0).toDouble(),
      availableSeats: json['availableSeats'] ?? json['AvailableSeats'] ?? json['numberOfPassangers'] ?? 0,
      features: json['features'] ?? json['Features'] ?? [],
      status: json['status'] ?? json['Status'] ?? 'Pending',
      vechileId: json['vechileId'] ?? json['VechileID'] ?? json['vechileID'] ?? 0,
    );
  }
}
