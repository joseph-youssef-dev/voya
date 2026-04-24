import 'package:flutter/foundation.dart';
import 'package:voya/core/databases/api/api_consumer.dart';
import 'package:voya/core/constants/end_points.dart';
import 'package:dio/dio.dart';
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
    String? profileImagePath,
  }) async {
    debugPrint(
      '📤 Sending update: FirstName=$firstName, LastName=$lastName, '
      'BirthDate=$birthDate, Phone=$phone, Town=$town, '
      'hasImage=${profileImagePath != null}',
    );

    // Always send as FormData (backend expects multipart/form-data)
    final Map<String, dynamic> fields = {
      'FirstName': firstName,
      'LastName': lastName,
      'BirthDate': birthDate,
      'Phone': phone,
      'Town': town,
    };

    if (profileImagePath != null) {
      fields['ProfileImage'] = await MultipartFile.fromFile(
        profileImagePath,
        filename: profileImagePath.split('/').last,
      );
    }

    // Try PUT (most common for full update)
    try {
      final response = await api.put(
        EndPoints.updatePassengerProfile,
        data: fields,
        isFormData: true, // always FormData
      );
      debugPrint('✅ PUT response: $response');
      return;
    } catch (e) {
      debugPrint('⚠️ PUT failed: $e — trying PATCH...');
    }

    // Fallback: try PATCH
    try {
      final response = await api.patch(
        EndPoints.updatePassengerProfile,
        data: fields,
        isFormData: true, // always FormData
      );
      debugPrint('✅ PATCH response: $response');
      return;
    } catch (e) {
      debugPrint('❌ PATCH also failed: $e');
      rethrow;
    }
  }
}
