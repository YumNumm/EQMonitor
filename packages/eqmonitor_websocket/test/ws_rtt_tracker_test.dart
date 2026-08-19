import 'dart:convert';

import 'package:eqmonitor_websocket/eqmonitor_websocket.dart';
import 'package:test/test.dart';

final _base = DateTime.utc(2026, 1, 1);

String _pingIdOf(String encoded) =>
    (jsonDecode(encoded) as Map<String, dynamic>)['pingId'] as String;

void main() {
  group('WsRttTracker.issue', () {
    test('サーバーが解釈できる ping フレームを組み立てること', () {
      final tracker = WsRttTracker();

      final encoded = tracker.issue(_base);

      expect(jsonDecode(encoded), {'pingId': '1', 'type': 'ping'});
    });

    test('pingId は接続内で重複しないこと', () {
      final tracker = WsRttTracker();

      final ids = [
        _pingIdOf(tracker.issue(_base)),
        _pingIdOf(tracker.issue(_base)),
        _pingIdOf(tracker.issue(_base)),
      ];

      expect(ids.toSet(), hasLength(3));
    });
  });

  group('WsRttTracker.complete', () {
    test('送信から pong 受信までの往復時間を返すこと', () {
      final tracker = WsRttTracker();
      final pingId = _pingIdOf(tracker.issue(_base));

      final rtt = tracker.complete(
        pingId,
        _base.add(const Duration(milliseconds: 42)),
      );

      expect(rtt, const Duration(milliseconds: 42));
    });

    test('同じ pingId を二度計上しないこと', () {
      final tracker = WsRttTracker();
      final pingId = _pingIdOf(tracker.issue(_base));
      tracker.complete(pingId, _base.add(const Duration(milliseconds: 10)));

      expect(
        tracker.complete(pingId, _base.add(const Duration(milliseconds: 20))),
        isNull,
      );
    });

    test('送っていない pingId は無視すること', () {
      final tracker = WsRttTracker();
      tracker.issue(_base);

      expect(tracker.complete('unknown', _base), isNull);
      expect(tracker.complete(null, _base), isNull);
    });

    test('timeout を超えた応答は計上しないこと', () {
      final tracker = WsRttTracker(timeout: const Duration(seconds: 5));
      final pingId = _pingIdOf(tracker.issue(_base));

      expect(
        tracker.complete(pingId, _base.add(const Duration(seconds: 6))),
        isNull,
      );
    });

    test('端末時刻が巻き戻っても負の RTT を返さないこと', () {
      final tracker = WsRttTracker();
      final pingId = _pingIdOf(tracker.issue(_base));

      expect(
        tracker.complete(pingId, _base.subtract(const Duration(seconds: 1))),
        isNull,
      );
    });

    test('reset 後は再接続前の ping の pong を計上しないこと', () {
      final tracker = WsRttTracker();
      final pingId = _pingIdOf(tracker.issue(_base));

      tracker.reset();

      expect(
        tracker.complete(pingId, _base.add(const Duration(milliseconds: 10))),
        isNull,
      );
    });

    test('reset を挟んでも pingId は再利用されないこと', () {
      final tracker = WsRttTracker();
      final before = _pingIdOf(tracker.issue(_base));
      tracker.reset();

      expect(_pingIdOf(tracker.issue(_base)), isNot(before));
    });
  });

  group('WsRttTracker pending の掃除', () {
    test('maxPending を超えた未応答 ping を古い順に捨てること', () {
      final tracker = WsRttTracker(maxPending: 2);
      final first = _pingIdOf(tracker.issue(_base));
      final second = _pingIdOf(tracker.issue(_base));
      final third = _pingIdOf(tracker.issue(_base));

      expect(tracker.pendingCount, 2);
      expect(tracker.complete(first, _base), isNull);
      expect(tracker.complete(second, _base), isNotNull);
      expect(tracker.complete(third, _base), isNotNull);
    });

    test('timeout を過ぎた未応答 ping を溜め込まないこと', () {
      final tracker = WsRttTracker(timeout: const Duration(seconds: 5));
      tracker.issue(_base);

      tracker.issue(_base.add(const Duration(seconds: 6)));

      expect(tracker.pendingCount, 1);
    });
  });
}
