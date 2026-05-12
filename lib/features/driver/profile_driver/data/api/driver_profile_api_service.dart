import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:voya/core/databases/api/api_consumer.dart';
import 'package:voya/core/constants/end_points.dart';
import 'package:voya/core/errors/expentions.dart';
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

    debugPrint('📤 Updating Driver Profile with data: $data');

    try {
      final response = await api.post(
        EndPoints.updateDriverProfile,
        data: data,
        isFormData: true,
      );
      debugPrint('✅ Update Profile Response: $response');
    } on ServerException catch (e) {
      debugPrint('❌ Update Profile ServerError: ${e.errorModel.errorMessage}');
      debugPrint('❌ Update Profile Status Code: ${e.errorModel.status}');
      rethrow;
    } on DioException catch (e) {
      debugPrint('❌ Update Profile DioError: ${e.response?.data}');
      rethrow;
    } catch (e) {
      debugPrint('❌ Update Profile Error: $e');
      rethrow;
    }
  }

  Future<void> addVehicle({
    required String model,
    required String color,
    required String vehicleLicense,
    required int numberOfPassengers,
  }) async {
    final Map<String, dynamic> data = {
      'Model': model,
      'Color': color,
      'VehicleLicense': vehicleLicense,
      'NumberOfPassangers': numberOfPassengers,
    };

    await api.post(EndPoints.addVehicle, data: data, isFormData: true);
  }

  Future<void> updateVehicle({
    required int id,
    required String model,
    required String color,
    required String vehicleLicense,
    required int numberOfPassengers,
  }) async {
    final Map<String, dynamic> data = {
      'Model': model,
      'Color': color,
      'VehicleLicense': vehicleLicense,
      'NumberOfPassangers': numberOfPassengers,
    };

    await api.put(
      EndPoints.updateVehicle.replaceAll('{id}', id.toString()),
      data: data,
      isFormData: true,
    );
  }

  Future<void> deleteVehicle(int id) async {
    await api.delete(EndPoints.deleteVehicle.replaceAll('{id}', id.toString()));
  }
}
