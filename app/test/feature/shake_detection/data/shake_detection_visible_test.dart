import 'package:clock/clock.dart';
import 'package:eqmonitor/feature/home/data/model/home_configuration_model.dart';
import 'package:eqmonitor/feature/home/data/notifier/home_configuration_notifier.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_event.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_level.dart';
import 'package:eqmonitor/feature/shake_detection/data/provider/shake_detection_merge_provider.dart';
import 'package:eqmonitor/feature/shake_detection/data/provider/shake_detection_provider.dart';
import 'package:eqmonitor/feature/shake_detection/data/provider/shake_detection_tuning_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final _now = DateTime.utc(2026, 7, 19, 12);

ShakeDetectionEvent event(
  String eventId, {
  DateTime? createdAt,
  required DateTime expiresAt,
  String? correlatedEewEventId,
  ShakeDetectionLevel level = ShakeDetectionLevel.medium,
}) => ShakeDetectionEvent(
  eventId: eventId,
  createdAt: createdAt ?? _now,
  updatedAt: _now,
  expiresAt: expiresAt,
  level: level,
  pointCount: 1,
  minLat: 35,
  maxLat: 36,
  minLng: 139,
  maxLng: 140,
  correlatedEewEventId: correlatedEewEventId,
);

class _StubHomeConfiguration extends HomeConfigurationNotifier {
  new(this.settings);

  final HomeShakeDetectionSettings settings;

  @override
  Future<HomeConfigurationModel> build() async =>
      HomeConfigurationModel(shakeDetection: settings);
}

Future<ProviderContainer> containerWith(
  List<ShakeDetectionEvent> events, {
  HomeShakeDetectionSettings settings = const HomeShakeDetectionSettings(),
}) async {
  final container = ProviderContainer(
    overrides: [
      isDeviceShakeDetectionEnabledProvider.overrideWithValue(true),
      homeConfigurationProvider.overrideWith(
        () => _StubHomeConfiguration(settings),
      ),
      shakeDetectionProvider.overrideWithValue(events),
    ],
  );
  addTearDown(container.dispose);
  await container.read(homeConfigurationProvider.future);
  return container;
}

void main() {
  group('shakeDetectionVisible', () {
    test('server correlatedEewがあるeventを表示しないこと', () async {
      await withClock(Clock.fixed(_now), () async {
        final container = await containerWith([
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

    test('expiresAt以前だけを表示すること', () async {
      await withClock(Clock.fixed(_now), () async {
        final container = await containerWith([
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

    test('createdAtから3分経過していてもexpiresAtが未来なら表示すること', () async {
      await withClock(Clock.fixed(_now), () async {
        final container = await containerWith([
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

  group('表示する揺れの強さ', () {
    test('設定した強さに満たないイベントを表示しないこと', () async {
      await withClock(Clock.fixed(_now), () async {
        final expiresAt = _now.add(const Duration(seconds: 1));
        final container = await containerWith(
          [
            event(
              'weak',
              expiresAt: expiresAt,
              level: ShakeDetectionLevel.weak,
            ),
            event('medium', expiresAt: expiresAt),
            event(
              'strong',
              expiresAt: expiresAt,
              level: ShakeDetectionLevel.strong,
            ),
          ],
          settings: const HomeShakeDetectionSettings(
            minLevel: ShakeDetectionLevel.medium,
          ),
        );
        expect(
          container
              .read(shakeDetectionVisibleProvider)
              .map((event) => event.eventId),
          ['medium', 'strong'],
        );
      });
    });
  });

  group('shakeDetectionFocusTargets', () {
    test('自動ズームが有効な場合は表示中のイベントを対象にすること', () async {
      await withClock(Clock.fixed(_now), () async {
        final container = await containerWith([
          event('visible', expiresAt: _now.add(const Duration(seconds: 1))),
        ]);
        expect(
          container.read(shakeDetectionFocusTargetsProvider),
          hasLength(1),
        );
      });
    });

    test('自動ズームが無効な場合は対象を返さないこと', () async {
      await withClock(Clock.fixed(_now), () async {
        final container = await containerWith(
          [event('visible', expiresAt: _now.add(const Duration(seconds: 1)))],
          settings: const HomeShakeDetectionSettings(autoFocus: false),
        );
        expect(container.read(shakeDetectionVisibleProvider), hasLength(1));
        expect(container.read(shakeDetectionFocusTargetsProvider), isEmpty);
      });
    });
  });
}
