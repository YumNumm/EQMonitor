import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_model_converter.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('WebSocketの観測点JMAコードをdomain modelへ保持する', () {
    final envelope = api.RealtimeEventEnvelope.fromJson({
      'type': 'shake_detection',
      'revision': 42,
      'responseAt': '2026-08-02T01:02:03Z',
      'events': [
        {
          'type': 'shake_detection',
          'eventId': 'shake-1',
          'serialNo': 3,
          'createdAt': '2026-08-02T01:01:00Z',
          'updatedAt': '2026-08-02T01:02:00Z',
          'expiresAt': '2026-08-02T01:03:00Z',
          'level': 'Strong',
          'changeReasons': ['points_changed'],
          'mergedEvents': [],
          'pointCount': 1,
          'region': {
            'topLeft': {'latitude': 36.0, 'longitude': 139.0},
            'bottomRight': {'latitude': 35.0, 'longitude': 140.0},
          },
          'points': [
            {
              'code': 'IBR001',
              'name': '観測点',
              'region': '茨城県',
              'type': 'surface',
              'location': {'latitude': 35.5, 'longitude': 139.5},
              'intensity': 4.2,
              'intensityDiff': 0.3,
              'prefecture_code': '08',
              'region_code': '300',
              'city_code': '0820100',
            },
          ],
        },
      ],
    });
    final payload = switch (envelope) {
      api.RealtimeShakeDetectionSnapshotEvent(:final payload) => payload,
      _ => throw StateError('unexpected realtime event'),
    };

    final snapshot = payload.toShakeDetectionSnapshot();
    final point = snapshot.events.single.points.single;

    expect(point.prefectureCode, '08');
    expect(point.regionCode, '300');
    expect(point.cityCode, '0820100');
  });
}
