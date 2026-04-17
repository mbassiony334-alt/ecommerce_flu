import 'package:dio/dio.dart';
import 'package:e_commarcae/core/error/server_error.dart';
import 'package:e_commarcae/core/services/api/api_consumer.dart';
import 'package:e_commarcae/core/services/api/api_interceptor.dart';
import 'package:e_commarcae/core/services/api/endpoints.dart';

class DioConsumer extends ApiConsumer {
  final Dio dio;

  DioConsumer({required this.dio}) {
    dio.options.baseUrl = Endpoint.baseUrl;
    dio.interceptors.add(ApiInterceptor());
    dio.interceptors.add(
      LogInterceptor(request: true, responseBody: true, requestHeader: true),
    );
  }

  @override
  Future<dynamic> get(String path, {Object? data, Map<String, dynamic>? query}) async {
    try {
      final response = await dio.get(path, data: data, queryParameters: query);
      return response.data;
    } on DioException catch (e) {
      handleDioException(e);
    }
  }

  @override
  Future<dynamic> post(String path, {Object? data, Map<String, dynamic>? query}) async {
    try {
      final response = await dio.post(path, data: data, queryParameters: query);
      return response.data;
    } on DioException catch (e) {
      handleDioException(e);
    }
  }

  @override
  Future<dynamic> put(String path, {Object? data, Map<String, dynamic>? query}) async {
    try {
      final response = await dio.put(path, data: data, queryParameters: query);
      return response.data;
    } on DioException catch (e) {
      handleDioException(e);
    }
  }

  @override
  Future<dynamic> delete(String path, {Object? data, Map<String, dynamic>? query}) async {
    try {
      final response = await dio.delete(path, data: data, queryParameters: query);
      return response.data;
    } on DioException catch (e) {
      handleDioException(e);
    }
  }
}

