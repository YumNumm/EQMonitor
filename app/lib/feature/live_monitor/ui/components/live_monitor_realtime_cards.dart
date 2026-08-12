import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/feature/eew/data/eew_alive_telegram.dart';
import 'package:eqmonitor/feature/home/ui/component/eew/eew_card.dart';
import 'package:eqmonitor/feature/home/ui/component/shake_detection/shake_detection_card.dart';
import 'package:eqmonitor/feature/live_monitor/data/logic/live_monitor_earthquake_card_presenter.dart';
import 'package:eqmonitor/feature/live_monitor/ui/components/live_monitor_measured_card_overlay.dart';
import 'package:eqmonitor/feature/shake_detection/data/provider/shake_detection_merge_provider.dart';
import 'package:material_ui/material_ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LiveMonitorRealtimeCards extends ConsumerWidget {
  const LiveMonitorRealtimeCards({
    this.maximumHeight,
    this.onHeightChanged,
    super.key,
  });

  final double? maximumHeight;
  final ValueChanged<double>? onHeightChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eews = orderedLiveMonitorEews(
      ref.watch(eewAliveTelegramProvider) ?? const [],
    );
    final shakes = orderedLiveMonitorShakes(
      ref.watch(shakeDetectionVisibleProvider),
    );
    if (eews.isEmpty && shakes.isEmpty) {
      final empty = const SizedBox.shrink();
      return Align(
        alignment: Alignment.bottomCenter,
        child: switch (onHeightChanged) {
          final ValueChanged<double> callback => LiveMonitorMeasuredCardOverlay(
            onHeightChanged: callback,
            child: empty,
          ),
          null => empty,
        },
      );
    }

    final spacing = context.designSystem.spacing;
    final itemCount = eews.length + shakes.length;

    return LayoutBuilder(
      builder: (context, constraints) {
        final effectiveMaximumHeight =
            maximumHeight ??
            (constraints.hasBoundedHeight
                ? constraints.maxHeight * 0.5
                : double.infinity);
        final cardList = ConstrainedBox(
          constraints: BoxConstraints(maxHeight: effectiveMaximumHeight),
          child: ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.all(spacing.sm),
            itemCount: itemCount,
            separatorBuilder: (context, index) => SizedBox(height: spacing.md),
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
        );
        return Align(
          alignment: Alignment.bottomCenter,
          child: switch (onHeightChanged) {
            final ValueChanged<double> callback =>
              LiveMonitorMeasuredCardOverlay(
                onHeightChanged: callback,
                child: cardList,
              ),
            null => cardList,
          },
        );
      },
    );
  }
}
