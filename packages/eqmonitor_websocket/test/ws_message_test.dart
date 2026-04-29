import 'package:eqmonitor_websocket/src/realtime_event_envelope.dart';
import 'package:eqmonitor_websocket/src/ws_message.dart';
import 'package:eqmonitor_websocket/src/ws_snapshot_data.dart';
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
        'data': {
          'revision': 1,
          'updatedAt': '2025-01-15T12:00:00.000Z',
        },
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
          'operation': 'DELETE',
          'event_id': '20250115120000',
          'record': null,
        },
      };

      final result = WsMessage.fromJson(json);

      expect(result, isA<WsRealtimeMessage>());
      final realtime = result as WsRealtimeMessage;
      expect(realtime.data, isA<WsEarthquakeRealtimeEvent>());
      final eq = realtime.data as WsEarthquakeRealtimeEvent;
      expect(eq.operation, equals('DELETE'));
      expect(eq.eventId, equals('20250115120000'));
      expect(eq.record, isNull);
    });

    test('realtime/shake_detected メッセージを正しくパースできること', () {
      final json = <String, dynamic>{
        'type': 'realtime',
        'data': {
          'type': 'shake_detected',
          'eventId': 'shake-001',
          'createdAt': '2025-01-15T12:00:00.000Z',
          'level': 'Medium',
          'changeReasons': ['new_event'],
          'isReplay': false,
          'pointCount': 10,
          'region': {
            'topLeft': {'latitude': 36.0, 'longitude': 139.0},
            'bottomRight': {'latitude': 35.5, 'longitude': 140.0},
          },
        },
      };

      final result = WsMessage.fromJson(json);

      expect(result, isA<WsRealtimeMessage>());
      final realtime = result as WsRealtimeMessage;
      expect(realtime.data, isA<WsShakeDetectedRealtimeEvent>());
      final shake = realtime.data as WsShakeDetectedRealtimeEvent;
      expect(shake.eventId, equals('shake-001'));
      expect(shake.level, equals('Medium'));
      expect(shake.isReplay, isFalse);
      expect(shake.pointCount, equals(10));
      expect(shake.region.topLeft.latitude, equals(36.0));
      expect(shake.region.topLeft.longitude, equals(139.0));
      expect(shake.region.bottomRight.latitude, equals(35.5));
      expect(shake.region.bottomRight.longitude, equals(140.0));
    });

    test('realtime/ESTIMATED_INTENSITY メッセージを正しくパースできること', () {
      final json = <String, dynamic>{
        'type': 'realtime',
        'data': {'type': 'ESTIMATED_INTENSITY'},
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
        'operation': 'INSERT',
        'event_id': '20250115120000',
        'record': null,
      };

      final result = RealtimeEventEnvelope.fromJson(json);

      expect(result, isA<WsEarthquakeRealtimeEvent>());
      final eq = result as WsEarthquakeRealtimeEvent;
      expect(eq.operation, equals('INSERT'));
      expect(eq.eventId, equals('20250115120000'));
      expect(eq.record, isNull);
    });

    test('earthquake delete を正しくパースできること', () {
      final json = <String, dynamic>{
        'type': 'earthquake',
        'operation': 'DELETE',
        'event_id': '20250115120000',
      };

      final result = RealtimeEventEnvelope.fromJson(json);

      expect(result, isA<WsEarthquakeRealtimeEvent>());
      final eq = result as WsEarthquakeRealtimeEvent;
      expect(eq.operation, equals('DELETE'));
    });

    test('tsunami を正しくパースできること', () {
      final json = <String, dynamic>{
        'type': 'tsunami',
        'operation': 'INSERT',
        'event_id': 'tsunami-001',
        'record': {'key': 'value'},
      };

      final result = RealtimeEventEnvelope.fromJson(json);

      expect(result, isA<WsTsunamiRealtimeEvent>());
      final tsunami = result as WsTsunamiRealtimeEvent;
      expect(tsunami.operation, equals('INSERT'));
      expect(tsunami.eventId, equals('tsunami-001'));
      expect(tsunami.record, equals({'key': 'value'}));
    });

    test('shake_detected の is_replay=true を正しくパースできること', () {
      final json = <String, dynamic>{
        'type': 'shake_detected',
        'eventId': 'replay-001',
        'createdAt': '2025-06-01T09:00:00.000Z',
        'level': 'Weak',
        'changeReasons': ['level_changed'],
        'isReplay': true,
        'pointCount': 3,
        'region': {
          'topLeft': {'latitude': 35.0, 'longitude': 136.0},
          'bottomRight': {'latitude': 34.0, 'longitude': 137.0},
        },
      };

      final result = RealtimeEventEnvelope.fromJson(json);

      expect(result, isA<WsShakeDetectedRealtimeEvent>());
      final shake = result as WsShakeDetectedRealtimeEvent;
      expect(shake.isReplay, isTrue);
      expect(shake.pointCount, equals(3));
    });

    test('ESTIMATED_INTENSITY を正しくパースできること', () {
      final json = <String, dynamic>{'type': 'ESTIMATED_INTENSITY'};

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
