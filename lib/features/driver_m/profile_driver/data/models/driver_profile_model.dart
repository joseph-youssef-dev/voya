class DriverProfileModel {
  final String fullName;
  final String phone;
  final String town;
  final String birthDate;
  final String ssn;
  final String status;
  final String? profileImage;
  final List<VehicleModel> vehicles;

  DriverProfileModel({
    required this.fullName,
    required this.phone,
    required this.town,
    required this.birthDate,
    required this.ssn,
    required this.status,
    this.profileImage,
    required this.vehicles,
  });

  factory DriverProfileModel.fromJson(Map<String, dynamic> json) {
    return DriverProfileModel(
      fullName: json['fullName'] ?? json['FullName'] ?? '',
      phone: json['phoneNumber'] ?? json['PhoneNumber'] ?? json['phone'] ?? '',
      town: json['town'] ?? json['Town'] ?? '',
      birthDate: json['birthDate'] ?? json['BirthDate'] ?? '',
      ssn: json['ssn'] ?? json['SSN'] ?? '',
      status: json['status'] ?? json['Status'] ?? '',
      profileImage: json['profileImage'] ?? json['ProfileImage'],
      vehicles: (json['vehicles'] as List? ?? json['Vehicles'] as List? ?? [])
              .map((v) => VehicleModel.fromJson(v as Map<String, dynamic>))
              .toList(),
    );
  }
}

class VehicleModel {
  final int id;
  final String model;
  final String color;
  final String vehicleLicense;
  final int numberOfPassengers;
  final String? image;
  final String? features;

  VehicleModel({
    required this.id,
    required this.model,
    required this.color,
    required this.vehicleLicense,
    required this.numberOfPassengers,
    this.image,
    this.features,
  });

  factory VehicleModel.fromJson(Map<String, dynamic> json) {
    return VehicleModel(
      id: json['id'] ?? json['Id'] ?? 0,
      model: json['model'] ?? json['Model'] ?? '',
      color: json['color'] ?? json['Color'] ?? '',
      vehicleLicense: json['vehicleLicense'] ?? json['VehicleLicense'] ?? '',
      numberOfPassengers: json['numberOfPassangers'] ?? json['NumberOfPassangers'] ?? 0,
      image: json['image'] ?? json['Image'],
      features: json['features'] ?? json['Features'],
    );
  }
}
