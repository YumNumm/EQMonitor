import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/util/date_time_format.dart';
import 'package:eqmonitor/core/util/haptic.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/notifier/replay_control_panel_expanded_notifier.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/notifier/replay_notifier.dart';
import 'package:eqmonitor/feature/earthquake_replay/ui/components/replay_control_panel.dart';
import 'package:flutter/physics.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:material_ui/material_ui.dart';

class const ReplayStatusCard({super.key}) extends HookConsumerWidget {
  static const _panelWidth = 340.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(replayProvider);
    final isExpanded = ref.watch(replayControlPanelExpandedProvider);
    final disableAnimations = MediaQuery.disableAnimationsOf(context);
    final animation = useAnimationController(
      initialValue: isExpanded ? 1 : 0,
      lowerBound: -0.2,
      upperBound: 1.2,
    );
    const motion = M3EMotion.expressiveSpatialDefault;
    final spring = useMemoized(
      () => SpringDescription.withDampingRatio(
        mass: 1,
        stiffness: motion.stiffness,
        ratio: motion.damping,
      ),
    );
    useEffect(() {
      final target = isExpanded ? 1.0 : 0.0;
      if (disableAnimations) {
        animation
          ..stop()
          ..value = target;
      } else {
        // ばねは目標値の手前で止まるため、止まった後に目標値へ揃えて操作パネルを確実に外す。
        animation
            .animateWith(
              SpringSimulation(
                spring,
                animation.value,
                target,
                animation.velocity,
              ),
            )
            .then<void>((_) => animation.value = target)
            .ignore();
      }
      return null;
    }, [disableAnimations, isExpanded]);

    if (state == null) {
      return const SizedBox.shrink();
    }
    final designSystem = context.designSystem;
    final color = designSystem.colorTheme.primary;
    final textStyle = designSystem.typography.monoMedium.copyWith(
      color: color,
      fontSize: 12,
      letterSpacing: -0.5,
    );
    final borderRadius = BorderRadius.circular(designSystem.shape.md);

    return Card.outlined(
      color: designSystem.colorTheme.surfaceContainerHigh.withValues(
        alpha: 0.92,
      ),
      elevation: 0,
      clipBehavior: .antiAlias,
      shape: RoundedSuperellipseBorder(
        borderRadius: borderRadius,
        side: BorderSide(color: color),
      ),
      child: Column(
        mainAxisSize: .min,
        crossAxisAlignment: .start,
        children: [
          Semantics(
            button: true,
            expanded: isExpanded,
            label: isExpanded
                ? '過去の地震を再生中。タップすると操作パネルを閉じます'
                : '過去の地震を再生中。タップすると再生を操作できます',
            excludeSemantics: true,
            child: InkWell(
              onTap: () => HapticUtil.selection(
                () => ref
                    .read(replayControlPanelExpandedProvider.notifier)
                    .toggle(),
              ),
              borderRadius: borderRadius,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: designSystem.spacing.sm,
                  vertical: designSystem.spacing.xs,
                ),
                child: Row(
                  mainAxisSize: .min,
                  children: [
                    Icon(
                      state.isPlaying
                          ? Icons.history_rounded
                          : Icons.pause_rounded,
                      size: 14,
                      color: color,
                    ),
                    const SizedBox(width: 4),
                    Flexible(
                      child: Text(
                        '過去の地震を再生中 '
                        '${state.currentTime.formatWithTz(DateTimeFormat.hourMinuteSecond)}',
                        style: textStyle,
                      ),
                    ),
                    const SizedBox(width: 2),
                    Icon(
                      isExpanded
                          ? Icons.expand_less_rounded
                          : Icons.expand_more_rounded,
                      size: 14,
                      color: color,
                    ),
                  ],
                ),
              ),
            ),
          ),
          AnimatedBuilder(
            animation: animation,
            builder: (context, child) => animation.value <= 0
                ? const SizedBox.shrink()
                : ClipRect(
                    child: Align(
                      alignment: .topLeft,
                      widthFactor: animation.value.clamp(0.0, 1.0),
                      heightFactor: animation.value.clamp(0.0, 1.2),
                      child: child,
                    ),
                  ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: _panelWidth),
              child: ReplayControlPanel(state: state),
            ),
          ),
        ],
      ),
    );
  }
}
