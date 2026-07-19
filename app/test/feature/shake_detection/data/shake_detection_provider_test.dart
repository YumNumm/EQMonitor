import 'dart:async';

import 'package:clock/clock.dart';
import 'package:eqmonitor/core/provider/clock/app_clock.dart';
import 'package:eqmonitor/core/realtime/model/realtime_event.dart';
import 'package:eqmonitor/core/realtime/model/realtime_shake_data.dart';
import 'package:eqmonitor/core/realtime/realtime_event_provider.dart';
import 'package:eqmonitor/feature/shake_detection/data/provider/shake_detection_provider.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' show ShakeDetectionLevel;
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class _StubRealtimeEvents extends RealtimeEvents {
  _StubRealtimeEvents(this._stream);

  final Stream<RealtimeEvent> _stream;

  @override
  Stream<RealtimeEvent> build() => _stream;
}

RealtimeShakeData _shake({
  required String eventId,
  required DateTime createdAt,
  List<String> changeReasons = const ['new_event'],
}) => RealtimeShakeData(
  eventId: eventId,
  createdAt: createdAt,
  level: ShakeDetectionLevel.medium.toJson(),
  isReplay: false,
  pointCount: 3,
  minLat: 35,
  maxLat: 36,
  minLng: 139,
  maxLng: 140,
  changeReasons: changeReasons,
);

ProviderContainer _container(Stream<RealtimeEvent> stream) {
  final container = ProviderContainer(
    overrides: [
      realtimeEventsProvider.overrideWith(() => _StubRealtimeEvents(stream)),
    ],
  );
  addTearDown(container.dispose);
  return container;
}

void main() {
  group('ShakeDetection', () {
    test('スナップショットに含まれないTTL内の既存揺れ検知を保持すること', () async {
      final now = DateTime.utc(2025, 1, 1, 12, 2);
      await withClock(Clock.fixed(now), () async {
        final controller = StreamController<RealtimeEvent>.broadcast(
          sync: true,
        );
        addTearDown(controller.close);
        final container = _container(controller.stream);
        final subscription = container.listen(
          shakeDetectionProvider,
          (_, _) {},
        );
        addTearDown(subscription.close);

        expect(subscription.read(), isEmpty);
        await pumpEventQueue();
        controller.add(
          RealtimeEvent.shakeDetected(
            data: _shake(
              eventId: 'shake-current',
              createdAt: now.subtract(const Duration(minutes: 2)),
              changeReasons: const ['level_up', 'region_changed'],
            ),
            source: RealtimeSource.eqmonitor,
          ),
        );
        await pumpEventQueue();

        await pumpEventQueue();

        final result = subscription.read();
        expect(result.map((event) => event.eventId).toList(), [
          'shake-current',
        ]);
        expect(result.single.changeReasons, ['level_up', 'region_changed']);
      });
    });

    test('タイムシフト中はライブ揺れ検知を表示stateへ取り込まないこと', () async {
      final controller = StreamController<RealtimeEvent>.broadcast(sync: true);
      addTearDown(controller.close);
      final container = _container(controller.stream);
      final subscription = container.listen(
        shakeDetectionProvider,
        (_, _) {},
      );
      addTearDown(subscription.close);

      container
          .read(appClockProvider.notifier)
          .enterTimeShift(const Duration(minutes: -3));
      expect(subscription.read(), isEmpty);
      await pumpEventQueue();

      controller.add(
        RealtimeEvent.shakeDetected(
          data: _shake(
            eventId: 'live-shake',
            createdAt: DateTime.utc(2025, 1, 1, 12),
          ),
          source: RealtimeSource.eqmonitor,
        ),
      );
      await pumpEventQueue();

      expect(subscription.read(), isEmpty);
    });

    test('通常再生からタイムシフトへ切り替えたら既存のライブ揺れ検知を消すこと', () async {
      final controller = StreamController<RealtimeEvent>.broadcast(sync: true);
      addTearDown(controller.close);
      final container = _container(controller.stream);
      final subscription = container.listen(
        shakeDetectionProvider,
        (_, _) {},
      );
      addTearDown(subscription.close);

      expect(subscription.read(), isEmpty);
      await pumpEventQueue();
      controller.add(
        RealtimeEvent.shakeDetected(
          data: _shake(
            eventId: 'live-shake',
            createdAt: DateTime.utc(2025, 1, 1, 12),
          ),
          source: RealtimeSource.eqmonitor,
        ),
      );
      await pumpEventQueue();
      expect(subscription.read(), hasLength(1));

      container
          .read(appClockProvider.notifier)
          .enterTimeShift(const Duration(minutes: -3));

      expect(subscription.read(), isEmpty);
    });
  });
}
