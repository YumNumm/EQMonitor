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
  // MEMO(YumNumm): WebSocket接続時にticketがあればよく、追従する必要はないので、read
  final ticket = await ref.read(eqmonitorWebSocketTicketProvider.future);

  final ws = await WebSocket.connect(
    Uri.parse(ticket.url),
  );
  ref.onDispose(() => ws.close().ignore());
  return ws;
}

/// WebSocket イベントストリーム。
/// ws.events は単一サブスクリプションのため、ここが唯一の subscriber。
/// CloseReceived 検知時に eqmonitorWebSocket を invalidate して再接続をトリガーする。
@riverpod
Stream<WebSocketEvent> eqmonitorWsEventStream(Ref ref) async* {
  final websocket = await ref.watch(eqmonitorWebSocketProvider.future);
  await for (final event in websocket.events) {
    yield event;
    if (event case CloseReceived(:final code, :final reason)) {
      talker.warning(
        'EQMonitor WebSocket: closed with code $code and reason $reason',
      );
      ref.invalidate(eqmonitorWebSocketProvider, asReload: true);
      return;
    }
  }
  ref.invalidate(eqmonitorWebSocketProvider, asReload: true);
}

@riverpod
Future<RealtimeTicketResponse> eqmonitorWebSocketTicket(Ref ref) async {
  try {
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
  } on Exception catch (e) {
    talker.error('Failed to get WebSocket ticket', e);
    rethrow;
  }
}
