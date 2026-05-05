import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voya/core/databases/cache/cache_helper.dart';
import 'package:voya/core/errors/error_model.dart';
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
      dynamic parsedResponse = response;
      if (parsedResponse is String) {
        try {
          parsedResponse = jsonDecode(parsedResponse);
        } catch (_) {}
      }

      if (parsedResponse is Map<String, dynamic>) {
        final bool isSuccess =
            parsedResponse['isSuccess'] ??
            parsedResponse['IsSuccess'] ??
            parsedResponse['success'] ??
            true;
        if (!isSuccess) {
          final errModel = ErrorModel.fromJson(parsedResponse);
          emit(SharedAuthFailure(errorMessage: errModel.errorMessage));
          return;
        }
      }

      final message = parsedResponse is Map<String, dynamic>
          ? (parsedResponse['message'] ??
                parsedResponse['Message'] ??
                parsedResponse['data'] ??
                'OTP Verified successfully')
          : 'OTP Verified successfully';

      // Save token if present in verification response
      if (parsedResponse is Map<String, dynamic>) {
        final data = parsedResponse['data'] ?? parsedResponse;
        if (data is Map<String, dynamic>) {
          if (data['token'] != null) {
            await CacheHelper().saveData(
              key: 'token',
              value: data['token'].toString(),
            );
          }
          if (data['refreshToken'] != null) {
            await CacheHelper().saveData(
              key: 'refreshToken',
              value: data['refreshToken'].toString(),
            );
          }
        }
      }

      await CacheHelper().saveData(key: 'email', value: email.trim());
      await CacheHelper().saveData(key: 'isLoggedIn', value: true);

      emit(SharedAuthVerifySuccess(message: message.toString()));
    } catch (e) {
      emit(SharedAuthFailure(errorMessage: e.toString()));
    }
  }

  Future<void> forgetPassword({required String email}) async {
    emit(SharedAuthLoading());
    try {
      final response = await apiService.forgetPassword(email: email.trim());
      dynamic parsedResponse = response;
      if (parsedResponse is String) {
        try {
          parsedResponse = jsonDecode(parsedResponse);
        } catch (_) {}
      }

      if (parsedResponse is Map<String, dynamic>) {
        final bool isSuccess =
            parsedResponse['isSuccess'] ??
            parsedResponse['IsSuccess'] ??
            parsedResponse['success'] ??
            true;
        if (!isSuccess) {
          final errModel = ErrorModel.fromJson(parsedResponse);
          emit(SharedAuthFailure(errorMessage: errModel.errorMessage));
          return;
        }
      }
      final message = parsedResponse is Map<String, dynamic>
          ? (parsedResponse['message'] ??
                parsedResponse['Message'] ??
                'OTP sent to your email')
          : 'OTP sent to your email';
      emit(SharedAuthSuccess(message: message.toString()));
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
      dynamic parsedResponse = response;
      if (parsedResponse is String) {
        try {
          parsedResponse = jsonDecode(parsedResponse);
        } catch (_) {}
      }

      if (parsedResponse is Map<String, dynamic>) {
        final bool isSuccess =
            parsedResponse['isSuccess'] ??
            parsedResponse['IsSuccess'] ??
            parsedResponse['success'] ??
            true;
        if (!isSuccess) {
          final errModel = ErrorModel.fromJson(parsedResponse);
          emit(SharedAuthFailure(errorMessage: errModel.errorMessage));
          return;
        }
      }
      final message = parsedResponse is Map<String, dynamic>
          ? (parsedResponse['message'] ??
                parsedResponse['Message'] ??
                'Password reset successfully')
          : 'Password reset successfully';
      emit(SharedAuthSuccess(message: message.toString()));
    } catch (e) {
      emit(SharedAuthFailure(errorMessage: e.toString()));
    }
  }

  Future<void> resendOtp({required String email}) async {
    emit(SharedAuthLoading());
    try {
      final response = await apiService.resendOtp(email: email.trim());
      dynamic parsedResponse = response;
      if (parsedResponse is String) {
        try {
          parsedResponse = jsonDecode(parsedResponse);
        } catch (_) {}
      }

      if (parsedResponse is Map<String, dynamic>) {
        final bool isSuccess =
            parsedResponse['isSuccess'] ??
            parsedResponse['IsSuccess'] ??
            parsedResponse['success'] ??
            true;
        if (!isSuccess) {
          final errModel = ErrorModel.fromJson(parsedResponse);
          emit(SharedAuthFailure(errorMessage: errModel.errorMessage));
          return;
        }
      }
      final message = parsedResponse is Map<String, dynamic>
          ? (parsedResponse['message'] ??
                parsedResponse['Message'] ??
                'OTP Resent successfully')
          : 'OTP Resent successfully';
      emit(SharedAuthResendSuccess(message: message.toString()));
    } catch (e) {
      emit(SharedAuthFailure(errorMessage: e.toString()));
    }
  }
}
