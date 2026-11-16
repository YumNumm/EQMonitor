import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/provider/clock/app_clock.dart';
import 'package:eqmonitor/core/provider/time_ticker.dart';
import 'package:eqmonitor/feature/debug/data/provider/debug_menu_availability_provider.dart';
import 'package:eqmonitor/feature/eew/data/eew_alive_telegram.dart';
import 'package:eqmonitor/feature/home/data/logic/home_debug_hud_formatter.dart';
import 'package:eqmonitor/feature/home/data/model/home_configuration_model.dart';
import 'package:eqmonitor/feature/home/data/notifier/home_configuration_notifier.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/notifier/kyoshin_monitor_notifier.dart';
import 'package:eqmonitor/feature/shake_detection/data/provider/shake_detection_debug_report_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

/// 地図に重ねて表示する、機能ごとのデバッグ情報。
///
/// デバッグメニューを利用でき、マップレイヤー設定で有効にした項目だけを表示する。
class HomeDebugHud extends ConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(
      homeConfigurationProvider.select(
        (configuration) =>
            configuration.value?.debugOverlay ??
            const HomeDebugOverlaySettings(),
      ),
    );
    final isVisible =
        ref.watch(isDebugMenuAvailableProvider) &&
        (settings.shakeDetection || settings.kyoshinMonitor || settings.eew);
    if (!isVisible) {
      return const SizedBox.shrink();
    }

    final formatter = ref.watch(homeDebugHudFormatterProvider);
    final now =
        ref.watch(timeTickerProvider()).value ??
        ref.read(appClockProvider.notifier).now();
    final sections = [
      if (settings.shakeDetection)
        formatter.shakeDetection(
          report: ref.watch(shakeDetectionDebugReportProvider),
          now: now,
        ),
      if (settings.kyoshinMonitor)
        formatter.kyoshinMonitor(
          state: ref.watch(kyoshinMonitorProvider).value,
          now: now,
        ),
      if (settings.eew)
        formatter.eew(
          eews: ref.watch(eewAliveTelegramProvider) ?? const [],
          now: now,
        ),
    ];

    final designSystem = context.designSystem;
    final spacing = designSystem.spacing;
    final style = designSystem.typography.monoSmall.copyWith(
      color: Colors.white,
      fontSize: 10,
      height: 1.3,
      letterSpacing: 0,
    );

    return IgnorePointer(
      child: Padding(
        padding: EdgeInsets.only(top: spacing.xs),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 320),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.72),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: EdgeInsets.all(spacing.sm),
              child: Column(
                mainAxisSize: .min,
                crossAxisAlignment: .start,
                spacing: spacing.sm,
                children: [
                  for (final lines in sections)
                    Text(lines.join('\n'), style: style),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
