import 'package:eqmonitor/core/provider/clock/app_clock.dart';
import 'package:eqmonitor/core/provider/environment/environment.dart';
import 'package:eqmonitor/core/provider/time_ticker.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_event.dart';
import 'package:eqmonitor/feature/shake_detection/data/notifier/shake_detection_debug_overlay.dart';
import 'package:eqmonitor/feature/shake_detection/data/provider/shake_detection_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'shake_detection_merge_provider.g.dart';

@Riverpod(keepAlive: true)
List<ShakeDetectionEvent> shakeDetectionVisible(Ref ref) {
  if (!ref.watch(buildConfigProvider).isShakeDetectionEnabled) {
    return const [];
  }

  final tickerTime = ref.watch(timeTickerProvider());
  final now = (tickerTime.value ?? ref.read(appClockProvider.notifier).now())
      .toUtc();

  final live = ref
      .watch(shakeDetectionProvider)
      .where(
        (event) =>
            event.correlatedEewEventId == null &&
            event.expiresAt.toUtc().isAfter(now),
      );

  final debug = ref.watch(shakeDetectionDebugOverlayProvider);

  return [...live, ...debug];
}
