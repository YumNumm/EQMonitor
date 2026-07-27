import 'dart:typed_data';

import 'package:cache/cache.dart';
import 'package:dio/dio.dart';
import 'package:drift/native.dart';
import 'package:eqmonitor/core/api/api_client_provider.dart';
import 'package:eqmonitor/core/api/http_cached_api_client_provider.dart';
import 'package:eqmonitor/core/provider/http_cached_dio_provider.dart';
import 'package:eqmonitor/core/provider/jma_parameter/jma_parameter.dart';
import 'package:eqmonitor/core/provider/api_dio_factory.dart';
import 'package:eqmonitor/core/provider/log/talker.dart' as talker_lib;
import 'package:eqmonitor/core/realtime/data_source/eqmonitor/eqmonitor_ws_provider.dart';
import 'package:eqmonitor/feature/earthquake_history/data/repository/earthquake_history_repository.dart';
import 'package:eqmonitor/feature/feed/data/repository/feed_repository.dart';
import 'package:eqmonitor/feature/notification/data/repository/push_notification_repository.dart';
import 'package:eqmonitor/feature/parameter/data/model/common/parameter_metadata.dart';
import 'package:eqmonitor/feature/parameter/data/model/common/parameter_type.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod/riverpod.dart';
import 'package:talker_flutter/talker_flutter.dart';

void main() {
  talker_lib.talker = Talker();

  test('通常Dioは対象外GETを保存せず、専用Dioだけが保存する', () async {
    final db = CacheDatabase(NativeDatabase.memory());
    addTearDown(db.close);
    final store = HttpCacheStore(db: db, schemaVersion: 1, appBuild: 'test');
    final adapter = _RecordingJsonAdapter();
    final factory = const ApiDioFactory(
      baseUrl: 'https://example.com',
      headers: {},
      baseInterceptors: [],
    );
    final dio = factory.build()..httpClientAdapter = adapter;

    expect(dio.interceptors.whereType<HttpCacheInterceptor>(), isEmpty);

    await dio.get<Map<String, dynamic>>(
      '/v2/earthquake',
      queryParameters: {'cursor': 'next'},
    );
    expect(adapter.requests, hasLength(1));
    expect(adapter.requests.last.uri.queryParameters['cursor'], 'next');
    expect(await store.listSummaries(), isEmpty);

    await dio.get<Map<String, dynamic>>(
      '/v2/earthquake',
      queryParameters: {'magnitude_gte': '5.0'},
    );
    expect(adapter.requests, hasLength(2));
    expect(adapter.requests.last.uri.queryParameters['magnitude_gte'], '5.0');
    expect(await store.listSummaries(), isEmpty);

    await dio.get<Map<String, dynamic>>('/v2/device/me');
    expect(adapter.requests, hasLength(3));
    expect(adapter.requests.last.path, '/v2/device/me');
    expect(await store.listSummaries(), isEmpty);

    await dio.get<Map<String, dynamic>>('/v2/realtime/ticket');
    expect(adapter.requests, hasLength(4));
    expect(adapter.requests.last.path, '/v2/realtime/ticket');
    expect(await store.listSummaries(), isEmpty);

    final cachedAdapter = _RecordingJsonAdapter();
    final cachedDio = factory.build(httpCacheStore: store)
      ..httpClientAdapter = cachedAdapter;

    await cachedDio.get<Map<String, dynamic>>('/v2/earthquake/202607270001');

    expect(cachedAdapter.requests, hasLength(1));
    expect(cachedAdapter.requests.single.path, '/v2/earthquake/202607270001');
    final entries = await store.listSummaries();
    expect(entries, hasLength(1));
    expect(entries.single.key, contains('/v2/earthquake/202607270001'));
  });

  test('paging・検索付き地震履歴repositoryは通常clientを使う', () async {
    var normalClientReads = 0;
    final adapter = _EarthquakeListAdapter();
    final dio = Dio(BaseOptions(baseUrl: 'https://example.com'))
      ..httpClientAdapter = adapter;
    final container = ProviderContainer(
      overrides: [
        apiClientProvider.overrideWith((ref) async {
          normalClientReads++;
          return api.ApiClient(dio);
        }),
        jmaParameterProvider.overrideWith((ref) async => _jmaParameter),
        httpCachedApiClientProvider.overrideWith(
          (ref) async => throw StateError('cached client must not be read'),
        ),
        httpCachedDioProvider.overrideWith(
          (ref) async => throw StateError('cached dio must not be read'),
        ),
      ],
    );
    addTearDown(container.dispose);

    final repository = await container.read(
      earthquakeHistoryRepositoryProvider.future,
    );
    final response = await repository.fetchEarthquakeList(
      limit: 20,
      cursor: 'next',
      magnitudeGte: 5,
    );

    expect(response.items, isEmpty);
    expect(normalClientReads, 1);
    expect(adapter.request?.uri.queryParameters['cursor'], 'next');
    expect(adapter.request?.uri.queryParameters['magnitudeGte'], '5.0');
  });

  test('Feed一覧とユーザー固有repositoryは通常clientを使う', () async {
    var normalClientReads = 0;
    final dio = Dio(BaseOptions(baseUrl: 'https://example.com'));
    final container = ProviderContainer(
      overrides: [
        apiClientProvider.overrideWith((ref) async {
          normalClientReads++;
          return api.ApiClient(dio);
        }),
        httpCachedApiClientProvider.overrideWith(
          (ref) async => throw StateError('cached client must not be read'),
        ),
        httpCachedDioProvider.overrideWith(
          (ref) async => throw StateError('cached dio must not be read'),
        ),
      ],
    );
    addTearDown(container.dispose);

    await container.read(feedRepositoryProvider.future);
    await container.read(pushNotificationRepositoryProvider.future);

    expect(normalClientReads, 1);
  });

  test('Realtime ticket providerは通常clientを使う', () async {
    var normalClientReads = 0;
    final dio = Dio(BaseOptions(baseUrl: 'https://example.com'))
      ..httpClientAdapter = _RealtimeTicketAdapter();
    final container = ProviderContainer(
      overrides: [
        apiClientProvider.overrideWith((ref) async {
          normalClientReads++;
          return api.ApiClient(dio);
        }),
        httpCachedApiClientProvider.overrideWith(
          (ref) async => throw StateError('cached client must not be read'),
        ),
        httpCachedDioProvider.overrideWith(
          (ref) async => throw StateError('cached dio must not be read'),
        ),
      ],
    );
    addTearDown(container.dispose);

    final ticket = await container.read(
      eqmonitorWebSocketTicketProvider.future,
    );

    expect(ticket.url, 'wss://example.com/ws?ticket=test');
    expect(normalClientReads, 1);
  });
}

