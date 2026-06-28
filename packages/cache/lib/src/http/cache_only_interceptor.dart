import 'package:cache/src/http/cache_miss_exception.dart';
import 'package:cache/src/http/http_cache_store.dart';
import 'package:cache/src/http/restore_response.dart';
import 'package:dio/dio.dart';

class CacheOnlyInterceptor extends Interceptor {
  CacheOnlyInterceptor(this.store);

  final HttpCacheStore store;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final cacheMiss = DioException(
      requestOptions: options,
      error: const CacheMissException(),
      type: .cancel,
      message: 'Cacheミスのため、リクエストをキャンセルします',
      stackTrace: StackTrace.current,
    );
    if (options.method.toUpperCase() != 'GET') {
      handler.reject(cacheMiss);
      return;
    }
    final key = store.primaryKeyForUrl(options);
    final cached = await store.read(key);
    if (cached == null) {
      handler.reject(cacheMiss);
      return;
    }
    handler.resolve(restoreResponse(options, cached));
  }
}
