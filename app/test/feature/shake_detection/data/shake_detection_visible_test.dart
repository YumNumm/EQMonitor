import 'package:clock/clock.dart';
import 'package:eqmonitor/core/provider/environment/environment.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_event.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_level.dart';
import 'package:eqmonitor/feature/shake_detection/data/provider/shake_detection_merge_provider.dart';
import 'package:eqmonitor/feature/shake_detection/data/provider/shake_detection_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../fixtures/build_config.dart';

final _now = DateTime.utc(2026, 7, 19, 12);

ShakeDetectionEvent event(
  String eventId, {
  DateTime? createdAt,
  required DateTime expiresAt,
  String? correlatedEewEventId,
}) => ShakeDetectionEvent(
  eventId: eventId,
  serialNo: 1,
  createdAt: createdAt ?? _now,
  updatedAt: _now,
  expiresAt: expiresAt,
  level: ShakeDetectionLevel.medium,
  pointCount: 1,
  minLat: 35,
  maxLat: 36,
  minLng: 139,
  maxLng: 140,
  changeReasons: const ['new_event'],
  correlatedEewEventId: correlatedEewEventId,
);

ProviderContainer containerWith(List<ShakeDetectionEvent> events) {
  final container = ProviderContainer(
    overrides: [
      buildConfigProvider.overrideWithValue(const BuildConfigFixture().build()),
      shakeDetectionProvider.overrideWithValue(events),
    ],
  );
  addTearDown(container.dispose);
  return container;
}

void main() {
  group('shakeDetectionVisible', () {
    test('server correlatedEewがあるeventを表示しないこと', () {
      withClock(Clock.fixed(_now), () {
        final container = containerWith([
          event('visible', expiresAt: _now.add(const Duration(seconds: 1))),
          event(
            'correlated',
            expiresAt: _now.add(const Duration(seconds: 1)),
            correlatedEewEventId: 'eew-1',
          ),
        ]);
        expect(
          container
              .read(shakeDetectionVisibleProvider)
              .map((event) => event.eventId),
          ['visible'],
        );
      });
    });

    test('expiresAt以前だけを表示すること', () {
      withClock(Clock.fixed(_now), () {
        final container = containerWith([
          event('expired', expiresAt: _now),
          event('active', expiresAt: _now.add(const Duration(milliseconds: 1))),
        ]);
        expect(
          container
              .read(shakeDetectionVisibleProvider)
              .map((event) => event.eventId),
          ['active'],
        );
      });
    });

    test('createdAtから3分経過していてもexpiresAtが未来なら表示すること', () {
      withClock(Clock.fixed(_now), () {
        final container = containerWith([
          event(
            'server-active',
            createdAt: _now.subtract(const Duration(minutes: 4)),
            expiresAt: _now.add(const Duration(seconds: 1)),
          ),
        ]);
        expect(container.read(shakeDetectionVisibleProvider), hasLength(1));
      });
    });
  });
}
