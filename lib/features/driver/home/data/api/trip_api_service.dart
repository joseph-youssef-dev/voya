import 'package:voya/core/databases/api/api_consumer.dart';
import 'package:voya/core/constants/end_points.dart';
import 'package:voya/features/driver/profile_driver/data/models/driver_profile_model.dart';

class TripApiService {
  final ApiConsumer api;

  TripApiService({required this.api});

  Future<List<VehicleModel>> getVehicles() async {
    final response = await api.get(EndPoints.getVehicles);
    if (response is Map<String, dynamic> && response['data'] != null) {
      final List dataList = response['data'] as List;
      return dataList
          .map((v) => VehicleModel.fromJson(v as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  Future<List<dynamic>> getDriverTrips() async {
    final response = await api.get(EndPoints.getDriverTrips);
    if (response is Map<String, dynamic> && response['data'] != null) {
      return response['data'] as List;
    }
    return [];
  }

  Future<dynamic> createTrip({
    required String details,
    required String fromCity,
    required String toCity,
    required String startDate,
    required double pricePerSet,
    required String duration,
    required int vehicleID,
  }) async {
    final response = await api.post(
      EndPoints.createTrip,
      isFormData: true,
      data: {
        'Details': details,
        'FromCity': fromCity,
        'ToCity': toCity,
        'StartDate': startDate,
        'PricePerSet': pricePerSet,
        'Duration': duration,
        'VechileID': vehicleID,
      },
    );
    return response;
  }

  Future<dynamic> updateTrip({
    required int id,
    required String details,
    required String fromCity,
    required String toCity,
    required String startDate,
    required double pricePerSet,
    required String duration,
    required int vehicleID,
  }) async {
    final response = await api.post(
      EndPoints.updateTrip.replaceFirst('{id}', id.toString()),
      isFormData: true,
      data: {
        'Details': details,
        'FromCity': fromCity,
        'ToCity': toCity,
        'StartDate': startDate,
        'PricePerSet': pricePerSet,
        'Duration': duration,
        'VechileID': vehicleID,
      },
    );
    return response;
  }
}
