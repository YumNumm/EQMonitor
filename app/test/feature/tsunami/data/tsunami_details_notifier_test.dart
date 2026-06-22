import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:eqmonitor/core/api/api_client_provider.dart';
import 'package:eqmonitor/feature/tsunami/data/notifier/tsunami_details_notifier.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  test('ポーリング失敗時も直前の津波詳細を保持する', () {
    fakeAsync((async) {
      final adapter = _TsunamiDetailsAdapter();
      final dio = Dio(BaseOptions(baseUrl: 'https://example.com'))
        ..httpClientAdapter = adapter;
      final container = ProviderContainer(
        overrides: [
          apiClientProvider.overrideWith((ref) async => api.ApiClient(dio)),
        ],
      );
      final provider = tsunamiDetailsProvider('tsunami-1');
      final subscription = container.listen(provider, (_, _) {});

      async.flushMicrotasks();
      async.elapse(Duration.zero);
      async.flushMicrotasks();

      expect(container.read(provider).requireValue.id, 'tsunami-1');

      async.elapse(const Duration(seconds: 30));
      async.flushMicrotasks();
      async.elapse(Duration.zero);
      async.flushMicrotasks();

      final state = container.read(provider);
      expect(adapter.requests, hasLength(2));
      expect(state, isA<AsyncData<api.TsunamiState>>());
      expect(state.requireValue.id, 'tsunami-1');

      subscription.close();
      container.dispose();
    });
  });
}

final class _TsunamiDetailsAdapter implements HttpClientAdapter {
  final requests = <RequestOptions>[];

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requests.add(options);
    if (requests.length == 2) {
      throw DioException.connectionError(
        requestOptions: options,
        reason: 'temporary network failure',
      );
    }

    return ResponseBody.fromString(
      jsonEncode(<String, dynamic>{
        'id': 'tsunami-1',
        'event_ids': ['event-1'],
        'is_active': true,
        'is_canceled': false,
        'updated_at': '2026-06-22T00:00:00Z',
        'earthquakes': <Map<String, dynamic>>[],
        'latest_telegrams': <Map<String, dynamic>>[],
        'forecast_regions': <Map<String, dynamic>>[],
        'offshore_observations': <Map<String, dynamic>>[],
      }),
      200,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}
