import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/feature/seismicity/data/data_source/hypocenter_archive_probe.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Range 206とPMTiles v3ヘッダーを受理する', () async {
    final adapter = _ProbeAdapter(statusCode: 206);
    final dio = Dio()..httpClientAdapter = adapter;

    final result = await HypocenterArchiveProbe(
      dio: dio,
    ).probe(url: 'https://tiles.example/archive.pmtiles');

    expect(result, isA<Success<void, Exception>>());
    expect(adapter.range, 'bytes=0-127');
  });

  test('Rangeを無視した200応答を拒否する', () async {
    final dio = Dio()..httpClientAdapter = _ProbeAdapter(statusCode: 200);

    final result = await HypocenterArchiveProbe(
      dio: dio,
    ).probe(url: 'https://tiles.example/archive.pmtiles');

    expect(result, isA<Failure<void, Exception>>());
  });

  test('不正なContent-Rangeを拒否する', () async {
    final dio = Dio()
      ..httpClientAdapter = _ProbeAdapter(
        statusCode: 206,
        contentRange: 'bytes 0-63/1024',
      );

    final result = await HypocenterArchiveProbe(
      dio: dio,
    ).probe(url: 'https://tiles.example/archive.pmtiles');

    expect(result, isA<Failure<void, Exception>>());
  });
}

final class _ProbeAdapter implements HttpClientAdapter {
  new({
    required this.statusCode,
    this.contentRange = 'bytes 0-127/1024',
  });

  final int statusCode;
  final String contentRange;
  String? range;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    range = options.headers['Range'] as String?;
    return ResponseBody.fromBytes(
      [...ascii.encode('PMTiles'), 3, ...List.filled(120, 0)],
      statusCode,
      headers: {
        'content-range': [contentRange],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}
