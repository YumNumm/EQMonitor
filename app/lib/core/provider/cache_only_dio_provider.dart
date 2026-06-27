import 'package:cache/cache.dart';
import 'package:dio/dio.dart';
import 'package:eqmonitor/core/api/http_cache_store_provider.dart';
import 'package:eqmonitor/core/provider/dio_base_options.dart';
import 'package:eqmonitor/core/provider/telegram_url/provider/telegram_url_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cache_only_dio_provider.g.dart';

@Riverpod(keepAlive: true)
Future<Dio> cacheOnlyDio(Ref ref) async {
  final store = await ref.watch(httpCacheStoreProvider.future);
  final telegramUrl = await ref.watch(telegramUrlProvider.future);
  final dio = Dio(buildApiBaseOptions(baseUrl: telegramUrl.restApiUrl));
  dio.interceptors.add(CacheOnlyInterceptor(store));
  return dio;
}
