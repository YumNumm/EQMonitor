import 'dart:io';

import 'package:cache/src/database/http_cache_database.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';

/// HTTPキャッシュDBの実体ファイル。オープン処理と容量計測で共用する。
Future<File> httpCacheDatabaseFile() async {
  final dir = await getApplicationSupportDirectory();
  return File('${dir.path}/eqmonitor_http_cache.db');
}

Future<CacheDatabase> openHttpCacheDatabase() async {
  final file = await httpCacheDatabaseFile();
  return CacheDatabase(NativeDatabase.createInBackground(file));
}
