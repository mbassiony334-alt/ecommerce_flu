import 'package:dio/dio.dart';
import 'package:e_commarcae/core/error/erorrModel.dart';

class ServeEror implements Exception {
  final ErorrModel erorrModel;

  ServeEror({required this.erorrModel});
}

void handelException(DioException e) {
  final data = e.response?.data;

  switch (e.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
    case DioExceptionType.cancel:
    case DioExceptionType.connectionError:
    case DioExceptionType.unknown:
      throw ServeEror(
        erorrModel: ErorrModel.fromJson(data ?? {'message': 'Unknown error'}),
      );

    case DioExceptionType.badCertificate:
      throw ServeEror(
        erorrModel: ErorrModel.fromJson(data ?? {'message': 'Bad certificate'}),
      );

    case DioExceptionType.badResponse:
      final status = e.response?.statusCode ?? 0;
      switch (status) {
        case 400:
          throw ServeEror(
            erorrModel: ErorrModel.fromJson(data ?? {'message': 'Bad request'}),
          );
        case 401:
          throw ServeEror(
            erorrModel: ErorrModel.fromJson(
              data ?? {'message': 'Unauthorized'},
            ),
          );
        case 403:
          throw ServeEror(
            erorrModel: ErorrModel.fromJson(data ?? {'message': 'Forbidden'}),
          );
        case 404:
          throw ServeEror(
            erorrModel: ErorrModel.fromJson(data ?? {'message': 'Not found'}),
          );
        case 500:
          throw ServeEror(
            erorrModel: ErorrModel.fromJson(
              data ?? {'message': 'Server error'},
            ),
          );
        default:
          throw ServeEror(
            erorrModel: ErorrModel.fromJson(
              data ?? {'message': 'Received invalid status code: $status'},
            ),
          );
      }
  }
}
