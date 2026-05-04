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
    String getFileName(File file) => file.path.split(RegExp(r'[/\\]')).last;

    final map = <String, dynamic>{
      'SSN': ssn.trim(),
      'Email': email.trim(),
      'Password': password.trim(),
      'FirstName': firstName.trim(),
      'LastName': lastName.trim(),
      'BirthDate': birthDate.trim(),
      'Phone': phone.trim(),
      'Town': town.trim(),
    };

    if (profileImage != null) {
      map['ProfileImage'] = await MultipartFile.fromFile(
        profileImage!.path,
        filename: getFileName(profileImage!),
      );
    }

    return map;
  }
}
