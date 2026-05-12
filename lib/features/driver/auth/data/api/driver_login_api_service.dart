import 'package:voya/core/constants/end_points.dart';
import 'package:voya/core/databases/api/api_consumer.dart';
import '../models/driver_login_request_model.dart';

class DriverLoginApiService {
  final ApiConsumer api;

  DriverLoginApiService({required this.api});

  Future<dynamic> login(DriverLoginRequestModel request) async {
    final response = await api.post(EndPoints.login, data: request.toJson());
    return response;
  }
}
