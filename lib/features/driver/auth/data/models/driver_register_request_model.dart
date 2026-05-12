import 'dart:io';
import 'package:dio/dio.dart';

class VehicleRequestModel {
  final String model;
  final String color;
  final String vehicleLicense;
  final int numberOfPassengers;
  final List<File> images;

  VehicleRequestModel({
    required this.model,
    required this.color,
    required this.vehicleLicense,
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
    String getFileName(File file) => file.path.split(RegExp(r'[/\\]')).last;

    final map = <String, dynamic>{
      'SSN': ssn.trim(),
      'Email': email.trim(),
      'Password': password.trim(),
      'FirstName': firstName.trim(),
      'LastName': lastName.trim(),
      'Phone': phone.trim(),
      'Town': town.trim(),
      'BirthDate': birthDate.trim(),
      'Vehicles[0].Model': vehicle.model.trim(),
      'Vehicles[0].Color': vehicle.color.trim(),
      'Vehicles[0].VehicleLicense': vehicle.vehicleLicense.trim(),
      'Vehicles[0].NumberOfPassangers': vehicle.numberOfPassengers.toString(),
      'DriverLicense.LicenseNumber': driverLicense.licenseNumber.trim(),
      'DriverLicense.ExpiryDate': driverLicense.expiryDate.trim(),
    };

    if (profileImage != null) {
      map['ProfileImage'] = await MultipartFile.fromFile(
        profileImage!.path,
        filename: getFileName(profileImage!),
      );
    }

    if (driverLicense.licenseImage != null) {
      map['DriverLicense.LicenseImage'] = await MultipartFile.fromFile(
        driverLicense.licenseImage!.path,
        filename: getFileName(driverLicense.licenseImage!),
      );
    }

    // Add multiple vehicle images
    if (vehicle.images.isNotEmpty) {
      final List<MultipartFile> multipartImages = [];
      for (var file in vehicle.images) {
        multipartImages.add(
          await MultipartFile.fromFile(
            file.path,
            filename: getFileName(file),
          ),
        );
      }
      map['Vehicles[0].Images'] = multipartImages;
    }

    return map;
  }
}
