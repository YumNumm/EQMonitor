import 'dart:async';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:nied_api_client/src/hinet/jmalist/api/hinet_jmalist_api_client.dart';
import 'package:test/test.dart';

const _samplePreBody = '''
<html><body><pre>
2026-06-02 11:08:33.99  0.07   36.571  0.18  137.868  0.29     7.7   1.0  1.6V        NORTHERN NAGANO PREF  k
</pre></body></html>
''';

class _RecordingAdapter implements HttpClientAdapter {
  final requestedPaths = <String>[];
  final requestedFormFields = <Map<String, String>>[];
  bool loginShouldSucceed = true;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requestedPaths.add(options.path);
    final data = options.data;
    if (data is FormData) {
      requestedFormFields.add({
        for (final field in data.fields) field.key: field.value,
      });
    }
    if (!options.path.contains('jmalist.php')) {
      // jmalist.php 以外(= /auth/?LANG=ja へのログインPOST)への応答
      return ResponseBody.fromString(
        '',
        loginShouldSucceed ? 302 : 401,
        headers: loginShouldSucceed
            ? {
                'set-cookie': ['_ssl_auth=dummy-token; Path=/'],
              }
            : {},
      );
    }
    return ResponseBody.fromString(_samplePreBody, 200);
  }

  @override
  void close({bool force = false}) {}
}

void main() {
  test('ログイン成功時は true を返す', () async {
    final adapter = _RecordingAdapter();
    final dio = Dio(BaseOptions(followRedirects: false))
      ..httpClientAdapter = adapter;
    final client = HinetJmalistApiClient(dio);

    final result = await client.login(userId: 'user', password: 'pass');

    expect(result, isTrue);
  });

  test('ログイン失敗時は false を返す', () async {
    final adapter = _RecordingAdapter()..loginShouldSucceed = false;
    final dio = Dio(BaseOptions(followRedirects: false))
      ..httpClientAdapter = adapter;
    final client = HinetJmalistApiClient(dio);

    final result = await client.login(userId: 'user', password: 'wrong');

    expect(result, isFalse);
  });

  test('8日間の指定は7日+1日の2リクエストへ分割され進捗が通知される', () async {
    final adapter = _RecordingAdapter();
    final dio = Dio(BaseOptions(followRedirects: false))
      ..httpClientAdapter = adapter;
    final client = HinetJmalistApiClient(dio, requestInterval: Duration.zero);

    final progressUpdates = <HinetJmalistFetchProgress>[];
    final result = await client.fetchRange(
      from: DateTime.utc(2026, 6, 1),
      to: DateTime.utc(2026, 6, 8),
      onProgress: progressUpdates.add,
    );

    final jmalistRequests = adapter.requestedPaths
        .where((p) => p.contains('jmalist.php'))
        .length;
    expect(jmalistRequests, 2);
    expect(progressUpdates.last.completedRequests, 2);
    expect(progressUpdates.last.totalRequests, 2);
    expect(result.events, hasLength(2));

    // jmalist.php 宛てのリクエストは requestedPaths の 2件目以降(0件目は
    // ログインPOST)なので、対応する requestedFormFields も 1件目以降を見る。
    final jmalistFormFields = [
      for (var i = 0; i < adapter.requestedPaths.length; i++)
        if (adapter.requestedPaths[i].contains('jmalist.php'))
          adapter.requestedFormFields[i],
    ];
    expect(jmalistFormFields, hasLength(2));
    expect(jmalistFormFields[0], {
      'list_year': '2026',
      'list_month': '6',
      'list_day': '1',
      'list_span': '7',
    });
    expect(jmalistFormFields[1], {
      'list_year': '2026',
      'list_month': '6',
      'list_day': '8',
      'list_span': '1',
    });
  });
}
