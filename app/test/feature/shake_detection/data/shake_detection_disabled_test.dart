import 'package:eqmonitor/core/provider/environment/environment.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_event.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_snapshot.dart';
import 'package:eqmonitor/feature/shake_detection/data/notifier/shake_detection_debug_overlay.dart';
import 'package:eqmonitor/feature/shake_detection/data/provider/shake_detection_merge_provider.dart';
import 'package:eqmonitor/feature/shake_detection/data/provider/shake_detection_provider.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../fixtures/build_config.dart';

final _now = DateTime.utc(2026, 8, 14, 12);

ShakeDetectionEvent _event(String eventId) => ShakeDetectionEvent(
  eventId: eventId,
  serialNo: 1,
  createdAt: _now,
  updatedAt: _now,
  expiresAt: _now.add(const Duration(minutes: 1)),
  level: api.ShakeDetectionLevel.medium,
  pointCount: 1,
  minLat: 35,
  maxLat: 36,
  minLng: 139,
  maxLng: 140,
  changeReasons: const ['new_event'],
);

final _disabledBuildConfig = buildConfigProvider.overrideWithValue(
  const BuildConfigFixture().build(isShakeDetectionEnabled: false),
);

void main() {
  group('揺れ検知が無効なビルド', () {
    test('accepted snapshot を購読せず null のままであること', () {
      final container = ProviderContainer(overrides: [_disabledBuildConfig]);
      addTearDown(container.dispose);

      expect(container.read(shakeDetectionAcceptedSnapshotProvider), isNull);
      expect(container.read(shakeDetectionProvider), isEmpty);
    });

    test('snapshot が届いても state が更新されないこと', () {
      final container = ProviderContainer(overrides: [_disabledBuildConfig]);
      addTearDown(container.dispose);

      container
          .read(shakeDetectionAcceptedSnapshotProvider.notifier)
          .applySnapshot(
            ShakeDetectionSnapshot(
              revision: 1,
              responseAt: _now,
              events: [_event('e1')],
            ),
          );

      expect(container.read(shakeDetectionAcceptedSnapshotProvider), isNull);
    });

    test('デバッグ挿入イベントも表示されないこと', () {
      final container = ProviderContainer(
        overrides: [
          _disabledBuildConfig,
          shakeDetectionDebugOverlayProvider.overrideWithValue([_event('e1')]),
        ],
      );
      addTearDown(container.dispose);

      expect(container.read(shakeDetectionVisibleProvider), isEmpty);
    });
  });
}
