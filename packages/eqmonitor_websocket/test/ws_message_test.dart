import 'package:eqmonitor_websocket/eqmonitor_websocket.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:test/test.dart';

const fixtureTime = '2026-01-01T00:00:00.000Z';

const fullEarthquake = <String, Object?>{
  'event_id': '20260101000000',
  'status': 'NORMAL',
  'origin_time': fixtureTime,
  'origin_time_precision': 'SECOND',
  'hypocenter': {
    'code': '100',
    'name': '石狩地方北部',
    'coordinates': {'latitude': 43.5, 'longitude': 141.5},
    'magnitude': {'type': 'NORMAL', 'value': 5.1},
    'depth': {'type': 'NORMAL', 'value': 20},
  },
  'intensity': {
    'max_intensity': '4',
    'intensity_tree': [
      {
        'intensity': '4',
        'regions': ['100'],
        'stations': ['POINT-1'],
      },
    ],
  },
  'datasources': ['JMA_DISASTER_INFORMATION_XML'],
  'telegrams': [
    {
      'telegram': {
        'id': 'telegram-1',
        'event_id': '20260101000000',
        'serial_no': 1,
        'type': 'VXSE53',
        'title': '震源・震度に関する情報',
        'status': 'NORMAL',
        'info_type': 'PUBLICATION',
        'editorial_office': '気象庁',
        'publishing_office': ['気象庁'],
        'pressed_at': fixtureTime,
        'reported_at': fixtureTime,
        'info_kind': 'VXSE53',
        'info_kind_version': '1.0_1',
        'hash': 'telegram-hash',
        'created_at': fixtureTime,
      },
      'comments': null,
    },
  ],
  'catalog': {'hypocenters': <Object?>[], 'station_records': <Object?>[]},
};

const partialEarthquake = <String, Object?>{
  'event_id': '20260101000000',
  'status': 'NORMAL',
  'origin_time': fixtureTime,
  'origin_time_precision': 'SECOND',
  'hypocenter': {
    'code': '100',
    'name': '石狩地方北部',
    'coordinates': {'latitude': 43.5, 'longitude': 141.5},
    'magnitude': {'type': 'NORMAL', 'value': 5.1},
    'depth': {'type': 'NORMAL', 'value': 20},
  },
  'intensity': {'max_intensity': '4'},
  'datasources': ['JMA_DISASTER_INFORMATION_XML'],
  'telegram_types': ['VXSE53'],
  'earthquake_type': 'NORMAL',
};

const fullEew = <String, Object?>{
  'event_id': '20260101000001',
  'type': 'VXSE45',
  'status': 'NORMAL',
  'info_type': 'PUBLICATION',
  'serial_no': 2,
  'headline': '緊急地震速報（警報）',
  'is_canceled': false,
  'is_warning': true,
  'is_last_info': false,
  'origin_time': fixtureTime,
  'arrival_time': fixtureTime,
  'hypocenter': {
    'code': '100',
    'name': '石狩地方北部',
    'coordinates': {'latitude': 43.5, 'longitude': 141.5},
    'magnitude': 5.1,
    'depth': 20,
  },
  'forecast_intensity': {
    'max_intensity': {'value': '5-', 'is_over': false},
    'regions': <Object?>[],
  },
  'accuracy': {
    'epicenter': 1,
    'hypocenter': 1,
    'depth': 1,
    'magnitude_calculation': 1,
    'number_of_magnitude_calculation': 4,
  },
  'is_plum': false,
  'editorial_office': '気象庁',
  'report_time': fixtureTime,
  'warning': {
    'zones': [
      {'code': '9011', 'name': '北海道道央', 'had_warning': false},
    ],
    'prefectures': [
      {'code': '01', 'name': '北海道', 'had_warning': false},
    ],
    'regions': [
      {'code': '100', 'name': '石狩地方北部', 'had_warning': false},
    ],
  },
};

