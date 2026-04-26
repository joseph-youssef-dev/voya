import 'dart:io';
import 'package:dio/dio.dart';

class VehicleRequestModel {
  final String model;
  final String color;
  final int numberOfPassengers;
  final List<File> images;

  VehicleRequestModel({
    required this.model,
    required this.color,
    required this.numberOfPassengers,
    required this.images,
  });
}

class DriverLicenseRequestModel {
  final String licenseNumber;
  final String expiryDate;
  final File? licenseImage;

  DriverLicenseRequestModel({
    required this.licenseNumber,
    required this.expiryDate,
    this.licenseImage,
  });
}

class DriverRegisterRequestModel {
  final String ssn;
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final File? profileImage;
  final String phone;
  final String town;
  final String birthDate;
  final VehicleRequestModel vehicle;
  final DriverLicenseRequestModel driverLicense;

  DriverRegisterRequestModel({
    required this.ssn,
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    this.profileImage,
    required this.phone,
    required this.town,
    required this.birthDate,
    required this.vehicle,
    required this.driverLicense,
  });

  Future<Map<String, dynamic>> toFormDataMap() async {
    final map = <String, dynamic>{
      'SSN': ssn,
      'Email': email,
      'Password': password,
      'FirstName': firstName,
      'LastName': lastName,
      'Phone': phone,
      'Town': town,
      'BirthDate': birthDate,
      'DriverLicense.LicenseNumber': driverLicense.licenseNumber,
      'DriverLicense.ExpiryDate': driverLicense.expiryDate,
      'Vehicles[0].Model': vehicle.model,
      'Vehicles[0].Color': vehicle.color,
      'Vehicles[0].NumberOfPassangers': vehicle.numberOfPassengers,
    };

    if (profileImage != null) {
      map['ProfileImage'] = await MultipartFile.fromFile(
        profileImage!.path,
        filename: profileImage!.path.split('/').last,
      );
    }

    if (driverLicense.licenseImage != null) {
      map['DriverLicense.LicenseImage'] = await MultipartFile.fromFile(
        driverLicense.licenseImage!.path,
        filename: driverLicense.licenseImage!.path.split('/').last,
      );
    }

    // Add vehicle images
    for (int i = 0; i < vehicle.images.length; i++) {
      map['Vehicles[0].Images'] = await MultipartFile.fromFile(
        vehicle.images[i].path,
        filename: vehicle.images[i].path.split('/').last,
      );
    }

    return map;
  }
}
