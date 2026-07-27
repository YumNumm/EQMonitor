import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/feature/eew/data/eew_alive_telegram.dart';
import 'package:eqmonitor/feature/home/ui/component/eew/eew_card.dart';
import 'package:eqmonitor/feature/home/ui/component/shake_detection/shake_detection_card.dart';
import 'package:eqmonitor/feature/live_monitor/data/logic/live_monitor_earthquake_card_presenter.dart';
import 'package:eqmonitor/feature/shake_detection/data/provider/shake_detection_merge_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LiveMonitorRealtimeCards extends ConsumerWidget {
  const LiveMonitorRealtimeCards({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eews = orderedLiveMonitorEews(
      ref.watch(eewAliveTelegramProvider) ?? const [],
    );
    final shakes = orderedLiveMonitorShakes(
      ref.watch(shakeDetectionVisibleProvider),
    );
    if (eews.isEmpty && shakes.isEmpty) {
      return const SizedBox.shrink();
    }

    final spacing = context.designSystem.spacing;
    final itemCount = eews.length + shakes.length;

    return LayoutBuilder(
      builder: (context, constraints) {
        final maximumHeight = constraints.hasBoundedHeight
            ? constraints.maxHeight * 0.5
            : double.infinity;
        return Align(
          alignment: Alignment.bottomCenter,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: maximumHeight),
            child: ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.all(spacing.sm),
              itemCount: itemCount,
              separatorBuilder: (context, index) =>
                  SizedBox(height: spacing.md),
              itemBuilder: (context, index) {
                if (index < eews.length) {
                  return EewCard(
                    eew: eews[index],
                    index: eews.length > 1 ? '${index + 1}' : null,
                  );
                }
                return ShakeDetectionCard(
                  event: shakes[index - eews.length],
                  outerPadding: EdgeInsets.zero,
                );
              },
            ),
          ),
        );
      },
    );
  }
}
