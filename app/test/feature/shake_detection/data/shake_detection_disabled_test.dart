import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_event.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_level.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_settings_model.dart';
import 'package:eqmonitor/feature/shake_detection/data/notifier/device_shake_detection.dart';
import 'package:eqmonitor/feature/shake_detection/data/notifier/shake_detection_debug_overlay.dart';
import 'package:eqmonitor/feature/shake_detection/data/provider/shake_detection_merge_provider.dart';
import 'package:eqmonitor/feature/shake_detection/data/provider/shake_detection_provider.dart';
import 'package:eqmonitor/feature/shake_detection/data/provider/shake_detection_tuning_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final _now = DateTime.utc(2026, 8, 14, 12);

ShakeDetectionEvent _event(String eventId) => ShakeDetectionEvent(
  eventId: eventId,
  createdAt: _now,
  updatedAt: _now,
  expiresAt: _now.add(const Duration(minutes: 1)),
  level: ShakeDetectionLevel.medium,
  pointCount: 1,
  minLat: 35,
  maxLat: 36,
  minLng: 139,
  maxLng: 140,
);

void main() {
  test('端末内の揺れ検知は既定で無効であること', () {
    expect(const ShakeDetectionSettingsModel().isEnabled, isFalse);
  });

  group('端末内の揺れ検知が無効な場合', () {
    final disabled = shakeDetectionCurrentSettingsProvider.overrideWithValue(
      const ShakeDetectionSettingsModel(),
    );

    test('端末内の検知結果があってもイベントを公開しないこと', () {
      final container = ProviderContainer(overrides: [disabled]);
      addTearDown(container.dispose);

      container
          .read(deviceShakeDetectionProvider.notifier)
          .apply(observedAt: _now, events: const []);

      expect(container.read(shakeDetectionProvider), isEmpty);
    });

    test('デバッグ挿入イベントも表示されないこと', () {
      final container = ProviderContainer(
        overrides: [
          disabled,
          shakeDetectionDebugOverlayProvider.overrideWithValue([_event('e1')]),
        ],
      );
      addTearDown(container.dispose);

      expect(container.read(shakeDetectionVisibleProvider), isEmpty);
    });
  });
}
