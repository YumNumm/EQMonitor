import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_event.dart';
import 'package:eqmonitor/feature/shake_detection/data/provider/shake_detection_history_provider.dart';
import 'package:eqmonitor/feature/shake_detection/data/provider/shake_detection_provider.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final _baseTime = DateTime.utc(2026, 7, 19, 12);

ShakeDetectionEvent _ev(
  String eventId, {
  api.ShakeDetectionLevel level = api.ShakeDetectionLevel.weak,
  int pointCount = 3,
}) => ShakeDetectionEvent(
  eventId: eventId,
  serialNo: 1,
  createdAt: _baseTime,
  updatedAt: _baseTime,
  expiresAt: _baseTime.add(const Duration(minutes: 1)),
  level: level,
  pointCount: pointCount,
  minLat: 34,
  maxLat: 36,
  minLng: 138,
  maxLng: 140,
  changeReasons: const ['new_event'],
);

class _StubShakeDetection extends ShakeDetection {
  _StubShakeDetection([this._initial = const <ShakeDetectionEvent>[]]);
  final List<ShakeDetectionEvent> _initial;

  @override
  List<ShakeDetectionEvent> build() => _initial;

  void publish(List<ShakeDetectionEvent> v) => state = v;
}

ProviderContainer _container([List<ShakeDetectionEvent>? initial]) {
  final container = ProviderContainer(
    overrides: [
      shakeDetectionProvider.overrideWith(
        () => _StubShakeDetection(initial ?? const <ShakeDetectionEvent>[]),
      ),
    ],
  );
  addTearDown(container.dispose);
  return container;
}

void main() {
  group('ShakeDetectionHistory', () {
    test('初期状態は空リストであること', () {
      final container = _container();
      final state = container.read(shakeDetectionHistoryProvider);
      expect(state, isEmpty);
    });

    test('新しい event が来ると先頭 (index=0) に挿入されること', () {
      final container = _container();
      // history を起動して listen を発火させる
      container.read(shakeDetectionHistoryProvider);

      final stub =
          container.read(shakeDetectionProvider.notifier)
              as _StubShakeDetection;
      stub.publish([_ev('e1')]);

      final state = container.read(shakeDetectionHistoryProvider);
      expect(state.map((e) => e.eventId).toList(), ['e1']);
    });

    test('複数イベントが順次到着すると最新が先頭になること', () {
      final container = _container();
      container.read(shakeDetectionHistoryProvider);

      final stub =
          container.read(shakeDetectionProvider.notifier)
              as _StubShakeDetection;
      stub.publish([_ev('e1')]);
      stub.publish([_ev('e1'), _ev('e2')]);
      stub.publish([_ev('e1'), _ev('e2'), _ev('e3')]);

      final state = container.read(shakeDetectionHistoryProvider);
      // e3 が最新 → 先頭
      expect(state.map((e) => e.eventId).toList(), ['e3', 'e2', 'e1']);
    });

    test('同一 eventId は再挿入されず内容が更新されること', () {
      final container = _container();
      container.read(shakeDetectionHistoryProvider);

      final stub =
          container.read(shakeDetectionProvider.notifier)
              as _StubShakeDetection;
      stub.publish([_ev('e1')]);
      // 同じ eventId だが pointCount が変わる
      stub.publish([_ev('e1', pointCount: 10)]);

      final state = container.read(shakeDetectionHistoryProvider);
      expect(state, hasLength(1));
      expect(state.single.pointCount, 10);
    });

    test('cleanup などで shakeDetectionProvider からイベントが消えても履歴は保持されること', () {
      final container = _container();
      container.read(shakeDetectionHistoryProvider);

      final stub =
          container.read(shakeDetectionProvider.notifier)
              as _StubShakeDetection;
      stub.publish([_ev('e1'), _ev('e2')]);
      // 揺れ検知プロバイダから削除されても、履歴側は保持される
      stub.publish([]);

      final state = container.read(shakeDetectionHistoryProvider);
      expect(state.map((e) => e.eventId).toSet(), {'e1', 'e2'});
    });

    test('既存と同一の event を渡しても重複しないこと', () {
      final container = _container();
      container.read(shakeDetectionHistoryProvider);

      final stub =
          container.read(shakeDetectionProvider.notifier)
              as _StubShakeDetection;
      stub.publish([_ev('e1')]);
      // 完全に同一の event を再度
      stub.publish([_ev('e1')]);

      final state = container.read(shakeDetectionHistoryProvider);
      expect(state, hasLength(1));
    });
  });
}
