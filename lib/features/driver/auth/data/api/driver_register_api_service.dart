import 'package:voya/core/databases/api/api_consumer.dart';
import 'package:voya/core/constants/end_points.dart';
import '../models/driver_register_request_model.dart';

class DriverRegisterApiService {
  final ApiConsumer api;

  DriverRegisterApiService({required this.api});

  Future<dynamic> registerDriver(DriverRegisterRequestModel request) async {
    final data = await request.toFormDataMap();
    final response = await api.post(
      EndPoints.registerDriver,
      data: data,
      isFormData: true,
    );
    return response;
  }
}
