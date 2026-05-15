import 'package:eqmonitor_websocket/eqmonitor_websocket.dart';
import 'package:test/test.dart';

Map<String, dynamic> _baseEewItem() => <String, dynamic>{
  'event_id': '20250115120000',
  'type': 'VXSE45',
  'status': 'NORMAL',
  'info_type': 'PUBLICATION',
  'serial_no': 1,
  'headline': null,
  'is_canceled': false,
  'is_warning': false,
  'is_last_info': false,
  'origin_time': null,
  'arrival_time': null,
  'accuracy': null,
  'is_plum': false,
  'editorial_office': null,
  'report_time': '2025-01-15T12:00:00.000Z',
};

Map<String, dynamic> _baseEarthquakePartial() => <String, dynamic>{
  'event_id': '20250115120000',
  'status': 'NORMAL',
  'origin_time_precision': 'SECOND',
  'datasource': 'JMA_DISASTER_INFORMATION_XML',
};

void main() {
  group('WsMessage.fromJson — top-level discriminator', () {
    test('ping を WsPingMessage としてパースできること', () {
      final result = WsMessage.fromJson({'type': 'ping'});
      expect(result, isA<WsPingMessage>());
    });

    test('未知の type で FormatException 系の例外が発生すること', () {
      expect(
        () => WsMessage.fromJson({'type': 'unknown_type'}),
        throwsA(isA<Object>()),
      );
    });
  });

  group('WsMessage.snapshot — eew / earthquakes 込み', () {
    test('snapshot に eew/earthquakes が入っていてもパースできること', () {
      final json = <String, dynamic>{
        'type': 'snapshot',
        'data': {
          'revision': 7,
          'updatedAt': '2025-04-01T00:00:00.000Z',
          'eews': [_baseEewItem()],
          'earthquakes': [_baseEarthquakePartial()],
          'shakes': <dynamic>[],
        },
      };

      final result = WsMessage.fromJson(json);
      expect(result, isA<WsSnapshotMessage>());
      final snapshot = result as WsSnapshotMessage;
      expect(snapshot.data.eews, hasLength(1));
      expect(snapshot.data.earthquakes, hasLength(1));
      expect(snapshot.data.eews.first.eventId, '20250115120000');
      expect(snapshot.data.earthquakes.first.eventId, '20250115120000');
      expect(snapshot.data.shakes, isEmpty);
    });

    test('snapshot に shakes が入っていてもパースできること', () {
      final json = <String, dynamic>{
        'type': 'snapshot',
        'data': {
          'revision': 1,
          'updatedAt': '2025-04-01T00:00:00.000Z',
          'shakes': [
            {
              'eventId': 'shake-snap-1',
              'createdAt': '2025-04-01T00:00:00.000Z',
              'level': 'Strong',
              'changeReasons': <dynamic>[],
              'isReplay': false,
              'pointCount': 12,
              'region': {
                'topLeft': {'latitude': 36.0, 'longitude': 139.0},
                'bottomRight': {'latitude': 35.0, 'longitude': 140.0},
              },
            },
          ],
        },
      };

      final result = WsMessage.fromJson(json);
      expect(result, isA<WsSnapshotMessage>());
      final snapshot = result as WsSnapshotMessage;
      expect(snapshot.data.shakes, hasLength(1));
      expect(snapshot.data.shakes.first.eventId, 'shake-snap-1');
      expect(snapshot.data.shakes.first.level, 'Strong');
      expect(snapshot.data.shakes.first.pointCount, 12);
    });
  });

  group('WsRealtimeOperation enum', () {
    test('upsert / delete それぞれが識別できること', () {
      // sealed enum なので index based ではなく values の長さで verify
      expect(WsRealtimeOperation.values.length, 2);
      expect(WsRealtimeOperation.values, contains(WsRealtimeOperation.upsert));
      expect(WsRealtimeOperation.values, contains(WsRealtimeOperation.delete));
    });
  });

  group('RealtimeEventEnvelope — EEW / EARTHQUAKE broadcast', () {
    test('EEW realtime event を WsEewRealtimeEvent としてパースできること', () {
      final json = <String, dynamic>{'type': 'EEW', 'item': _baseEewItem()};
      final result = RealtimeEventEnvelope.fromJson(json);
      expect(result, isA<WsEewRealtimeEvent>());
      final eew = result as WsEewRealtimeEvent;
      expect(eew.item.eventId, '20250115120000');
    });

    test('EARTHQUAKE broadcast event をパースできること', () {
      final json = <String, dynamic>{
        'type': 'EARTHQUAKE',
        'item': _baseEarthquakePartial(),
      };
      final result = RealtimeEventEnvelope.fromJson(json);
      expect(result, isA<WsEarthquakeBroadcastEvent>());
      final eq = result as WsEarthquakeBroadcastEvent;
      expect(eq.item.eventId, '20250115120000');
    });

    test('未知の type で例外が発生すること', () {
      expect(
        () => RealtimeEventEnvelope.fromJson({'type': 'unknown'}),
        throwsA(isA<Object>()),
      );
    });
  });

  group('RealtimeEventEnvelope — shake_detected の changeReasons', () {
    Map<String, dynamic> shakeJson({List<String>? changeReasons}) =>
        <String, dynamic>{
          'type': 'shake_detected',
          'eventId': 'shake-1',
          'createdAt': '2025-01-15T12:00:00.000Z',
          'level': 'Weak',
          if (changeReasons != null) 'changeReasons': changeReasons,
          'isReplay': false,
          'pointCount': 4,
          'region': {
            'topLeft': {'latitude': 35.0, 'longitude': 139.0},
            'bottomRight': {'latitude': 34.0, 'longitude': 140.0},
          },
        };

    test('changeReasons 省略時はデフォルトの空リストになること', () {
      final result =
          RealtimeEventEnvelope.fromJson(shakeJson())
              as WsShakeDetectedRealtimeEvent;
      expect(result.changeReasons, isEmpty);
    });

    test('changeReasons は受信した順序を保持すること', () {
      final result =
          RealtimeEventEnvelope.fromJson(
                shakeJson(changeReasons: ['a', 'b', 'c']),
              )
              as WsShakeDetectedRealtimeEvent;
      expect(result.changeReasons, ['a', 'b', 'c']);
    });
  });

  group('WsEstimatedIntensityPayload', () {
    test('hypocenter なしでパースできること', () {
      final result = WsEstimatedIntensityPayload.fromJson(<String, dynamic>{
        'eventId': 'e1',
        'estimatedIntensityKey': 'k1',
        'createdAt': '2025-01-15T12:00:00.000Z',
      });
      expect(result.eventId, 'e1');
      expect(result.estimatedIntensityKey, 'k1');
      expect(result.hypocenter, isNull);
    });

    test('hypocenter ありでパースできること', () {
      final result = WsEstimatedIntensityPayload.fromJson(<String, dynamic>{
        'eventId': 'e1',
        'estimatedIntensityKey': 'k1',
        'createdAt': '2025-01-15T12:00:00.000Z',
        'hypocenter': {
          'regionCode': 100,
          'regionName': '関東',
          'originTime': '2025-01-15T12:00:00.000Z',
          'magnitude': 6.5,
          'depthKm': 20.0,
        },
      });
      expect(result.hypocenter, isNotNull);
      expect(result.hypocenter!.regionCode, 100);
      expect(result.hypocenter!.regionName, '関東');
      expect(result.hypocenter!.magnitude, 6.5);
      expect(result.hypocenter!.depthKm, 20.0);
    });

    test('hypocenter の magnitude/depth/regionName は null 許容', () {
      final result = WsEstimatedIntensityPayload.fromJson(<String, dynamic>{
        'eventId': 'e1',
        'estimatedIntensityKey': 'k1',
        'createdAt': '2025-01-15T12:00:00.000Z',
        'hypocenter': {
          'regionCode': 100,
          'originTime': '2025-01-15T12:00:00.000Z',
        },
      });
      expect(result.hypocenter, isNotNull);
      expect(result.hypocenter!.regionName, isNull);
      expect(result.hypocenter!.magnitude, isNull);
      expect(result.hypocenter!.depthKm, isNull);
    });
  });

  group('WsPongMessage', () {
    test('toJson で type=pong が含まれること', () {
      const msg = WsPongMessage();
      final json = msg.toJson();
      expect(json['type'], 'pong');
    });

    test('toJson と fromJson でラウンドトリップできること', () {
      const original = WsPongMessage();
      final json = original.toJson();
      final decoded = WsPongMessage.fromJson(json);
      expect(decoded.type, 'pong');
    });
  });

  group('WsSnapshotShakeEntry', () {
    test('changeReasons 省略時は空リスト', () {
      final json = <String, dynamic>{
        'eventId': 'shake-1',
        'createdAt': '2025-01-15T12:00:00.000Z',
        'level': 'Weak',
        'isReplay': false,
        'pointCount': 2,
        'region': {
          'topLeft': {'latitude': 36.0, 'longitude': 139.0},
          'bottomRight': {'latitude': 35.5, 'longitude': 140.0},
        },
      };
      final result = WsSnapshotShakeEntry.fromJson(json);
      expect(result.changeReasons, isEmpty);
    });
  });

  group('WsShakeRegionPayload', () {
    test('topLeft / bottomRight 双方が緯度経度を保持すること', () {
      final json = <String, dynamic>{
        'topLeft': {'latitude': 36.0, 'longitude': 139.0},
        'bottomRight': {'latitude': 35.0, 'longitude': 140.0},
      };
      final result = WsShakeRegionPayload.fromJson(json);
      expect(result.topLeft.latitude, 36.0);
      expect(result.topLeft.longitude, 139.0);
      expect(result.bottomRight.latitude, 35.0);
      expect(result.bottomRight.longitude, 140.0);
    });
  });
}
