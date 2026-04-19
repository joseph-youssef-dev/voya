import 'package:voya/core/constants/end_points.dart';
import 'package:voya/core/databases/api/api_consumer.dart';
import '../models/login_request_model.dart';

class LoginApiService {
  final ApiConsumer api;

  LoginApiService({required this.api});

  Future<dynamic> login(LoginRequestModel request) async {
    final response = await api.post(EndPoints.login, data: request.toJson());
    return response;
  }
}
