import 'package:cache/src/http/cache_miss_exception.dart';
import 'package:cache/src/http/http_cache_store.dart';
import 'package:cache/src/http/restore_response.dart';
import 'package:dio/dio.dart';

class CacheOnlyInterceptor extends Interceptor {
  CacheOnlyInterceptor(HttpCacheStore store) : _store = store;
  CacheOnlyInterceptor.disabled() : _store = null;

  final HttpCacheStore? _store;

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
    final store = _store;
    if (options.method.toUpperCase() != 'GET' || store == null) {
      handler.reject(cacheMiss);
      return;
    }
    final cached = await store.read(store.primaryKeyForUrl(options));
    if (cached == null) {
      handler.reject(cacheMiss);
      return;
    }
    handler.resolve(restoreResponse(options, cached));
  }
}
