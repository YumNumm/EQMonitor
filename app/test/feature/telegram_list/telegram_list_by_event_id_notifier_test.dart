import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:eqmonitor/core/api/api_client_provider.dart';
import 'package:eqmonitor/feature/telegram_list/data/notifier/telegram_list_by_event_id_notifier.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  test('fetchNextData passes current nextToken as cursor', () async {
    final adapter = _TelegramListAdapter();
    final dio = Dio(BaseOptions(baseUrl: 'https://example.com'))
      ..httpClientAdapter = adapter;
    final container = ProviderContainer(
      overrides: [
        apiClientProvider.overrideWith((ref) async => api.ApiClient(dio)),
      ],
    );
    addTearDown(container.dispose);
    final provider = telegramListByEventIdProvider('event-1');
    final subscription = container.listen(provider, (_, _) {});
    addTearDown(subscription.close);

    await container.read(provider.future);
    await container.read(provider.notifier).fetchNextData();

    expect(adapter.requests, hasLength(2));
    expect(adapter.requests[0].queryParameters['cursor'], isNull);
    expect(adapter.requests[1].queryParameters['cursor'], 'cursor-1');
  });
}

final class _TelegramListAdapter implements HttpClientAdapter {
  final requests = <RequestOptions>[];

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requests.add(options);
    final body = switch (requests.length) {
      1 => _responseJson(nextToken: 'cursor-1', id: 'telegram-1'),
      _ => _responseJson(nextToken: null, id: 'telegram-2'),
    };
    return ResponseBody.fromString(
      jsonEncode(body),
      200,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

Map<String, Object?> _responseJson({
  required String? nextToken,
  required String id,
}) => {
  'items': [
    {
      'id': id,
      'event_id': 'event-1',
      'type': 'VXSE51',
      'title': '震源・震度情報',
      'status': 'NORMAL',
      'info_type': 'PUBLICATION',
      'editorial_office': '気象庁',
      'publishing_office': ['気象庁'],
      'pressed_at': '2026-06-04T12:00:00Z',
      'reported_at': '2026-06-04T12:00:00Z',
      'info_kind': '地震情報',
      'info_kind_version': '1.0_0',
      'hash': id,
      'created_at': '2026-06-04T12:00:00Z',
    },
  ],
  'next_token': ?nextToken,
};
