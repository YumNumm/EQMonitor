import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/notifier/replay_notifier.dart';
import 'package:eqmonitor/feature/earthquake_replay/ui/components/replay_control_sheet.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

class const ReplayStatusCard({super.key}) extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPlaying = ref.watch(
      replayProvider.select((state) => state?.isPlaying ?? false),
    );
    final designSystem = context.designSystem;
    final color = designSystem.colorTheme.primary;
    final textStyle = designSystem.typography.monoMedium.copyWith(
      color: color,
      fontSize: 12,
      letterSpacing: -0.5,
    );

    return Card.outlined(
      color: designSystem.colorTheme.surfaceContainerHigh.withValues(
        alpha: 0.92,
      ),
      elevation: 0,
      shape: RoundedSuperellipseBorder(
        borderRadius: BorderRadius.circular(designSystem.shape.md),
        side: BorderSide(color: color),
      ),
      child: Semantics(
        button: true,
        label: '過去の地震を再生中。タップすると再生を操作できます',
        excludeSemantics: true,
        child: InkWell(
          onTap: () async => const ReplayControlSheetAction().show(context),
          borderRadius: BorderRadius.circular(designSystem.shape.md),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: designSystem.spacing.sm,
              vertical: designSystem.spacing.xs,
            ),
            child: Row(
              mainAxisSize: .min,
              children: [
                Icon(
                  isPlaying ? Icons.history_rounded : Icons.pause_rounded,
                  size: 14,
                  color: color,
                ),
                const SizedBox(width: 4),
                Flexible(child: Text('過去の地震を再生中', style: textStyle)),
                const SizedBox(width: 2),
                Icon(Icons.expand_less_rounded, size: 14, color: color),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
