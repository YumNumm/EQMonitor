import 'dart:io';

import 'package:cache/src/database/http_cache_database.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';

Future<CacheDatabase> openHttpCacheDatabase() async {
  final dir = await getApplicationSupportDirectory();
  return CacheDatabase(
    NativeDatabase.createInBackground(
      File('${dir.path}/eqmonitor_http_cache.db'),
    ),
  );
}
