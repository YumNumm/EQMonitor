import 'package:cache/cache.dart';
import 'package:dio/dio.dart';
import 'package:drift/native.dart';
import 'package:eqmonitor/core/provider/api_dio_factory.dart';
import 'package:eqmonitor/core/provider/log/talker.dart' as talker_lib;
import 'package:flutter_test/flutter_test.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_flutter/talker_flutter.dart';

void main() {
  talker_lib.talker = Talker();

  test('通常DioにはHTTPキャッシュがなく、キャッシュDioだけに1個ある', () {
    final db = CacheDatabase(NativeDatabase.memory());
    addTearDown(db.close);
    final store = HttpCacheStore(db: db, schemaVersion: 1, appBuild: 'test');
    final base = Interceptor();
    final factory = ApiDioFactory(
      baseUrl: 'https://example.com',
      headers: const {'x-eqmonitor-version': 'test'},
      baseInterceptors: [base],
    );

    final normal = factory.build();
    final cached = factory.build(httpCacheStore: store);

    expect(normal.interceptors.whereType<HttpCacheInterceptor>(), isEmpty);
    expect(cached.interceptors.whereType<HttpCacheInterceptor>(), hasLength(1));
    expect(normal.interceptors, contains(base));
    expect(cached.interceptors, contains(base));

    final cacheIndex = cached.interceptors.indexWhere(
      (interceptor) => interceptor is HttpCacheInterceptor,
    );
    final loggerIndex = cached.interceptors.indexWhere(
      (interceptor) => interceptor is TalkerDioLogger,
    );
    expect(cacheIndex, greaterThanOrEqualTo(0));
    expect(loggerIndex, greaterThan(cacheIndex));

    for (final dio in [normal, cached]) {
      expect(dio.options.baseUrl, 'https://example.com');
      expect(dio.options.headers['x-eqmonitor-version'], 'test');
      expect(dio.options.connectTimeout, const Duration(seconds: 10));
      expect(dio.options.sendTimeout, const Duration(seconds: 10));
      expect(dio.options.contentType, 'application/json');
      expect(dio.options.listFormat, ListFormat.multiCompatible);
    }
  });
}
