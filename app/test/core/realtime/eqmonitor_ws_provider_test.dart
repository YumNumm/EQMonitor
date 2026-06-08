import 'dart:async';
import 'dart:typed_data';

import 'package:eqmonitor/core/provider/log/talker.dart' as talker_lib;
import 'package:eqmonitor/core/realtime/data_source/eqmonitor/eqmonitor_ws_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod/riverpod.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:web_socket/web_socket.dart';

final class FakeWebSocket implements WebSocket {
  FakeWebSocket();

  final _controller = StreamController<WebSocketEvent>();
  bool closeCalled = false;

  @override
  Stream<WebSocketEvent> get events => _controller.stream;

  bool get hasListener => _controller.hasListener;

  @override
  String get protocol => '';

  void emitText(String text) => _controller.add(TextDataReceived(text));

  void emitClose([int? code, String reason = '']) {
    _controller
      ..add(CloseReceived(code, reason))
      ..close(); // ignore: discarded_futures
  }

  @override
  Future<void> close([int? code, String? reason]) async {
    if (closeCalled) {
      throw WebSocketConnectionClosed();
    }
    closeCalled = true;
  }

  @override
  void sendBytes(Uint8List b) {}

  @override
  void sendText(String s) {}
}

Future<void> _pumpUntilListening(FakeWebSocket ws) async {
  for (var i = 0; i < 20 && !ws.hasListener; i++) {
    await Future<void>.delayed(Duration.zero);
  }
}

void main() {
  setUpAll(() {
    try {
      talker_lib.talker = Talker();
      // ignore: avoid_catching_errors
    } on Error catch (_) {}
  });

  group('EqmonitorWebSocketTicketRefreshDelayCalculator', () {
    test('ticket refresh delay never becomes negative', () {
      const calculator = EqmonitorWebSocketTicketRefreshDelayCalculator();
      final now = DateTime.utc(2026, 6, 4, 12);
      final expiresAt = now.add(const Duration(seconds: 10));

      final delay = calculator.calculate(now: now, expiresAt: expiresAt);

      expect(delay, Duration.zero);
    });

    test('returns (expiresAt - now - 30s) when positive', () {
      const calculator = EqmonitorWebSocketTicketRefreshDelayCalculator();
      final now = DateTime.utc(2026, 6, 4, 12);
      final expiresAt = now.add(const Duration(minutes: 5));

      final delay = calculator.calculate(now: now, expiresAt: expiresAt);

      expect(delay, const Duration(minutes: 4, seconds: 30));
    });
  });

  group('eqmonitorWsEventStream', () {
    late FakeWebSocket fakeWs;
    late ProviderContainer container;

    setUp(() {
      fakeWs = FakeWebSocket();
      container = ProviderContainer(
        overrides: [
          eqmonitorWebSocketProvider.overrideWith((_) => fakeWs),
        ],
      );
    });

    tearDown(() => container.dispose());

    test('forwards WebSocket events to the stream', () async {
      fakeWs.emitText('hello');

      container.listen(eqmonitorWsEventStreamProvider, (_, _) {});
      final value = await container.read(eqmonitorWsEventStreamProvider.future);

      expect(value, isA<TextDataReceived>());
      expect((value as TextDataReceived).text, 'hello');
    });

    test('re-creates WebSocket connection on close', () async {
      var connectCount = 0;
      final ws1 = FakeWebSocket();
      final ws2 = FakeWebSocket();

      final testContainer = ProviderContainer(
        overrides: [
          eqmonitorWebSocketProvider.overrideWith((_) {
            connectCount++;
            return connectCount == 1 ? ws1 : ws2;
          }),
        ],
      );
      addTearDown(testContainer.dispose);

      testContainer.listen(eqmonitorWsEventStreamProvider, (_, _) {});
      await _pumpUntilListening(ws1);

      ws1.emitClose(1000, 'normal');
      for (var i = 0; i < 200 && connectCount < 2; i++) {
        await Future<void>.delayed(Duration.zero);
      }

      expect(connectCount, 2);
    });

    test('single-subscription stream is listened to only once', () async {
      fakeWs.emitText('init');
      container.listen(eqmonitorWsEventStreamProvider, (_, _) {});

      final value = await container.read(eqmonitorWsEventStreamProvider.future);
      expect(value, isA<TextDataReceived>());
    });
  });
}
