import 'package:flutter/material.dart';
import 'package:voya/core/databases/api/api_consumer.dart';
import 'package:voya/core/constants/end_points.dart';
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
  }) async {
    final Map<String, dynamic> data = {
      'FirstName': firstName,
      'LastName': lastName,
      'BirthDate': birthDate,
      'Phone': phone,
      'Town': town,
    };

    await api.put(
      EndPoints.updatePassengerProfile,
      data: data,
      isFormData: true,
    );
  }
}
