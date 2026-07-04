import 'dart:io';

import 'package:dio/dio.dart';
import 'package:eqmonitor/core/provider/dio_provider.dart';
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_span.dart';
import 'package:eqmonitor/feature/seismicity/data/notifier/seismicity_dataset_notifier.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod/riverpod.dart';

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

void main() {
  final binding = TestWidgetsFlutterBinding.ensureInitialized();

  test('span を指定して SeismicityDataset を取得できる', () async {
    final tempDir = Directory.systemTemp.createTempSync(
      'seismicity_notifier_test',
    );
    addTearDown(() => tempDir.deleteSync(recursive: true));

    // SeismicityRepository の既定キャッシュ(path_provider)は
    // ネイティブ実装を持たないテスト環境向けにモックする。
    binding.defaultBinaryMessenger.setMockMethodCallHandler(
      const MethodChannel('plugins.flutter.io/path_provider'),
      (call) async => tempDir.path,
    );
    addTearDown(
      () => binding.defaultBinaryMessenger.setMockMethodCallHandler(
        const MethodChannel('plugins.flutter.io/path_provider'),
        null,
      ),
    );

    final container = ProviderContainer(
      overrides: [
        dioProvider.overrideWith((ref) async {
          return Dio(BaseOptions(baseUrl: 'https://example.com'))
            ..httpClientAdapter = _SuccessAdapter();
        }),
      ],
    );
    addTearDown(container.dispose);

    final dataset = await container.read(
      seismicityDatasetNotifierProvider(SeismicitySpan.p1m).future,
    );

    expect(dataset.events.single.eventId, 'eq-1');
    expect(dataset.isFromCache, isFalse);
  });
}
