import 'package:voya/core/databases/api/api_consumer.dart';
import 'package:voya/core/constants/end_points.dart';
import '../models/driver_profile_model.dart';

class DriverProfileApiService {
  final ApiConsumer api;

  DriverProfileApiService({required this.api});

  Future<DriverProfileModel> getProfile() async {
    final response = await api.get(EndPoints.getDriverProfile);

    if (response is Map<String, dynamic> && response.containsKey('data')) {
      return DriverProfileModel.fromJson(response['data']);
    }
    if (response is Map<String, dynamic>) {
      return DriverProfileModel.fromJson(response);
    }

    throw Exception('Failed to load driver profile');
  }
}
