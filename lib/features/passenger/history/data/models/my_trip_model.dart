class MyTripModel {
  final int id;
  final String fromCity;
  final String toCity;
  final String startDate;
  final double pricePerSet;
  final String driverName;
  final String vehicleModel;
  final int availableSeats;
  final String status;
  final int numberOfSeats;

  MyTripModel({
    required this.id,
    required this.fromCity,
    required this.toCity,
    required this.startDate,
    required this.pricePerSet,
    required this.driverName,
    required this.vehicleModel,
    required this.availableSeats,
    required this.status,
    required this.numberOfSeats,
  });

  factory MyTripModel.fromJson(Map<String, dynamic> json) {
    return MyTripModel(
      id: json['id'] ?? 0,
      fromCity: json['fromCity'] ?? '',
      toCity: json['toCity'] ?? '',
      startDate: json['startDate'] ?? '',
      pricePerSet: (json['pricePerSet'] ?? 0.0).toDouble(),
      driverName: json['driverName'] ?? '',
      vehicleModel: json['vehicleModel'] ?? '',
      availableSeats: json['availableSeats'] ?? 0,
      status: json['status'] ?? 'Pending',
      numberOfSeats: json['numberOfPassangers'] ?? 1,
    );
  }
}
