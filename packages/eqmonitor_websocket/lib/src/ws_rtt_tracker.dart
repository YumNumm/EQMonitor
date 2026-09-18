import 'dart:convert';

import 'package:eqmonitor_websocket/src/ws_client_ping_message.dart';

/// クライアント起因 ping/pong の RTT を計測する純ロジック。
///
/// [issue] で払い出した `pingId` を送信し、pong で返ってきた `pingId` を
/// [complete] に渡すと往復時間が得られる。応答が返らなかった ping は
/// [timeout] 経過後に破棄される。
///
/// `pingId` は接続ごとに 1 から始まる連番。[reset] で pending を捨てるが
/// 連番は継続するため、再接続前に送った ping の pong が遅れて届いても
/// 別の ping の RTT として誤計上されない。
class WsRttTracker {
  new({
    this.timeout = const Duration(seconds: 30),
    this.maxPending = 8,
  });

  /// これを超えて応答がない ping は破棄する。
  final Duration timeout;

  /// 同時に保持する未応答 ping の上限。超えた分は古い順に捨てる。
  final int maxPending;

  /// pingId -> 送信時刻。挿入順が保持されるので先頭が最古。
  final _pending = <String, DateTime>{};
  var _sequence = 0;

  int get pendingCount => _pending.length;

  /// 新しい ping を払い出し、送信すべき JSON 文字列を返す。
  String issue(DateTime now) {
    evictExpired(now);
    _sequence++;
    final pingId = _sequence.toString();
    _pending[pingId] = now;
    while (_pending.length > maxPending) {
      _pending.remove(_pending.keys.first);
    }
    return jsonEncode(WsClientPingMessage(pingId: pingId).toJson());
  }

  /// pong 受信時に RTT を返す。
  ///
  /// 未知・破棄済みの `pingId`、時刻の巻き戻り、[timeout] 超過の場合は null。
  Duration? complete(String? pingId, DateTime now) {
    if (pingId == null) {
      return null;
    }
    final sentAt = _pending.remove(pingId);
    if (sentAt == null) {
      return null;
    }
    final rtt = now.difference(sentAt);
    if (rtt.isNegative || rtt > timeout) {
      return null;
    }
    return rtt;
  }

  void evictExpired(DateTime now) {
    _pending.removeWhere((_, sentAt) => now.difference(sentAt) > timeout);
  }

  /// 切断時に未応答 ping を破棄する。
  void reset() => _pending.clear();
}
