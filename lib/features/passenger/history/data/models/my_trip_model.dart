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
  final String? driverImage;
  final String? vechileImage;

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
    this.driverImage,
    this.vechileImage,
  });

  factory MyTripModel.fromJson(Map<String, dynamic> json) {
    return MyTripModel(
      id: json['id'] ?? 0,
      fromCity: json['startLocation'] ?? json['fromCity'] ?? 'Unknown',
      toCity: json['endLocation'] ?? json['toCity'] ?? 'Unknown',
      startDate: json['startDate'] ?? '',
      pricePerSet: json['pricePerSet'] != null 
          ? json['pricePerSet'].toDouble() 
          : (json['totalPrice'] != null && (json['numberOfSeats'] ?? json['seats'] ?? 1) > 0 
              ? (json['totalPrice'] / (json['numberOfSeats'] ?? json['seats'] ?? 1)).toDouble() 
              : 0.0),
      driverName: json['driverName'] ?? 'Unknown Driver',
      vehicleModel: json['vehicleModel'] ?? '',
      availableSeats: json['availableSeats'] ?? 0,
      status: _parseStatus(json),
      numberOfSeats: json['seats'] ?? json['numberOfSeats'] ?? json['NumberOfSeats'] ?? json['numberOfPassangers'] ?? 1,
      driverImage: json['driverImage'],
      vechileImage: json['vechileImage'] ?? json['vehicleImage'],
    );
  }

  static String _parseStatus(Map<String, dynamic> json) {
    final val = json['status'] ?? json['bookingStatus'] ?? json['BookingStatus'];
    if (val == null) return 'pending';
    final str = val.toString().toLowerCase().trim();
    if (str == 'pending' || str == 'successful' || str == 'rejected') return str;
    if (str.contains('adminapproval') || str == 'accepted' || str == 'successful') return 'successful';
    if (str.contains('reject')) return 'rejected';
    return str;
  }
}
