import 'package:dio/dio.dart';
import 'package:e_commarcae/core/error/serve_eror.dart';
import 'package:e_commarcae/core/services/api/api_Concumer.dart';
import 'package:e_commarcae/core/services/api/api_interceptor.dart';
import 'package:e_commarcae/core/services/api/endpoit.dart';

/// Concrete HTTP client that wraps [Dio] and implements [ApiConsumer].
///
/// Note: ALL four methods (get, post, put, delete) were previously calling
/// [dio.delete] — this fixes each to use the correct Dio method.
class DioConsumer extends ApiConsumer {
  final Dio dio;

  DioConsumer({required this.dio}) {
    dio.options.baseUrl = Endpoint.baseurl;
    dio.interceptors.add(ApiInterceptor());
    dio.interceptors.add(
      LogInterceptor(request: true, responseBody: true, requestHeader: true),
    );
  }

  @override
  Future<dynamic> delet(
    String path, {
    Object? data,
    Map<String, dynamic>? quary,
  }) async {
    try {
      var response = await dio.delete(
        path,
        data: data,
        queryParameters: quary,
      );
      return response.data;
    } on DioException catch (e) {
      handelException(e);
    }
  }

  @override
  Future<dynamic> get(
    String path, {
    Object? data,
    Map<String, dynamic>? quary,
  }) async {
    try {
      var response = await dio.get(
        path,
        data: data,
        queryParameters: quary,
      );
      return response.data;
    } on DioException catch (e) {
      handelException(e);
    }
  }

  @override
  Future<dynamic> post(
    String path, {
    Object? data,
    Map<String, dynamic>? quary,
  }) async {
    try {
      var response = await dio.post(
        path,
        data: data,
        queryParameters: quary,
      );
      return response.data;
    } on DioException catch (e) {
      handelException(e);
    }
  }

  @override
  Future<dynamic> put(
    String path, {
    Object? data,
    Map<String, dynamic>? quary,
  }) async {
    try {
      var response = await dio.put(
        path,
        data: data,
        queryParameters: quary,
      );
      return response.data;
    } on DioException catch (e) {
      handelException(e);
    }
  }
}
