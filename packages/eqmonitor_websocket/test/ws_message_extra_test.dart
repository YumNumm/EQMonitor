import 'package:eqmonitor_websocket/eqmonitor_websocket.dart';
import 'package:test/test.dart';

void main() {
  group('WsMessage.fromJson top-level discriminator', () {
    test('ping parses as WsPingMessage', () {
      expect(WsMessage.fromJson({'type': 'ping'}), isA<WsPingMessage>());
    });

    test('unknown type is rejected', () {
      expect(
        () => WsMessage.fromJson({'type': 'unknown_type'}),
        throwsA(isA<Object>()),
      );
    });
  });

  test('WsRealtimeOperation exposes upsert and delete', () {
    expect(WsRealtimeOperation.values, {
      WsRealtimeOperation.upsert,
      WsRealtimeOperation.delete,
    });
  });

  group('WsEstimatedIntensityPayload', () {
    test('parses without hypocenter', () {
      final result = WsEstimatedIntensityPayload.fromJson(<String, dynamic>{
        'eventId': 'e1',
        'estimatedIntensityKey': 'k1',
        'createdAt': '2025-01-15T12:00:00.000Z',
      });

      expect(result.eventId, 'e1');
      expect(result.hypocenter, isNull);
    });

    test('parses a nullable-field hypocenter', () {
      final result = WsEstimatedIntensityPayload.fromJson(<String, dynamic>{
        'eventId': 'e1',
        'estimatedIntensityKey': 'k1',
        'createdAt': '2025-01-15T12:00:00.000Z',
        'hypocenter': {
          'regionCode': 100,
          'originTime': '2025-01-15T12:00:00.000Z',
        },
      });

      expect(result.hypocenter?.regionCode, 100);
      expect(result.hypocenter?.regionName, isNull);
      expect(result.hypocenter?.magnitude, isNull);
      expect(result.hypocenter?.depthKm, isNull);
    });
  });

  test('WsPongMessage round-trips type=pong', () {
    const original = WsPongMessage();
    final decoded = WsPongMessage.fromJson(original.toJson());

    expect(decoded.type, 'pong');
  });
}
