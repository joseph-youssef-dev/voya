import 'package:flutter/material.dart';
import 'package:voya/core/databases/api/api_consumer.dart';
import 'package:voya/core/constants/end_points.dart';
import '../models/driver_profile_model.dart';

class DriverProfileApiService {
  final ApiConsumer api;

  DriverProfileApiService({required this.api});

  Future<DriverProfileModel> getProfile() async {
    try {
      debugPrint(
        '🚀 Fetching Driver Profile from: ${EndPoints.getDriverProfile}',
      );
      final response = await api.get(EndPoints.getDriverProfile);
      debugPrint('📥 Raw Driver Profile response: $response');

      if (response == null) {
        throw Exception('Received null response from server');
      }

      if (response is Map<String, dynamic>) {
        final Map<String, dynamic> data =
            (response.containsKey('data') && response['data'] != null)
            ? Map<String, dynamic>.from(response['data'])
            : Map<String, dynamic>.from(response);

        if (response.containsKey('data') && response['data'] != null) {
          debugPrint('✅ Found data object, parsing...');
          return DriverProfileModel.fromJson(data);
        }
        debugPrint('ℹ️ No data object found, parsing root object...');
        return DriverProfileModel.fromJson(data);
      }

      throw Exception('Unexpected response format: ${response.runtimeType}');
    } catch (e) {
      debugPrint('❌ GetDriverProfile error: $e');
      rethrow;
    }
  }
}
