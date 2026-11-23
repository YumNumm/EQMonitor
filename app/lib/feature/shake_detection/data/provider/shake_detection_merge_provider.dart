import 'package:eqmonitor/core/provider/clock/app_clock.dart';
import 'package:eqmonitor/core/provider/time_ticker.dart';
import 'package:eqmonitor/feature/debug/data/provider/debug_menu_availability_provider.dart';
import 'package:eqmonitor/feature/home/data/model/home_configuration_model.dart';
import 'package:eqmonitor/feature/home/data/notifier/home_configuration_notifier.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_event.dart';
import 'package:eqmonitor/feature/shake_detection/data/notifier/shake_detection_debug_overlay.dart';
import 'package:eqmonitor/feature/shake_detection/data/provider/shake_detection_provider.dart';
import 'package:eqmonitor/feature/shake_detection/data/provider/shake_detection_tuning_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'shake_detection_merge_provider.g.dart';

/// 有効期限内で、設定した表示レベル以上の揺れ検知イベント。
///
/// EEW と結合したイベントも含む。
@Riverpod(keepAlive: true)
List<ShakeDetectionEvent> shakeDetectionActive(Ref ref) {
  if (!ref.watch(isDeviceShakeDetectionEnabledProvider)) {
    return const [];
  }

  final tickerTime = ref.watch(timeTickerProvider());
  final now = (tickerTime.value ?? ref.read(appClockProvider.notifier).now())
      .toUtc();
  final minLevel = ref.watch(
    homeConfigurationProvider.select(
      (configuration) =>
          (configuration.value?.shakeDetection ??
                  const HomeShakeDetectionSettings())
              .minLevel,
    ),
  );

  final live = ref
      .watch(shakeDetectionProvider)
      .where(
        (event) =>
            event.expiresAt.toUtc().isAfter(now) &&
            event.level.index >= minLevel.index,
      );

  final debug = ref.watch(shakeDetectionDebugOverlayProvider);

  return [...live, ...debug];
}

/// 地図・カードに表示する揺れ検知イベント。
///
/// EEW と結合したイベントは EEW の表示に任せるため含めない。
/// デバッグ設定で有効にした場合のみ、結合したイベントも含める。
@Riverpod(keepAlive: true)
List<ShakeDetectionEvent> shakeDetectionVisible(Ref ref) {
  final events = ref.watch(shakeDetectionActiveProvider);
  final showsCorrelated =
      ref.watch(
        homeConfigurationProvider.select(
          (configuration) =>
              configuration.value?.debugOverlay.shakeDetectionDuringEew ??
              false,
        ),
      ) &&
      ref.watch(isDebugMenuAvailableProvider);
  if (showsCorrelated) {
    return events;
  }
  return [
    for (final event in events)
      if (event.correlatedEewEventId == null) event,
  ];
}

/// 地図の自動フォーカスの対象にする揺れ検知イベント。
///
/// EEW と結合したイベントも含め、震源と揺れている範囲の両方が収まるようにする。
@Riverpod(keepAlive: true)
List<ShakeDetectionEvent> shakeDetectionFocusTargets(Ref ref) {
  final isAutoFocusEnabled = ref.watch(
    homeConfigurationProvider.select(
      (configuration) =>
          (configuration.value?.shakeDetection ??
                  const HomeShakeDetectionSettings())
              .autoFocus,
    ),
  );
  if (!isAutoFocusEnabled) {
    return const [];
  }
  return ref.watch(shakeDetectionActiveProvider);
}
