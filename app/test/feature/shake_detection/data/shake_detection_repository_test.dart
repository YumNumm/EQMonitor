import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_level.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_snapshot.dart';
import 'package:eqmonitor/feature/shake_detection/data/repository/shake_detection_repository.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter_test/flutter_test.dart';

final class _ShakeDetectionAdapter implements HttpClientAdapter {
  new({required this.statusCode, this.responseBody});

  final int statusCode;
  final String? responseBody;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    expect(options.path, '/v2/shake-detection/active');
    final body =
        responseBody ??
        (statusCode == 200
            ? _activeSnapshotBody
            : jsonEncode({
                'code': 'SERVICE_UNAVAILABLE',
                'message': 'Shake detection state is not available.',
              }));
    return ResponseBody.fromString(
      body,
      statusCode,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

final _activeSnapshotBody = jsonEncode({
  'type': 'shake_detection',
  'revision': 42,
  'responseAt': '2026-07-18T12:34:56.789Z',
  'events': [
    {
      'type': 'shake_detection',
      'eventId': 'shake-1',
      'serialNo': 3,
      'createdAt': '2026-07-18T12:34:30.000Z',
      'updatedAt': '2026-07-18T12:34:55.000Z',
      'expiresAt': '2026-07-18T12:35:35.000Z',
      'level': 'Strong',
      'changeReasons': ['level_up'],
      'mergedEvents': [],
      'pointCount': 1,
      'region': {
        'topLeft': {'latitude': 36.0, 'longitude': 139.0},
        'bottomRight': {'latitude': 35.0, 'longitude': 140.0},
      },
      'points': [],
      'correlatedEew': {'eventId': 'eew-1', 'score': 0.8},
    },
  ],
});

ApiShakeDetectionRepository repositoryFor({
  required int statusCode,
  String? responseBody,
}) {
  final dio = Dio(BaseOptions(baseUrl: 'https://example.com'))
    ..httpClientAdapter = _ShakeDetectionAdapter(
      statusCode: statusCode,
      responseBody: responseBody,
    );
  return ApiShakeDetectionRepository(client: api.ShakeDetectionApiClient(dio));
}

void main() {
  test('active snapshotをdomain modelへ変換すること', () async {
    final result = await repositoryFor(statusCode: 200).fetchActive();
    final snapshot =
        (result as Success<ShakeDetectionSnapshot, ShakeDetectionApiException>)
            .value;
    final event = snapshot.events.single;

    expect(snapshot.revision, 42);
    expect(snapshot.responseAt, DateTime.parse('2026-07-18T12:34:56.789Z'));
    expect(event.eventId, 'shake-1');
    expect(event.serialNo, 3);
    expect(event.createdAt, DateTime.parse('2026-07-18T12:34:30.000Z'));
    expect(event.updatedAt, DateTime.parse('2026-07-18T12:34:55.000Z'));
    expect(event.level, ShakeDetectionLevel.strong);
    expect(event.pointCount, 1);
    expect(event.minLat, 35);
    expect(event.maxLat, 36);
    expect(event.minLng, 139);
    expect(event.maxLng, 140);
    expect(event.changeReasons, ['level_up']);
    expect(event.correlatedEewEventId, 'eew-1');
    expect(event.expiresAt, DateTime.parse('2026-07-18T12:35:35.000Z'));
  });

  test('503をtyped failureとして返すこと', () async {
    final result = await repositoryFor(statusCode: 503).fetchActive();
    final failure =
        result as Failure<ShakeDetectionSnapshot, ShakeDetectionApiException>;

    expect(failure.exception.statusCode, 503);
  });

  test('未知levelをtyped failureとして返すこと', () async {
    final result = await repositoryFor(
      statusCode: 200,
      responseBody: _activeSnapshotBody.replaceFirst('Strong', 'Unknown'),
    ).fetchActive();

    expect(
      result,
      isA<Failure<ShakeDetectionSnapshot, ShakeDetectionApiException>>(),
    );
  });
}
