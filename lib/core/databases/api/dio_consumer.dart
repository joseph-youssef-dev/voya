import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:voya/core/constants/end_points.dart';
import 'package:voya/core/databases/api/api_consumer.dart';
import 'package:voya/core/errors/expentions.dart';
import 'package:voya/core/databases/cache/cache_helper.dart';

class DioConsumer extends ApiConsumer {
  final Dio dio;

  DioConsumer({required this.dio}) {
    dio.options.baseUrl = EndPoints.baserUrl;
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final token = CacheHelper().getData(key: 'token');
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (DioException e, handler) async {
          // Do not attempt to refresh token for auth endpoints (login/register)
          final String path = e.requestOptions.path;
          final bool isAuthPath = path.contains(EndPoints.login) || 
                                 path.contains(EndPoints.registerPassenger) || 
                                 path.contains(EndPoints.registerDriver);

          if (e.response?.statusCode == 401 && !isAuthPath) {
            debugPrint(
              '⚠️ 401 Unauthorized detected. Attempting to refresh token...',
            );
            final refreshToken = CacheHelper().getData(key: 'refreshToken');
            final oldToken = CacheHelper().getData(key: 'token');

            if (refreshToken != null) {
              try {
                debugPrint('🔄 Refreshing token using: $refreshToken');
                // Some backends expect 'token', others 'accessToken'
                final refreshResponse = await Dio().post(
                  '${EndPoints.baserUrl}${EndPoints.refreshToken}',
                  data: {
                    'token': oldToken,
                    'accessToken': oldToken,
                    'refreshToken': refreshToken,
                  },
                );

                debugPrint('📥 Refresh response: ${refreshResponse.data}');

                if (refreshResponse.statusCode == 200) {
                  final data = refreshResponse.data;
                  String? newToken;
                  String? newRefreshToken;

                  if (data is Map<String, dynamic> &&
                      data.containsKey('data')) {
                    newToken =
                        data['data']['token'] ?? data['data']['accessToken'];
                    newRefreshToken = data['data']['refreshToken'];
                  } else if (data is Map<String, dynamic>) {
                    newToken = data['token'] ?? data['accessToken'];
                    newRefreshToken = data['refreshToken'];
                  }

                  if (newToken != null) {
                    debugPrint(
                      '✅ Token refreshed successfully. Retrying original request...',
                    );
                    await CacheHelper().saveData(key: 'token', value: newToken);
                    if (newRefreshToken != null) {
                      await CacheHelper().saveData(
                        key: 'refreshToken',
                        value: newRefreshToken,
                      );
                    }

                    e.requestOptions.headers['Authorization'] =
                        'Bearer $newToken';
                    final retryResponse = await dio.fetch(e.requestOptions);
                    return handler.resolve(retryResponse);
                  }
                }
              } catch (refreshError) {
                debugPrint('❌ Token refresh failed: $refreshError');
                // If it's a real 401 during refresh, we must logout
                await CacheHelper().clearData();
              }
            } else {
              debugPrint('🚫 No refresh token found in cache.');
              await CacheHelper().clearData();
            }
          }
          return handler.next(e);
        },
      ),
    );
  }

  //!POST
  @override
  Future post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
  }) async {
    try {
      var res = await dio.post(
        path,
        data: isFormData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
      );
      return res.data;
    } on DioException catch (e) {
      handleDioException(e);
    }
  }

  //!GET
  @override
  Future get(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      var res = await dio.get(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return res.data;
    } on DioException catch (e) {
      handleDioException(e);
    }
  }

  //!DELETE
  @override
  Future delete(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      var res = await dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return res.data;
    } on DioException catch (e) {
      handleDioException(e);
    }
  }

  //!PATCH
  @override
  Future patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
  }) async {
    try {
      var res = await dio.patch(
        path,
        data: isFormData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
      );
      return res.data;
    } on DioException catch (e) {
      handleDioException(e);
    }
  }

  //!PUT
  @override
  Future put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
  }) async {
    try {
      var res = await dio.put(
        path,
        data: isFormData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
      );
      return res.data;
    } on DioException catch (e) {
      handleDioException(e);
    }
  }
}
