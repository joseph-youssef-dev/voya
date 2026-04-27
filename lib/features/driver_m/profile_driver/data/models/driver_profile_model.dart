class DriverProfileModel {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String town;
  final String birthDate;
  final String ssn;
  final String? profileImage;
  final List<VehicleModel> vehicles;
  final LicenseModel? license;

  DriverProfileModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.town,
    required this.birthDate,
    required this.ssn,
    this.profileImage,
    required this.vehicles,
    this.license,
  });

  factory DriverProfileModel.fromJson(Map<String, dynamic> json) {
    return DriverProfileModel(
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      town: json['town'] ?? '',
      birthDate: json['birthDate'] ?? '',
      ssn: json['ssn'] ?? '',
      profileImage: json['profileImage'],
      vehicles: (json['vehicles'] as List?)
              ?.map((v) => VehicleModel.fromJson(v))
              .toList() ??
          [],
      license: json['driverLicense'] != null
          ? LicenseModel.fromJson(json['driverLicense'])
          : null,
    );
  }
}

class VehicleModel {
  final int id;
  final String model;
  final String color;
  final int numberOfPassengers;
  final List<String> images;

  VehicleModel({
    required this.id,
    required this.model,
    required this.color,
    required this.numberOfPassengers,
    required this.images,
  });

  factory VehicleModel.fromJson(Map<String, dynamic> json) {
    return VehicleModel(
      id: json['id'] ?? 0,
      model: json['model'] ?? '',
      color: json['color'] ?? '',
      numberOfPassengers: json['numberOfPassangers'] ?? 0,
      images: (json['images'] as List?)?.map((i) => i.toString()).toList() ?? [],
    );
  }
}

class LicenseModel {
  final String licenseNumber;
  final String expiryDate;
  final String? licenseImage;

  LicenseModel({
    required this.licenseNumber,
    required this.expiryDate,
    this.licenseImage,
  });

  factory LicenseModel.fromJson(Map<String, dynamic> json) {
    return LicenseModel(
      licenseNumber: json['licenseNumber'] ?? '',
      expiryDate: json['expiryDate'] ?? '',
      licenseImage: json['licenseImage'],
    );
  }
}
