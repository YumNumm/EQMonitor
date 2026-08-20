import 'dart:async';

import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/core/realtime/data_source/eqmonitor/eqmonitor_ws_payload_stream.dart';
import 'package:eqmonitor/core/realtime/data_source/eqmonitor/eqmonitor_ws_provider.dart';
import 'package:eqmonitor_websocket/eqmonitor_websocket.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:web_socket/web_socket.dart';

part 'eqmonitor_ws_ping_probe.g.dart';

/// クライアント起因 ping の計測結果。
typedef WsRttSample = ({Duration rtt, DateTime measuredAt});

@riverpod
class EqmonitorWsPingProbe extends _$EqmonitorWsPingProbe {
  /// ping 送出間隔。サーバー起因 ping (15 秒) とずらしている。
  static const pingInterval = Duration(seconds: 20);

  final _tracker = WsRttTracker();
  Timer? _timer;

  @override
  WsRttSample? build() {
    ref.listen(eqmonitorWsPayloadStreamProvider, (_, next) {
      next.whenData((message) {
        if (message case final WsPongMessage pong) {
          _handlePong(pong);
        }
      });
    });

    _stop();
    _tracker.reset();
    ref.onDispose(_stop);

    final socket = ref.watch(eqmonitorWebSocketProvider);
    // reload 中 (AsyncLoading with previous value) は旧ソケットなので送らない。
    if (socket case AsyncData(:final value) when !socket.isLoading) {
      // 接続直後に 1 回計測し、以降は定期的に繰り返す。
      if (_sendPing(value)) {
        _timer = Timer.periodic(pingInterval, (_) => _sendPing(value));
      }
    }

    return null;
  }

  void _stop() {
    _timer?.cancel();
    _timer = null;
  }

  /// 送信できたら true。失敗したら以降の送出を止めて false。
  bool _sendPing(WebSocket socket) {
    try {
      socket.sendText(_tracker.issue(DateTime.now()));
      return true;
    } on Object catch (e) {
      // 切断直後は sendText が失敗する。再接続時に build がやり直されるので、
      // ここでは撃ち続けずに止めるだけでよい。
      _stop();
      talker.warning('EQMonitor WebSocket: failed to send client ping', e);
      return false;
    }
  }

  void _handlePong(WsPongMessage pong) {
    final now = DateTime.now();
    final rtt = _tracker.complete(pong.pingId, now);
    if (rtt == null) {
      return;
    }
    state = (rtt: rtt, measuredAt: now);
  }
}
