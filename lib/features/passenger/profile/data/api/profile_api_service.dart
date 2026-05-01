import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:voya/core/databases/api/api_consumer.dart';
import 'package:voya/core/constants/end_points.dart';
import 'package:voya/core/errors/expentions.dart';
import '../models/passenger_profile_model.dart';

class ProfileApiService {
  final ApiConsumer api;

  ProfileApiService({required this.api});

  Future<PassengerProfileModel> getProfile() async {
    final response = await api.get(EndPoints.getPassengerProfile);
    debugPrint('📥 GetProfile response: $response');

    if (response is Map<String, dynamic> && response.containsKey('data')) {
      return PassengerProfileModel.fromJson(response['data']);
    }
    if (response is Map<String, dynamic>) {
      return PassengerProfileModel.fromJson(response);
    }

    throw Exception('Failed to load profile');
  }

  Future<void> updateProfile({
    required String firstName,
    required String lastName,
    required String birthDate,
    required String phone,
    required String town,
    required String ssn,
    String? profileImagePath,
  }) async {
    final Map<String, dynamic> data = {
      'FirstName': firstName,
      'LastName': lastName,
      'BirthDate': birthDate,
      'Phone': phone,
      'Town': town,
      'SSN': ssn,
    };

    if (profileImagePath != null && profileImagePath.isNotEmpty) {
      data['ProfileImage'] = await MultipartFile.fromFile(
        profileImagePath,
        filename: profileImagePath.split('/').last,
      );
    }

    try {
      await api.put(
        EndPoints.updatePassengerProfile,
        data: data,
        isFormData: true,
      );
    } on ServerException catch (e) {
      debugPrint('❌ Update Profile ServerError: ${e.errorModel.errorMessage}');
      rethrow;
    } catch (e) {
      debugPrint('❌ Update Profile Error: $e');
      rethrow;
    }
  }
}
