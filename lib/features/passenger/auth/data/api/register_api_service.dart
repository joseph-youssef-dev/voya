import 'package:voya/core/databases/api/api_consumer.dart';
import 'package:voya/core/constants/end_points.dart';
import '../models/register_request_model.dart';

class RegisterApiService {
  final ApiConsumer api;

  RegisterApiService({required this.api});

  Future<dynamic> registerPassenger(RegisterRequestModel request) async {
    final data = await request.toFormDataMap();
    final response = await api.post(
      EndPoints.registerPassenger,
      data: data,
      isFormData: true,
    );
    return response;
  }
}
