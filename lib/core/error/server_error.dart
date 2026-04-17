import 'package:dio/dio.dart';
import 'package:e_commarcae/core/error/error_model.dart';

class ServerError implements Exception {
  final ErrorModel errorModel;

  ServerError({required this.errorModel});

  @override
  String toString() => errorModel.errorMessage;
}

Never _throwUnknown(Object? data, String message) {
  throw ServerError(
    errorModel: ErrorModel.fromJson(
      (data is Map<String, dynamic>) ? data : {'message': message},
    ),
  );
}

void handleDioException(DioException e) {
  final data = e.response?.data;

  switch (e.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
    case DioExceptionType.cancel:
    case DioExceptionType.connectionError:
    case DioExceptionType.unknown:
      _throwUnknown(data, 'Network error');

    case DioExceptionType.badCertificate:
      _throwUnknown(data, 'Bad certificate');

    case DioExceptionType.badResponse:
      final status = e.response?.statusCode ?? 0;
      switch (status) {
        case 400:
          _throwUnknown(data, 'Bad request');
        case 401:
          _throwUnknown(data, 'Unauthorized');
        case 403:
          _throwUnknown(data, 'Forbidden');
        case 404:
          _throwUnknown(data, 'Not found');
        case 500:
          _throwUnknown(data, 'Server error');
        default:
          _throwUnknown(data, 'Received invalid status code: $status');
      }
  }
}