const fullShakeSnapshot = <String, Object?>{
  'type': 'shake_detection',
  'revision': 42,
  'responseAt': fixtureTime,
  'events': [
    {
      'type': 'shake_detection',
      'eventId': 'shake-canonical',
      'serialNo': 7,
      'createdAt': '2025-12-31T23:59:30.000Z',
      'updatedAt': '2025-12-31T23:59:55.000Z',
      'expiresAt': '2026-01-01T00:00:35.000Z',
      'level': 'Strong',
      'changeReasons': ['level_up'],
      'mergedEvents': [
        {'eventId': 'shake-absorbed', 'mergedAt': '2025-12-31T23:59:50.000Z'},
      ],
      'pointCount': 1,
      'region': {
        'topLeft': {'latitude': 36.0, 'longitude': 139.0},
        'bottomRight': {'latitude': 35.0, 'longitude': 140.0},
      },
      'points': [
        {
          'code': 'POINT-1',
          'name': 'Point 1',
          'region': 'Tokyo',
          'type': 'K-NET',
          'location': {'latitude': 35.5, 'longitude': 139.5},
          'intensity': 3.2,
          'intensityDiff': 0.4,
        },
      ],
      'test': {'targetDeviceId': 'device-1'},
      'correlatedEew': {'eventId': '20260101000001', 'score': 0.9},
    },
  ],
};

void main() {
  group('WsMessage.fromJson realtime contract', () {
    test('full Earthquake trees, telegrams, and catalog parse', () {
      final message =
          WsMessage.fromJson({
                'type': 'realtime',
                'data': {
                  'type': 'earthquake',
                  'operation': 'upsert',
                  'event_id': '20260101000000',
                  'record': fullEarthquake,
                },
              })
              as WsRealtimeMessage;

      final event = message.data as RealtimeEarthquakeUpsertEvent;
      expect(event.payload.record.intensity?.intensityTree, hasLength(1));
      expect(
        event.payload.record.telegrams.single.telegram.type.toJson(),
        'VXSE53',
      );
      expect(event.payload.record.catalog?.hypocenters, isEmpty);
    });

    test('full EEW warning relations parse', () {
      final message =
          WsMessage.fromJson({
                'type': 'realtime',
                'data': {
                  'type': 'eew',
                  'operation': 'upsert',
                  'event_id': '20260101000001',
                  'record': fullEew,
                },
              })
              as WsRealtimeMessage;

      final event = message.data as RealtimeEewUpsertEvent;
      expect(event.payload.record.isWarning, isTrue);
      expect(event.payload.record.warning?.zones.single.code, '9011');
    });

    test('shake points, merged events, and correlation parse', () {
      final message =
          WsMessage.fromJson({
                'type': 'realtime',
                'data': {
                  'type': 'shake_detection',
                  'operation': 'snapshot',
                  'record': fullShakeSnapshot,
                },
              })
              as WsRealtimeMessage;

      final event = message.data as RealtimeShakeDetectionSnapshotEvent;
      final shake = event.payload.record.events.single;
      expect(shake.points.single.intensity, 3.2);
      expect(shake.mergedEvents.single.eventId, 'shake-absorbed');
      expect(shake.correlatedEew?.eventId, '20260101000001');
    });

    test('earthquake delete parses without record', () {
      final message =
          WsMessage.fromJson({
                'type': 'realtime',
                'data': {
                  'type': 'earthquake',
                  'operation': 'delete',
                  'event_id': '20260101000000',
                },
              })
              as WsRealtimeMessage;

      final event = message.data as RealtimeEarthquakeDeleteEvent;
      expect(event.payload.eventId, '20260101000000');
    });

    test('partial Earthquake record is rejected', () {
      expect(
        () => WsMessage.fromJson({
          'type': 'realtime',
          'data': {
            'type': 'earthquake',
            'operation': 'upsert',
            'event_id': '20260101000000',
            'record': partialEarthquake,
          },
        }),
        throwsA(isA<CheckedFromJsonException>()),
      );
    });

    test('uppercase EEW is rejected', () {
      expect(
        () => WsMessage.fromJson({
          'type': 'realtime',
          'data': {'type': 'EEW', 'item': fullEew},
        }),
        throwsA(isA<CheckedFromJsonException>()),
      );
    });

    test('legacy shake_detected envelope is rejected', () {
      expect(
        () => WsMessage.fromJson({
          'type': 'realtime',
          'data': {
            'type': 'shake_detected',
            'eventId': 'shake-old',
            'createdAt': fixtureTime,
            'level': 'Medium',
            'changeReasons': ['new_event'],
            'isReplay': false,
            'pointCount': 0,
            'region': {
              'topLeft': {'latitude': 35, 'longitude': 135},
              'bottomRight': {'latitude': 34, 'longitude': 136},
            },
            'points': <Object?>[],
          },
        }),
        throwsA(isA<CheckedFromJsonException>()),
      );
    });
  });
}
