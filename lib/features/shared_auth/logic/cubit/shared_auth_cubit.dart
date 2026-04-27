import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voya/core/databases/cache/cache_helper.dart';
import '../../data/api/shared_auth_api_service.dart';
import 'shared_auth_state.dart';

class SharedAuthCubit extends Cubit<SharedAuthState> {
  final SharedAuthApiService apiService;

  SharedAuthCubit({required this.apiService}) : super(SharedAuthInitial());

  Future<void> verifyOtp({required String email, required String otp}) async {
    emit(SharedAuthLoading());
    try {
      final response = await apiService.verifyOtp(
        email: email.trim(), 
        otp: otp.trim(),
      );
      final message = response is Map<String, dynamic> && response.containsKey('message')
          ? response['message']
          : 'OTP Verified successfully';
      await CacheHelper().saveData(key: 'isLoggedIn', value: true);
      emit(SharedAuthSuccess(message: message));
    } catch (e) {
      emit(SharedAuthFailure(errorMessage: e.toString()));
    }
  }

  Future<void> forgetPassword({required String email}) async {
    emit(SharedAuthLoading());
    try {
      final response = await apiService.forgetPassword(email: email.trim());
      final message = response is Map<String, dynamic> && response.containsKey('message')
          ? response['message']
          : 'OTP sent to your email';
      emit(SharedAuthSuccess(message: message));
    } catch (e) {
      emit(SharedAuthFailure(errorMessage: e.toString()));
    }
  }

  Future<void> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
  }) async {
    emit(SharedAuthLoading());
    try {
      final token = CacheHelper().getData(key: 'token') ?? '';
      final response = await apiService.resetPassword(
        email: email.trim(),
        token: token,
        otp: otp.trim(),
        newPassword: newPassword.trim(),
      );
      final message = response is Map<String, dynamic> && response.containsKey('message')
          ? response['message']
          : 'Password reset successfully';
      emit(SharedAuthSuccess(message: message));
    } catch (e) {
      emit(SharedAuthFailure(errorMessage: e.toString()));
    }
  }
}
