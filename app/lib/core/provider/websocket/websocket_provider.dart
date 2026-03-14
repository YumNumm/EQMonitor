import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:ui';

import 'package:eqmonitor/core/api/api_client_provider.dart';
import 'package:eqmonitor/core/provider/app_lifecycle.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/core/provider/telegram_url/provider/telegram_url_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:web_socket_client/web_socket_client.dart';

part 'websocket_provider.g.dart';

@Riverpod(keepAlive: true)
Future<WebSocket> websocket(Ref ref) async {
  final api = ref.watch(apiClientProvider);
  final response = await api.webSocket.getV2WebsocketTicket();
  final body = response.data;
  talker.debug(
    'WebSocket Ticketを取得しました: ${body.ticket.substring(0, 8)}..., '
    '有効期限: ${body.expiresAt.toIso8601String()}',
  );
  final ticket = body.ticket;
  final wsApiUrl = ref.watch(telegramUrlProvider.select((v) => v.wsApiUrl));

  // チケットをクエリパラメータに追加
  final uri = Uri.parse(wsApiUrl).replace(
    queryParameters: {'ticket': ticket},
  );

  final backoff = BinaryExponentialBackoff(
    initial: const Duration(milliseconds: 100),
    maximumStep: 10,
  );
  final socket = WebSocket(
    uri,
    pingInterval: const Duration(seconds: 5),
    backoff: backoff,
  );
  ref
    ..onDispose(() {
      socket.close(1000, 'Connection closed');
    })
    ..listen(appLifecycleProvider, (_, next) {
      // backgroundになったら接続を閉じる
      if (next == AppLifecycleState.paused) {
        socket.close(1000, 'Connection closed');
        log('WebSocket connection closed');
      }
      if (next == AppLifecycleState.resumed) {
        ref.invalidateSelf();
      }
    });

  log('WebSocket connection created with ticket');
  return socket;
}

@Riverpod(keepAlive: true)
class WebsocketStatus extends _$WebsocketStatus {
  @override
  Stream<ConnectionState> build() async* {
    final socket = await ref.watch(websocketProvider.future);
    final streamController = StreamController<ConnectionState>();
    final subscription = socket.connection.listen(streamController.add);
    ref.onDispose(() async {
      await streamController.close();
      await subscription.cancel();
    });
    yield* streamController.stream;
  }
}

@Riverpod(keepAlive: true)
class WebsocketMessages extends _$WebsocketMessages {
  late StreamController<Map<String, dynamic>> _controller;

  @override
  Stream<Map<String, dynamic>> build() async* {
    final socketAsync = ref.watch(websocketProvider);
    _controller = StreamController<Map<String, dynamic>>();
    ref.onDispose(() {
      unawaited(_controller.close());
    });

    await socketAsync.when(
      data: (socket) async {
        socket.messages.listen((message) {
          talker.log('WebSocket message: $message');
          final decoded = jsonDecode(message.toString());
          if (decoded is Map<String, dynamic>) {
            _controller.add(decoded);
          }
        });
      },
      loading: () async {
        talker.warning('WebSocket is loading...');
      },
      error: (error, stack) async {
        talker.error('Failed to setup WebSocket listener: $error', stack);
      },
    );

    yield* _controller.stream;
  }

  void emit(Map<String, dynamic> data) => _controller.add(data);
}
