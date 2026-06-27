import 'package:cache/src/http/http_cache_interceptor.dart';
import 'package:dio/dio.dart';

class ForceFreshInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.extra[kForceFreshExtra] = true;
    handler.next(options);
  }
}
