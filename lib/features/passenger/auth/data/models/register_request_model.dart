import 'dart:io';
import 'package:dio/dio.dart';

class RegisterRequestModel {
  final String ssn;
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final File? profileImage;
  final String birthDate;
  final String phone;
  final String town;

  RegisterRequestModel({
    required this.ssn,
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    this.profileImage,
    required this.birthDate,
    required this.phone,
    required this.town,
  });

  Future<Map<String, dynamic>> toFormDataMap() async {
    final map = <String, dynamic>{
      'SSN': ssn,
      'Email': email,
      'Password': password,
      'FirstName': firstName,
      'LastName': lastName,
      'BirthDate': birthDate,
      'Phone': phone,
      'Town': town,
    };

    if (profileImage != null) {
      map['ProfileImage'] = await MultipartFile.fromFile(
        profileImage!.path,
        filename: profileImage!.path.split('/').last,
      );
    }

    return map;
  }
}
