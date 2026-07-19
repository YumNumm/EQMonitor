import 'package:clock/clock.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_event.dart';
import 'package:eqmonitor/feature/shake_detection/data/provider/shake_detection_merge_provider.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final _now = DateTime.utc(2025, 1, 1, 12);

ShakeDetectionEvent _ev({
  required String eventId,
  String? mergedEewEventId,
}) => ShakeDetectionEvent(
  eventId: eventId,
  createdAt: _now,
  level: ShakeDetectionLevel.medium,
  isReplay: false,
  pointCount: 5,
  minLat: 34,
  maxLat: 36,
  minLng: 138,
  maxLng: 140,
  changeReasons: const ['new_event'],
  mergedEewEventId: mergedEewEventId,
);

ProviderContainer _container(List<ShakeDetectionEvent> merged) {
  final container = ProviderContainer(
    overrides: [
      shakeDetectionMergedProvider.overrideWithValue(merged),
    ],
  );
  addTearDown(container.dispose);
  return container;
}

void main() {
  group('shakeDetectionVisible', () {
    test('mergedEewEventId が null のもののみ通すこと', () {
      withClock(Clock.fixed(_now), () {
        final container = _container([
          _ev(eventId: 'a'),
          _ev(eventId: 'b', mergedEewEventId: 'EEW-1'),
          _ev(eventId: 'c'),
        ]);
        final result = container.read(shakeDetectionVisibleProvider);
        expect(result.map((e) => e.eventId).toList(), ['a', 'c']);
      });
    });

    test('全件 merged の場合は空リスト', () {
      final container = _container([
        _ev(eventId: 'a', mergedEewEventId: 'EEW-1'),
        _ev(eventId: 'b', mergedEewEventId: 'EEW-2'),
      ]);
      final result = container.read(shakeDetectionVisibleProvider);
      expect(result, isEmpty);
    });

    test('入力が空でも例外にならず空リストを返すこと', () {
      final container = _container([]);
      final result = container.read(shakeDetectionVisibleProvider);
      expect(result, isEmpty);
    });

    test('順序は merged provider 由来の順序を維持すること', () {
      withClock(Clock.fixed(_now), () {
        final container = _container([
          _ev(eventId: 'z'),
          _ev(eventId: 'a'),
          _ev(eventId: 'm', mergedEewEventId: 'EEW-1'),
          _ev(eventId: 'b'),
        ]);
        final result = container.read(shakeDetectionVisibleProvider);
        expect(result.map((e) => e.eventId).toList(), ['z', 'a', 'b']);
      });
    });
  });
}