final class _RecordingJsonAdapter implements HttpClientAdapter {
  final requests = <RequestOptions>[];

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requests.add(options);
    return ResponseBody.fromString(
      '{"ok":true}',
      200,
      headers: const {
        Headers.contentTypeHeader: [Headers.jsonContentType],
        'etag': ['W/"scope-test"'],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

final class _EarthquakeListAdapter implements HttpClientAdapter {
  RequestOptions? request;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    request = options;
    return ResponseBody.fromString(
      '{"items":[]}',
      200,
      headers: const {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

final class _RealtimeTicketAdapter implements HttpClientAdapter {
  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async => ResponseBody.fromString(
    '{"url":"wss://example.com/ws?ticket=test",'
    '"expiresAt":"2026-07-27T13:00:00.000Z",'
    '"issuedAt":"2026-07-27T12:00:00.000Z"}',
    200,
    headers: const {
      Headers.contentTypeHeader: [Headers.jsonContentType],
    },
  );

  @override
  void close({bool force = false}) {}
}

const _metadata = ParameterMetadata(
  type: ParameterType.earthquakeStations,
  schemaVersion: 1,
  sourceVersion: 'test',
  sourceUpdatedAt: null,
  sourceUrls: [],
  sha256: 'test',
);

const JmaParameterState _jmaParameter = (
  earthquake: EarthquakeParameter(metadata: _metadata, prefectures: []),
  tsunami: TsunamiParameter(metadata: _metadata, prefectures: []),
  shindoDbStations: ShindoDbStationsParameter(
    metadata: _metadata,
    stations: [],
  ),
);
