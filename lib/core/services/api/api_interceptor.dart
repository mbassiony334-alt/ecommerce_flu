import 'package:dio/dio.dart';
import 'package:e_commarcae/core/services/api/endpoints.dart';
import 'package:e_commarcae/core/services/cache/cache_helper.dart';

class ApiInterceptor extends Interceptor {

  static final List<String> _publicPaths = [
    Endpoint.signIn,
    Endpoint.signUp,
    Endpoint.forgetWithEmail,
    Endpoint.resetPassword,
    Endpoint.codeReset,
  ];

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {

    final String? token = CacheHelper.getData(key: ApiKey.token);


    final bool isPublic = _publicPaths.any((p) => options.path.contains(p));

    if (token != null && token.isNotEmpty && !isPublic) {
      options.headers["Authorization"] = "Bearer $token";
    }

    super.onRequest(options, handler);
  }
}
