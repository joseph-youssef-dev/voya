import 'package:dio/dio.dart';
import 'package:voya/core/errors/error_model.dart';

//!ServerException
class ServerException implements Exception {
  final ErrorModel errorModel;
  ServerException(this.errorModel);
}

//!CacheExeption
class CacheExeption implements Exception {
  final String errorMessage;
  CacheExeption({required this.errorMessage});
}

class BadCertificateException extends ServerException {
  BadCertificateException(super.errorModel);
}

class ConnectionTimeoutException extends ServerException {
  ConnectionTimeoutException(super.errorModel);
}

class BadResponseException extends ServerException {
  BadResponseException(super.errorModel);
}

class ReceiveTimeoutException extends ServerException {
  ReceiveTimeoutException(super.errorModel);
}

class ConnectionErrorException extends ServerException {
  ConnectionErrorException(super.errorModel);
}

class SendTimeoutException extends ServerException {
  SendTimeoutException(super.errorModel);
}

class UnauthorizedException extends ServerException {
  UnauthorizedException(super.errorModel);
}

class ForbiddenException extends ServerException {
  ForbiddenException(super.errorModel);
}

class NotFoundException extends ServerException {
  NotFoundException(super.errorModel);
}

class CofficientException extends ServerException {
  CofficientException(super.errorModel);
}

class CancelException extends ServerException {
  CancelException(super.errorModel);
}

class UnknownException extends ServerException {
  UnknownException(super.errorModel);
}

void handleDioException(DioException e) {
  ErrorModel makeError(String fallback) {
    try {
      if (e.response?.data is Map<String, dynamic>) {
        return ErrorModel.fromJson(e.response!.data);
      }
    } catch (_) {}
    return ErrorModel(errorMessage: fallback, status: e.response?.statusCode ?? 500);
  }

  switch (e.type) {
    case DioExceptionType.connectionError:
      throw ConnectionErrorException(makeError('Connection error'));
    case DioExceptionType.badCertificate:
      throw BadCertificateException(makeError('Bad certificate'));
    case DioExceptionType.connectionTimeout:
      throw ConnectionTimeoutException(makeError('Connection timeout'));
    case DioExceptionType.receiveTimeout:
      throw ReceiveTimeoutException(makeError('Receive timeout'));
    case DioExceptionType.sendTimeout:
      throw SendTimeoutException(makeError('Send timeout'));
    case DioExceptionType.badResponse:
      switch (e.response?.statusCode) {
        case 400:
          throw BadResponseException(makeError('Bad request'));
        case 401:
          throw UnauthorizedException(makeError('Unauthorized'));
        case 403:
          throw ForbiddenException(makeError('Forbidden'));
        case 404:
          throw NotFoundException(makeError('Not found'));
        case 409:
          throw CofficientException(makeError('Conflict'));
        case 504:
          throw BadResponseException(makeError('Gateway timeout'));
        default:
          throw BadResponseException(
            makeError('Server error: ${e.response?.statusCode}'),
          );
      }
    case DioExceptionType.cancel:
      throw CancelException(
        ErrorModel(errorMessage: e.toString(), status: 500),
      );
    case DioExceptionType.unknown:
      throw UnknownException(
        ErrorModel(errorMessage: e.toString(), status: 500),
      );
  }
}
