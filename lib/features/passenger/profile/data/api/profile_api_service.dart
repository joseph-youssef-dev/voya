import 'package:voya/core/databases/api/api_consumer.dart';
import 'package:voya/core/constants/end_points.dart';
import '../models/passenger_profile_model.dart';

class ProfileApiService {
  final ApiConsumer api;

  ProfileApiService({required this.api});

  Future<PassengerProfileModel> getProfile() async {
    final response = await api.get(EndPoints.getPassengerProfile);

    if (response is Map<String, dynamic> && response.containsKey('data')) {
      return PassengerProfileModel.fromJson(response['data']);
    }

    throw Exception('Failed to load profile');
  }
}
