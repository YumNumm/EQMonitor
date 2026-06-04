import 'dart:async';

import 'package:eqmonitor/core/api/api_client_provider.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:web_socket/web_socket.dart';

part 'eqmonitor_ws_provider.g.dart';

final class EqmonitorWebSocketTicketRefreshDelayCalculator {
  const EqmonitorWebSocketTicketRefreshDelayCalculator();

  Duration calculate({
    required DateTime now,
    required DateTime expiresAt,
  }) {
    const buffer = Duration(seconds: 30);
    final rawDelay = expiresAt.difference(now) - buffer;
    return rawDelay.isNegative ? Duration.zero : rawDelay;
  }
}

@Riverpod(keepAlive: true)
Future<WebSocket> eqmonitorWebSocket(Ref ref) async {
  final ticket = await ref.read(eqmonitorWebSocketTicketProvider.future);

  final ws = await WebSocket.connect(
    Uri.parse(ticket.url),
  );
  ws.events.listen(
    (event) {
      if (event case CloseReceived(:final code, :final reason)) {
        talker.warning(
          'EQMonitor WebSocket: closed with code $code and reason $reason',
        );
        ref.invalidateSelf();
      }
    },
  );
  ref.onDispose(ws.close);
  return ws;
}


@riverpod
Stream<WebSocketEvent> eqmonitorWsEventStream(Ref ref) async* {
  final websocket = await ref.watch(eqmonitorWebSocketProvider.future);
  yield* websocket.events;
}

@riverpod
Future<RealtimeTicketResponse> eqmonitorWebSocketTicket(Ref ref) async {
  final api = await ref.read(apiClientProvider.future);
  final response = await api.realtime.getV2RealtimeTicket();
  final ticket = response.data;
  final now = DateTime.now();
  final expiresAt = ticket.expiresAt;

  const calculator = EqmonitorWebSocketTicketRefreshDelayCalculator();
  final refreshDelay = calculator.calculate(now: now, expiresAt: expiresAt);
  final invalidateTimer = Timer(
    refreshDelay,
    () => ref.invalidateSelf(asReload: true),
  );
  ref.onDispose(invalidateTimer.cancel);

  return ticket;
}
