import 'package:eqmonitor_websocket/src/realtime_event_envelope.dart';
import 'package:eqmonitor_websocket/src/ws_message.dart';
import 'package:eqmonitor_websocket/src/ws_realtime_operation.dart';
import 'package:eqmonitor_websocket/src/ws_snapshot_data.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:test/test.dart';

void main() {
  group('WsMessage.fromJson', () {
    test('snapshot メッセージを正しくパースできること', () {
      final json = <String, dynamic>{
        'type': 'snapshot',
        'data': {
          'revision': 42,
          'updatedAt': '2025-01-15T12:00:00.000Z',
          'eews': <dynamic>[],
          'earthquakes': <dynamic>[],
        },
      };

      final result = WsMessage.fromJson(json);

      expect(result, isA<WsSnapshotMessage>());
      final snapshot = result as WsSnapshotMessage;
      expect(snapshot.data.revision, equals(42));
      expect(snapshot.data.eews, isEmpty);
      expect(snapshot.data.earthquakes, isEmpty);
    });

    test('snapshot の eews/earthquakes フィールドが省略された場合デフォルト空リストになること', () {
      final json = <String, dynamic>{
        'type': 'snapshot',
        'data': {'revision': 1, 'updatedAt': '2025-01-15T12:00:00.000Z'},
      };

      final result = WsMessage.fromJson(json);

      expect(result, isA<WsSnapshotMessage>());
      final snapshot = result as WsSnapshotMessage;
      expect(snapshot.data.eews, isEmpty);
      expect(snapshot.data.earthquakes, isEmpty);
    });

    test('realtime/earthquake メッセージを正しくパースできること', () {
      final json = <String, dynamic>{
        'type': 'realtime',
        'data': {
          'type': 'earthquake',
          'operation': 'delete',
          'event_id': '20250115120000',
          'record': null,
        },
      };

      final result = WsMessage.fromJson(json);

      expect(result, isA<WsRealtimeMessage>());
      final realtime = result as WsRealtimeMessage;
      expect(realtime.data, isA<WsEarthquakeRealtimeEvent>());
      final eq = realtime.data as WsEarthquakeRealtimeEvent;
      expect(eq.operation, equals(WsRealtimeOperation.delete));
      expect(eq.eventId, equals('20250115120000'));
      expect(eq.record, isNull);
    });

    test('realtime/shake_detection の完全snapshotをパースできること', () {
      final result = WsMessage.fromJson({
        'type': 'realtime',
        'data': {
          'type': 'shake_detection',
          'revision': 42,
          'responseAt': '2026-07-18T12:34:56.789Z',
          'events': [
            {
              'type': 'shake_detection',
              'eventId': 'shake-canonical',
              'serialNo': 7,
              'createdAt': '2026-07-18T12:34:30.000Z',
              'updatedAt': '2026-07-18T12:34:55.000Z',
              'expiresAt': '2026-07-18T12:35:35.000Z',
              'level': 'Strong',
              'changeReasons': ['level_up'],
              'mergedEvents': [
                {
                  'eventId': 'shake-absorbed',
                  'mergedAt': '2026-07-18T12:34:50.000Z',
                },
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
              'correlatedEew': {'eventId': 'eew-1', 'score': 0.9},
            },
          ],
        },
      });

      final message = result as WsRealtimeMessage;
      final snapshot = message.data as WsShakeDetectionRealtimeEvent;
      expect(snapshot.revision, 42);
      expect(snapshot.responseAt, DateTime.parse('2026-07-18T12:34:56.789Z'));
      expect(snapshot.events.single.eventId, 'shake-canonical');
      expect(snapshot.events.single.serialNo, 7);
      expect(
        snapshot.events.single.expiresAt,
        DateTime.parse('2026-07-18T12:35:35.000Z'),
      );
      expect(
        snapshot.events.single.mergedEvents.single.eventId,
        'shake-absorbed',
      );
      expect(snapshot.events.single.correlatedEew?.eventId, 'eew-1');
    });

    test('realtime/shake_detection の events が空配列でもパースできること', () {
      final result = WsMessage.fromJson({
        'type': 'realtime',
        'data': {
          'type': 'shake_detection',
          'revision': 43,
          'responseAt': '2026-07-18T12:35:56.789Z',
          'events': <dynamic>[],
        },
      });

      final message = result as WsRealtimeMessage;
      final snapshot = message.data as WsShakeDetectionRealtimeEvent;
      expect(snapshot.events, isEmpty);
    });

    test('realtime/shake_detection の events が省略された場合は拒否すること', () {
      expect(
        () => WsMessage.fromJson({
          'type': 'realtime',
          'data': {
            'type': 'shake_detection',
            'revision': 43,
            'responseAt': '2026-07-18T12:35:56.789Z',
          },
        }),
        throwsA(isA<CheckedFromJsonException>()),
      );
    });

    test('realtime/shake_detection の events が null の場合は拒否すること', () {
      expect(
        () => WsMessage.fromJson({
          'type': 'realtime',
          'data': {
            'type': 'shake_detection',
            'revision': 43,
            'responseAt': '2026-07-18T12:35:56.789Z',
            'events': null,
          },
        }),
        throwsA(isA<CheckedFromJsonException>()),
      );
    });

    test('legacy realtime/shake_detected は拒否すること', () {
      expect(
        () => WsMessage.fromJson({
          'type': 'realtime',
          'data': {'type': 'shake_detected', 'eventId': 'legacy-shake'},
        }),
        throwsA(isA<CheckedFromJsonException>()),
      );
    });

    test('realtime/ESTIMATED_INTENSITY メッセージを正しくパースできること', () {
      final json = <String, dynamic>{
        'type': 'realtime',
        'data': {
          'type': 'ESTIMATED_INTENSITY',
          'estimatedIntensity': {
            'eventId': 'test-event',
            'estimatedIntensityKey': 'test-key',
            'createdAt': '2025-01-15T12:00:00.000Z',
          },
        },
      };

      final result = WsMessage.fromJson(json);

      expect(result, isA<WsRealtimeMessage>());
      final realtime = result as WsRealtimeMessage;
      expect(realtime.data, isA<WsEstimatedIntensityRealtimeEvent>());
    });
  });

  group('RealtimeEventEnvelope.fromJson', () {
    test('earthquake upsert を正しくパースできること', () {
      final json = <String, dynamic>{
        'type': 'earthquake',
        'operation': 'upsert',
        'event_id': '20250115120000',
        'record': null,
      };

      final result = RealtimeEventEnvelope.fromJson(json);

      expect(result, isA<WsEarthquakeRealtimeEvent>());
      final eq = result as WsEarthquakeRealtimeEvent;
      expect(eq.operation, equals(WsRealtimeOperation.upsert));
      expect(eq.eventId, equals('20250115120000'));
      expect(eq.record, isNull);
    });

    test('earthquake delete を正しくパースできること', () {
      final json = <String, dynamic>{
        'type': 'earthquake',
        'operation': 'delete',
        'event_id': '20250115120000',
      };

      final result = RealtimeEventEnvelope.fromJson(json);

      expect(result, isA<WsEarthquakeRealtimeEvent>());
      final eq = result as WsEarthquakeRealtimeEvent;
      expect(eq.operation, equals(WsRealtimeOperation.delete));
    });

    test('tsunami を正しくパースできること', () {
      final json = <String, dynamic>{
        'type': 'tsunami',
        'operation': 'upsert',
        'event_id': 'tsunami-001',
        'record': {'key': 'value'},
      };

      final result = RealtimeEventEnvelope.fromJson(json);

      expect(result, isA<WsTsunamiRealtimeEvent>());
      final tsunami = result as WsTsunamiRealtimeEvent;
      expect(tsunami.operation, equals(WsRealtimeOperation.upsert));
      expect(tsunami.eventId, equals('tsunami-001'));
      expect(tsunami.record, equals({'key': 'value'}));
    });

    test('ESTIMATED_INTENSITY を正しくパースできること', () {
      final json = <String, dynamic>{
        'type': 'ESTIMATED_INTENSITY',
        'estimatedIntensity': {
          'eventId': 'test-event',
          'estimatedIntensityKey': 'test-key',
          'createdAt': '2025-01-15T12:00:00.000Z',
        },
      };

      final result = RealtimeEventEnvelope.fromJson(json);

      expect(result, isA<WsEstimatedIntensityRealtimeEvent>());
    });
  });

  group('WsSnapshotData.fromJson', () {
    test('updatedAt が正しくパースされること', () {
      final json = <String, dynamic>{
        'revision': 5,
        'updatedAt': '2025-03-20T08:30:00.000Z',
        'eews': <dynamic>[],
        'earthquakes': <dynamic>[],
      };

      final result = WsSnapshotData.fromJson(json);

      expect(result.revision, equals(5));
      expect(result.updatedAt, equals(DateTime.utc(2025, 3, 20, 8, 30)));
    });
  });
}
