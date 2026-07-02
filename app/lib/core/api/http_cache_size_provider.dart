import 'package:cache/cache.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'http_cache_size_provider.g.dart';

/// HTTPキャッシュDBファイルの実サイズ(バイト)。ファイル未作成時は 0。
@riverpod
Future<int> httpCacheSize(Ref ref) async {
  final file = await httpCacheDatabaseFile();
  if (!file.existsSync()) {
    return 0;
  }
  return file.length();
}
