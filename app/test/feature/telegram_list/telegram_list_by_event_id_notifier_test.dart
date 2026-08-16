import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:cache/cache.dart';
import 'package:dio/dio.dart';
import 'package:eqmonitor/core/api/api_client_provider.dart';
import 'package:eqmonitor/core/api/cache_only_api_client_provider.dart';
import 'package:eqmonitor/core/api/http_cached_api_client_provider.dart';
import 'package:eqmonitor/core/realtime/model/realtime_event.dart';
import 'package:eqmonitor/core/realtime/realtime_event_provider.dart';
import 'package:eqmonitor/feature/telegram_list/data/notifier/telegram_details_notifier.dart';
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
        realtimeEventsProvider.overrideWith(
          () => _StubRealtimeEvents(const Stream.empty()),
        ),
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

  test('matching earthquake update refetches telegram list', () async {
    final controller = StreamController<RealtimeEvent>.broadcast(sync: true);
    addTearDown(controller.close);
    final adapter = _TelegramListAdapter();
    final dio = Dio(BaseOptions(baseUrl: 'https://example.com'))
      ..httpClientAdapter = adapter;
    final container = ProviderContainer(
      overrides: [
        apiClientProvider.overrideWith((ref) async => api.ApiClient(dio)),
        realtimeEventsProvider.overrideWith(
          () => _StubRealtimeEvents(controller.stream),
        ),
      ],
    );
    addTearDown(container.dispose);
    final provider = telegramListByEventIdProvider('event-1');
    final subscription = container.listen(provider, (_, _) {});
    addTearDown(subscription.close);
    await container.read(provider.future);

    controller.add(
      RealtimeEvent.earthquakeUpsert(
        record: _TelegramListFixtures.earthquake(eventId: 'event-1'),
        source: RealtimeSource.eqmonitor,
      ),
    );
    await container.pump();
    await container.read(provider.future);

    expect(adapter.requests, hasLength(2));
  });

  test('different earthquake update does not refetch telegram list', () async {
    final controller = StreamController<RealtimeEvent>.broadcast(sync: true);
    addTearDown(controller.close);
    final adapter = _TelegramListAdapter();
    final dio = Dio(BaseOptions(baseUrl: 'https://example.com'))
      ..httpClientAdapter = adapter;
    final container = ProviderContainer(
      overrides: [
        apiClientProvider.overrideWith((ref) async => api.ApiClient(dio)),
        realtimeEventsProvider.overrideWith(
          () => _StubRealtimeEvents(controller.stream),
        ),
      ],
    );
    addTearDown(container.dispose);
    final provider = telegramListByEventIdProvider('event-1');
    final subscription = container.listen(provider, (_, _) {});
    addTearDown(subscription.close);
    await container.read(provider.future);

    controller.add(
      RealtimeEvent.earthquakeUpsert(
        record: _TelegramListFixtures.earthquake(eventId: 'event-1'),
        source: RealtimeSource.eqmonitor,
      ),
    );
    await container.pump();
    await container.read(provider.future);
    expect(adapter.requests, hasLength(2));

    controller.add(
      RealtimeEvent.earthquakeUpsert(
        record: _TelegramListFixtures.earthquake(eventId: 'event-2'),
        source: RealtimeSource.eqmonitor,
      ),
    );
    await container.pump();

    expect(adapter.requests, hasLength(2));
  });

  test('only matching earthquake update refetches telegram details', () async {
    final controller = StreamController<RealtimeEvent>.broadcast(sync: true);
    addTearDown(controller.close);
    final cacheClient = api.ApiClient(Dio());
    final freshClient = api.ApiClient(Dio());
    final spy = _SpyTelegramDetails(cacheClient: cacheClient);
    final provider = telegramDetailsProvider('event-1');
    final container = ProviderContainer(
      overrides: [
        realtimeEventsProvider.overrideWith(
          () => _StubRealtimeEvents(controller.stream),
        ),
        cacheOnlyApiClientProvider.overrideWith((ref) async => cacheClient),
        httpCachedApiClientProvider.overrideWith((ref) async => freshClient),
        provider.overrideWith(() => spy),
      ],
    );
    addTearDown(container.dispose);
    final subscription = container.listen(provider, (_, _) {});
    addTearDown(subscription.close);
    await container.read(provider.future);
    expect(spy.freshFetchCount, 1);

    controller.add(
      RealtimeEvent.earthquakeUpsert(
        record: _TelegramListFixtures.earthquake(eventId: 'event-1'),
        source: RealtimeSource.eqmonitor,
      ),
    );
    await container.pump();
    await container.read(provider.future);
    expect(spy.freshFetchCount, 2);

    controller.add(
      RealtimeEvent.earthquakeUpsert(
        record: _TelegramListFixtures.earthquake(eventId: 'event-2'),
        source: RealtimeSource.eqmonitor,
      ),
    );
    await container.pump();
    expect(spy.freshFetchCount, 2);
  });
}

final class _StubRealtimeEvents extends RealtimeEvents {
  _StubRealtimeEvents(this.stream);

  final Stream<RealtimeEvent> stream;

  @override
  Stream<RealtimeEvent> build() => stream;
}

final class _SpyTelegramDetails extends TelegramDetails {
  _SpyTelegramDetails({required this.cacheClient});

  final api.ApiClient cacheClient;
  var freshFetchCount = 0;

  @override
  Future<Map<String, api.TelegramDetailResponse>> fetch(
    api.ApiClient client,
  ) async {
    if (identical(client, cacheClient)) {
      throw const CacheMissException();
    }
    freshFetchCount += 1;
    return {};
  }
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

final class _TelegramListFixtures {
  static api.Earthquake earthquake({required String eventId}) => api.Earthquake(
    eventId: eventId,
    status: .normal,
    earthquakeType: .normal,
    originTimePrecision: .second,
    datasources: const [],
    telegrams: const [],
  );
}
