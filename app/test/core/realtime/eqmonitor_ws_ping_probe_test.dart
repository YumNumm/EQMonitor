import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:eqmonitor/core/provider/log/talker.dart' as talker_lib;
import 'package:eqmonitor/core/realtime/data_source/eqmonitor/eqmonitor_ws_payload_stream.dart';
import 'package:eqmonitor/core/realtime/data_source/eqmonitor/eqmonitor_ws_ping_probe.dart';
import 'package:eqmonitor/core/realtime/data_source/eqmonitor/eqmonitor_ws_provider.dart';
import 'package:eqmonitor/core/realtime/data_source/eqmonitor/eqmonitor_ws_status_notifier.dart';
import 'package:eqmonitor_websocket/eqmonitor_websocket.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod/riverpod.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:web_socket/web_socket.dart';

final class _RecordingWebSocket implements WebSocket {
  new();

  final _controller = StreamController<WebSocketEvent>();
  final sent = <String>[];
  var sendShouldThrow = false;

  @override
  Stream<WebSocketEvent> get events => _controller.stream;

  bool get hasListener => _controller.hasListener;

  @override
  String get protocol => '';

  void emitText(String text) => _controller.add(TextDataReceived(text));

  @override
  Future<void> close([int? code, String? reason]) async {}

  @override
  void sendBytes(Uint8List b) {}

  @override
  void sendText(String s) {
    if (sendShouldThrow) {
      throw WebSocketConnectionClosed();
    }
    sent.add(s);
  }
}

/// 送信済み ping フレームから pingId を取り出す。
List<String> _pingIdsOf(_RecordingWebSocket ws) => ws.sent
    .map((e) => jsonDecode(e) as Map<String, dynamic>)
    .where((e) => e['type'] == 'ping')
    .map((e) => e['pingId']! as String)
    .toList();

Future<void> _pump([int times = 20]) async {
  for (var i = 0; i < times; i++) {
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

  group('eqmonitorWsPingProbe', () {
    late _RecordingWebSocket fakeWs;
    late ProviderContainer container;

    setUp(() {
      fakeWs = _RecordingWebSocket();
      container = ProviderContainer(
        overrides: [eqmonitorWebSocketProvider.overrideWith((_) => fakeWs)],
      );
      addTearDown(container.dispose);
    });

    test('接続が確立したら pingId 付き ping を送ること', () async {
      container.listen(eqmonitorWsPingProbeProvider, (_, _) {});
      await _pump();

      expect(_pingIdsOf(fakeWs), hasLength(1));
    });

    test('echo された pong から RTT を記録すること', () async {
      container.listen(eqmonitorWsPingProbeProvider, (_, _) {});
      await _pump();
      final pingId = _pingIdsOf(fakeWs).single;

      fakeWs.emitText(jsonEncode({'type': 'pong', 'pingId': pingId}));
      await _pump();

      final sample = container.read(eqmonitorWsPingProbeProvider);
      expect(sample, isNotNull);
      expect(sample!.rtt, greaterThanOrEqualTo(Duration.zero));
      expect(sample.rtt, lessThan(const Duration(seconds: 30)));
    });

    test('送っていない pingId の pong では RTT を記録しないこと', () async {
      container.listen(eqmonitorWsPingProbeProvider, (_, _) {});
      await _pump();

      fakeWs.emitText(jsonEncode({'type': 'pong', 'pingId': 'not-mine'}));
      await _pump();

      expect(container.read(eqmonitorWsPingProbeProvider), isNull);
    });

    test('pingId を返さない旧サーバーの pong を RTT にしないこと', () async {
      container.listen(eqmonitorWsPingProbeProvider, (_, _) {});
      await _pump();

      fakeWs.emitText(jsonEncode({'type': 'pong'}));
      await _pump();

      expect(container.read(eqmonitorWsPingProbeProvider), isNull);
    });

    test('サーバー起因 ping を RTT として扱わないこと', () async {
      container.listen(eqmonitorWsPingProbeProvider, (_, _) {});
      await _pump();

      fakeWs.emitText(jsonEncode({'type': 'ping'}));
      await _pump();

      expect(container.read(eqmonitorWsPingProbeProvider), isNull);
    });

    test('再接続すると前の接続の RTT を持ち越さないこと', () async {
      var connectCount = 0;
      final ws1 = _RecordingWebSocket();
      final ws2 = _RecordingWebSocket();
      final testContainer = ProviderContainer(
        overrides: [
          eqmonitorWebSocketProvider.overrideWith((_) {
            connectCount++;
            return connectCount == 1 ? ws1 : ws2;
          }),
        ],
      );
      addTearDown(testContainer.dispose);

      testContainer.listen(eqmonitorWsPingProbeProvider, (_, _) {});
      await _pump();
      ws1.emitText(
        jsonEncode({'type': 'pong', 'pingId': _pingIdsOf(ws1).single}),
      );
      await _pump();
      expect(testContainer.read(eqmonitorWsPingProbeProvider), isNotNull);

      testContainer.invalidate(eqmonitorWebSocketProvider);
      await _pump();

      expect(testContainer.read(eqmonitorWsPingProbeProvider), isNull);
      expect(_pingIdsOf(ws2), hasLength(1));
      // 接続をまたいで pingId が再利用されないこと
      expect(_pingIdsOf(ws2).single, isNot(_pingIdsOf(ws1).single));
    });

    test('送信に失敗しても例外を投げず、以降の送出を止めること', () async {
      fakeWs.sendShouldThrow = true;

      container.listen(eqmonitorWsPingProbeProvider, (_, _) {});
      await _pump();

      expect(container.read(eqmonitorWsPingProbeProvider), isNull);
      expect(fakeWs.sent, isEmpty);
    });
  });

  group('eqmonitorWsPayloadStream', () {
    test('同一内容のフレームが連続しても取りこぼさないこと', () async {
      // Riverpod は前回の state と `==` なら listener に通知しない。
      // WsPingMessage はフィールドを持たないため、連番がないと 2 回目以降の
      // サーバー ping が観測できなくなる。
      final fakeWs = _RecordingWebSocket();
      final container = ProviderContainer(
        overrides: [eqmonitorWebSocketProvider.overrideWith((_) => fakeWs)],
      );
      addTearDown(container.dispose);

      final received = <WsMessage>[];
      container.listen(eqmonitorWsPayloadStreamProvider, (_, next) {
        next.whenData(received.add);
      });
      await _pump();

      fakeWs
        ..emitText('{"type":"ping"}')
        ..emitText('{"type":"ping"}')
        ..emitText('{"type":"ping"}');
      await _pump();

      expect(received, everyElement(isA<WsPingMessage>()));
      expect(received, hasLength(3));
    });
  });

  group('eqMonitorWsStatus', () {
    test('2 回目以降のサーバー ping も観測して受信間隔を出せること', () async {
      final fakeWs = _RecordingWebSocket();
      final container = ProviderContainer(
        overrides: [eqmonitorWebSocketProvider.overrideWith((_) => fakeWs)],
      );
      addTearDown(container.dispose);

      container.listen(eqMonitorWsStatusProvider, (_, _) {});
      await _pump();

      fakeWs.emitText('{"type":"ping"}');
      await _pump();
      final firstPingAt = container.read(eqMonitorWsStatusProvider).lastPingAt;
      expect(firstPingAt, isNotNull);

      fakeWs.emitText('{"type":"ping"}');
      await _pump();

      final status = container.read(eqMonitorWsStatusProvider);
      expect(status.lastPingAt, isNot(firstPingAt));
      expect(status.serverPingInterval, isNotNull);
    });
  });
}
