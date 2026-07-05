import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:eqmonitor/feature/seismicity/data/data_source/seismicity_manifest_data_source.dart';
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_span.dart';
import 'package:flutter_test/flutter_test.dart';

class _FixtureAdapter implements HttpClientAdapter {
  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    if (options.path != '/v2/seismicity/manifest') {
      throw StateError('Unexpected path: ${options.path}');
    }
    final body = File(
      'test/fixtures/seismicity/manifest.json',
    ).readAsStringSync();
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
  test('manifest を取得して SeismicityManifest へ変換する', () async {
    final dio = Dio(BaseOptions(baseUrl: 'https://example.com'))
      ..httpClientAdapter = _FixtureAdapter();
    final dataSource = SeismicityManifestDataSource(dio);

    final manifest = await dataSource.fetchManifest();

    expect(manifest.layers.length, 3);
    expect(manifest.layers[0].span, SeismicitySpan.p1m);
    expect(manifest.layers[0].count, 2);
    expect(
      manifest.layers[0].url,
      'https://static.eqmonitor.app/seismicity/p1m.json',
    );
  });
}
