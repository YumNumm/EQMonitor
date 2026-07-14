import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:eqmonitor/feature/seismicity/data/data_source/seismicity_local_cache_data_source.dart';
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_span.dart';
import 'package:eqmonitor/feature/seismicity/data/repository/seismicity_repository.dart';
import 'package:flutter_test/flutter_test.dart';

const _manifestJson = '''
{
  "layers": [
    {
      "type": "geojson",
      "span": "P1M",
      "url": "https://static.example.com/p1m.json",
      "generated_at": "2026-07-01T00:00:00Z",
      "count": 1
    }
  ]
}
''';

const _geoJson = '''
{
  "type": "FeatureCollection",
  "features": [
    {
      "type": "Feature",
      "geometry": { "type": "Point", "coordinates": [139.0, 35.0] },
      "properties": {
        "event_id": "eq-1",
        "origin_time": "2026-06-30T00:00:00Z",
        "magnitude": 3.0,
        "depth": 10.0,
        "max_intensity": null
      }
    }
  ]
}
''';

class _SuccessAdapter implements HttpClientAdapter {
  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    final body = options.path == '/v2/seismicity/manifest'
        ? _manifestJson
        : _geoJson;
    return ResponseBody.fromString(
      body,
      200,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

class _RecordingSuccessAdapter extends _SuccessAdapter {
  final requests = <RequestOptions>[];

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requests.add(options);
    return super.fetch(options, requestStream, cancelFuture);
  }
}

class _FailingAdapter implements HttpClientAdapter {
  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    throw DioException(
      requestOptions: options,
      type: DioExceptionType.connectionError,
    );
  }

  @override
  void close({bool force = false}) {}
}

void main() {
  late Directory tempDir;

  setUp(() {
    tempDir = Directory.systemTemp.createTempSync('seismicity_repo_test');
  });

  tearDown(() {
    tempDir.deleteSync(recursive: true);
  });

  test('取得成功時はキャッシュへ保存しつつ最新データを返す', () async {
    final dio = Dio(BaseOptions(baseUrl: 'https://example.com'))
      ..httpClientAdapter = _SuccessAdapter();
    final cache = SeismicityLocalCacheDataSource(
      directoryProvider: () async => tempDir,
    );
    final repository = SeismicityRepository(
      manifestDio: dio,
      geoJsonDio: dio,
      cache: cache,
    );

    final dataset = await repository.fetch(span: SeismicitySpan.p1m);

    expect(dataset.isFromCache, isFalse);
    expect(dataset.events.single.eventId, 'eq-1');
    expect(dataset.generatedAt, DateTime.utc(2026, 7, 1));

    final cached = await cache.read(SeismicitySpan.p1m);
    expect(cached, isNotNull);
    expect(cached!.events.single.eventId, 'eq-1');
  });

  test('GeoJSON 取得には manifest 用 Dio の端末IDヘッダーを引き継がない', () async {
    final manifestDio = Dio(BaseOptions(baseUrl: 'https://example.com'))
      ..httpClientAdapter = _SuccessAdapter()
      ..interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            options.headers['x-eqmonitor-device-id'] = 'device-id';
            handler.next(options);
          },
        ),
      );
    final geoJsonAdapter = _RecordingSuccessAdapter();
    final geoJsonDio = Dio(BaseOptions(baseUrl: ''))
      ..httpClientAdapter = geoJsonAdapter;
    final cache = SeismicityLocalCacheDataSource(
      directoryProvider: () async => tempDir,
    );
    final repository = SeismicityRepository(
      manifestDio: manifestDio,
      geoJsonDio: geoJsonDio,
      cache: cache,
    );

    await repository.fetch(span: SeismicitySpan.p1m);

    expect(geoJsonAdapter.requests, hasLength(1));
    expect(
      geoJsonAdapter.requests.single.headers,
      isNot(contains('x-eqmonitor-device-id')),
    );
  });

  test('取得失敗時はローカルキャッシュへフォールバックする', () async {
    final workingDio = Dio(BaseOptions(baseUrl: 'https://example.com'))
      ..httpClientAdapter = _SuccessAdapter();
    final cache = SeismicityLocalCacheDataSource(
      directoryProvider: () async => tempDir,
    );
    // 事前に一度成功させてキャッシュへ書き込んでおく
    await SeismicityRepository(
      manifestDio: workingDio,
      geoJsonDio: workingDio,
      cache: cache,
    ).fetch(span: SeismicitySpan.p1m);

    final failingDio = Dio(BaseOptions(baseUrl: 'https://example.com'))
      ..httpClientAdapter = _FailingAdapter();
    final repository = SeismicityRepository(
      manifestDio: failingDio,
      geoJsonDio: failingDio,
      cache: cache,
    );

    final dataset = await repository.fetch(span: SeismicitySpan.p1m);

    expect(dataset.isFromCache, isTrue);
    expect(dataset.events.single.eventId, 'eq-1');
  });

  test('取得失敗かつキャッシュも無い場合は例外を再送出する', () async {
    final failingDio = Dio(BaseOptions(baseUrl: 'https://example.com'))
      ..httpClientAdapter = _FailingAdapter();
    final cache = SeismicityLocalCacheDataSource(
      directoryProvider: () async => tempDir,
    );
    final repository = SeismicityRepository(
      manifestDio: failingDio,
      geoJsonDio: failingDio,
      cache: cache,
    );

    expect(
      () => repository.fetch(span: SeismicitySpan.p1m),
      throwsA(isA<DioException>()),
    );
  });
}
