import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:eqmonitor/core/api/api_client_provider.dart';
import 'package:eqmonitor/core/provider/log/talker.dart' as talker_lib;
import 'package:eqmonitor/core/realtime/data_source/eqmonitor/eqmonitor_ws_provider.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod/riverpod.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:web_socket/web_socket.dart';

final class FakeWebSocket implements WebSocket {
  new();

  final _controller = StreamController<WebSocketEvent>();
  // ignore: omit_obvious_property_types
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

  group('eqmonitorWebSocketTicket', () {
    test('does not refresh only because the ticket expires while listened', () {
      fakeAsync((async) {
        final adapter = _RealtimeTicketAdapter();
        final dio = Dio(BaseOptions(baseUrl: 'https://example.com'))
          ..httpClientAdapter = adapter;
        final container = ProviderContainer(
          overrides: [
            apiClientProvider.overrideWith((ref) async => api.ApiClient(dio)),
          ],
        );
        addTearDown(container.dispose);

        container.listen(eqmonitorWebSocketTicketProvider, (_, _) {});
        container.read(eqmonitorWebSocketTicketProvider.future).ignore();
        async.flushMicrotasks();
        async.elapse(Duration.zero);
        async.flushMicrotasks();

        final ticket = container.read(eqmonitorWebSocketTicketProvider).value;
        expect(ticket?.url, 'wss://example.com/ws?ticket=1');
        expect(adapter.requestCount, 1);

        async.elapse(const Duration(seconds: 20));
        async.flushMicrotasks();

        expect(adapter.requestCount, 1);
      });
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
      for (var i = 0; i < 30 && connectCount < 2; i++) {
        await Future<void>.delayed(const Duration(milliseconds: 50));
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

final class _RealtimeTicketAdapter implements HttpClientAdapter {
  // ignore: omit_obvious_property_types
  int requestCount = 0;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requestCount++;
    final issuedAt = DateTime.now().toUtc();
    return ResponseBody.fromString(
      jsonEncode({
        'url': 'wss://example.com/ws?ticket=$requestCount',
        'expiresAt': issuedAt
            .add(const Duration(seconds: 45))
            .toIso8601String(),
        'issuedAt': issuedAt.toIso8601String(),
      }),
      200,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}
