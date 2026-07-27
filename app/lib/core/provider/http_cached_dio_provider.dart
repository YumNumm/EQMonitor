import 'package:dio/dio.dart';
import 'package:eqmonitor/core/api/http_cache_disabled_provider.dart';
import 'package:eqmonitor/core/api/http_cache_store_provider.dart';
import 'package:eqmonitor/core/provider/api_dio_factory.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'http_cached_dio_provider.g.dart';

@Riverpod(keepAlive: true)
Future<Dio> httpCachedDio(Ref ref) async {
  final factory = await ref.watch(apiDioFactoryProvider.future);
  final disabled = await ref.watch(httpCacheDisabledProvider.future);
  if (disabled) {
    return factory.build();
  }
  try {
    final store = await ref.watch(httpCacheStoreProvider.future);
    return factory.build(httpCacheStore: store);
  } on Object catch (error, stackTrace) {
    talker.warning('HTTPキャッシュを利用できないため通常通信へ切り替えます', error, stackTrace);
    return factory.build();
  }
}
