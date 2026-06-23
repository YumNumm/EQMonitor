import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_key.dart';
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/feature/changelog/data/repository/changelog_repository.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  test('fetch uses shared preferences enum keys for changelog cache', () async {
    SharedPreferences.setMockInitialValues({
      SharedPreferencesKey.changelogEtag.key: 'etag-cached',
      SharedPreferencesKey.changelogBody.key: jsonEncode(
        _changelogJson('1.0.0'),
      ),
    });
    final prefs = await SharedPreferences.getInstance();
    final adapter = _ChangelogCacheAdapter();
    final dio = Dio(BaseOptions(baseUrl: 'https://example.com'))
      ..httpClientAdapter = adapter;
    final repository = ChangelogRepository(api.ApiClient(dio), prefs);

    final result = await repository.fetch();

    expect(adapter.requests.single.headers['if-none-match'], 'etag-cached');
    expect(result, isA<Success<api.ChangelogResponse, Exception>>());
    final storedBody = prefs.getString(SharedPreferencesKey.changelogBody.key);
    expect(storedBody, isNotNull);
    expect(
      api.ChangelogResponse.fromJson(
        jsonDecode(storedBody ?? '{}') as Map<String, Object?>,
      ).entries.single.version,
      '1.1.0',
    );
    expect(
      prefs.getString(SharedPreferencesKey.changelogEtag.key),
      'etag-fresh',
    );
  });
}

final class _ChangelogCacheAdapter implements HttpClientAdapter {
  final requests = <RequestOptions>[];

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requests.add(options);
    return ResponseBody.fromString(
      jsonEncode(_changelogJson('1.1.0')),
      200,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
        'etag': ['etag-fresh'],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

Map<String, Object?> _changelogJson(String version) => {
  'entries': [
    {
      'version': version,
      'date': '2026-06-04T00:00:00Z',
      'url': 'https://example.com/changelog/$version',
      'sections': [
        {
          'title': '追加',
          'items': ['更新内容'],
        },
      ],
    },
  ],
};
