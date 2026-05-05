import 'package:voya/core/databases/api/api_consumer.dart';
import 'package:voya/core/constants/end_points.dart';

class SharedAuthApiService {
  final ApiConsumer api;

  SharedAuthApiService({required this.api});

  Future<dynamic> verifyOtp({required String email, required String otp}) async {
    final response = await api.post(
      EndPoints.verifyEmail,
      data: {
        'email': email,
        'otpCode': otp,
      },
    );
    return response;
  }

  Future<dynamic> forgetPassword({required String email}) async {
    final response = await api.post(
      EndPoints.forgetPassword,
      data: {'email': email},
    );
    return response;
  }

  Future<dynamic> resetPassword({
    required String email,
    required String token,
    required String otp,
    required String newPassword,
  }) async {
    final response = await api.post(
      EndPoints.resetPassword,
      data: {
        'email': email,
        'token': token,
        'otpCode': otp,
        'newPassword': newPassword,
      },
    );
    return response;
  }

  Future<dynamic> resendOtp({required String email}) async {
    final response = await api.post(
      EndPoints.resendOtp,
      data: {'email': email},
    );
    return response;
  }
}
