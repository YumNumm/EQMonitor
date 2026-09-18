import 'package:eqmonitor_websocket/eqmonitor_websocket.dart';
import 'package:test/test.dart';

void main() {
  group('WsMessage.fromJson top-level discriminator', () {
    test('ping parses as WsPingMessage', () {
      expect(WsMessage.fromJson({'type': 'ping'}), isA<WsPingMessage>());
    });

    test('pong parses as WsPongMessage carrying the echoed pingId', () {
      final message = WsMessage.fromJson({'type': 'pong', 'pingId': '7'});

      expect(message, isA<WsPongMessage>());
      expect((message as WsPongMessage).pingId, '7');
    });

    test('pong without pingId still parses', () {
      final message = WsMessage.fromJson({'type': 'pong'});

      expect((message as WsPongMessage).pingId, isNull);
    });

    test('consecutive pongs are not equal, so Riverpod will notify', () {
      // Riverpod は前回の state と `==` なら listener に通知しない。
      // pingId が異なる限り pong は毎回別の値になる。
      expect(
        WsMessage.fromJson({'type': 'pong', 'pingId': '1'}),
        isNot(WsMessage.fromJson({'type': 'pong', 'pingId': '2'})),
      );
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

  test('WsClientPongMessage round-trips type=pong', () {
    const original = WsClientPongMessage();
    final decoded = WsClientPongMessage.fromJson(original.toJson());

    expect(decoded.type, 'pong');
  });

  test('WsClientPingMessage serialises type=ping with a pingId', () {
    const original = WsClientPingMessage(pingId: '42');

    expect(original.toJson(), {'pingId': '42', 'type': 'ping'});
  });
}
