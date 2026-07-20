import 'package:cache/cache.dart';
import 'package:eqmonitor/core/api/http_cache_store_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'debug_http_cache_entries_provider.g.dart';

@riverpod
Future<List<HttpCacheEntrySummary>> debugHttpCacheEntries(Ref ref) async {
  final store = await ref.watch(httpCacheStoreProvider.future);
  return store.listSummaries();
}
