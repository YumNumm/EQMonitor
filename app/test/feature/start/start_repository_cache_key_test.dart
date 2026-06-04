import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_key.dart';
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/feature/start/data/repository/start_repository.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  test('fetch uses shared preferences enum keys for start cache', () async {
    SharedPreferences.setMockInitialValues({
      SharedPreferencesKey.startEtag.key: 'etag-cached',
      SharedPreferencesKey.startBody.key: jsonEncode(_startJson('1.0.0')),
    });
    final prefs = await SharedPreferences.getInstance();
    final adapter = _StartCacheAdapter();
    final dio = Dio(BaseOptions(baseUrl: 'https://example.com'))
      ..httpClientAdapter = adapter;
    final repository = StartRepository(api.ApiClient(dio), prefs);

    final result = await repository.fetch();

    expect(adapter.requests.single.headers['if-none-match'], 'etag-cached');
    expect(result, isA<Success<api.StartResponse, Exception>>());
    final storedBody = prefs.getString(SharedPreferencesKey.startBody.key);
    expect(storedBody, isNotNull);
    expect(
      api.StartResponse.fromJson(
        jsonDecode(storedBody ?? '{}') as Map<String, Object?>,
      ).app.version.latest?.version,
      '1.1.0',
    );
    expect(prefs.getString(SharedPreferencesKey.startEtag.key), 'etag-fresh');
  });
}

final class _StartCacheAdapter implements HttpClientAdapter {
  final requests = <RequestOptions>[];

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requests.add(options);
    return ResponseBody.fromString(
      jsonEncode(_startJson('1.1.0')),
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

Map<String, Object?> _startJson(String version) => {
  'flags': {
    'ads_enabled': true,
    'maintenance': {'enabled': false},
  },
  'app': {
    'version': {
      'required_versions': <Object?>[],
      'latest': {
        'version': version,
        'date': '2026-06-04T00:00:00Z',
        'show_whats_new': true,
        'whats_new': {'content': '更新内容'},
      },
    },
    'store_url': {
      'ios': 'https://example.com/ios',
      'android': 'https://example.com/android',
    },
  },
};
