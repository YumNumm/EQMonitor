import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/provider/clock/app_clock.dart';
import 'package:eqmonitor/core/provider/clock/time_mode.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// タイムシフトで選択できる過去方向のオフセットプリセット。
const _kTimeShiftPresets = <(String, Duration)>[
  ('10秒前', Duration(seconds: -10)),
  ('30秒前', Duration(seconds: -30)),
  ('1分前', Duration(minutes: -1)),
  ('3分前', Duration(minutes: -3)),
  ('5分前', Duration(minutes: -5)),
];

/// 再生モード（通常再生 / タイムシフト）を切り替えるモーダル。
///
/// 強震モニタ・EEW・揺れ検知の表示時刻はすべて [AppClock] に従うため、
/// ここでモードを切り替えると本物の表示パイプラインがその時刻基準で再生される。
class PlaybackModeModal extends ConsumerWidget {
  const PlaybackModeModal({super.key});

  static Future<void> show(BuildContext context) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => const PlaybackModeModal(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final designSystem = context.designSystem;
    final spacing = designSystem.spacing;
    final typography = designSystem.typography;
    final textColor = designSystem.textColor;

    final mode = ref.watch(appClockProvider);
    final notifier = ref.read(appClockProvider.notifier);
    final currentOffset = switch (mode) {
      TimeShiftTimeMode(:final offset) => offset,
      _ => null,
    };

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(spacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Icon(Icons.history_rounded, color: textColor.secondary),
                SizedBox(width: spacing.sm),
                Text('再生モード', style: typography.titleMedium),
              ],
            ),
            SizedBox(height: spacing.xs),
            Text(
              'タイムシフトを選ぶと強震モニタ・EEW・揺れ検知が指定時刻基準で再生されます。',
              style: typography.labelSmall.copyWith(color: textColor.secondary),
            ),
            SizedBox(height: spacing.md),
            Wrap(
              spacing: spacing.sm,
              runSpacing: spacing.sm,
              children: [
                ChoiceChip(
                  avatar: const Icon(Icons.play_arrow_rounded),
                  label: const Text('通常再生'),
                  selected: mode is RealtimeTimeMode,
                  onSelected: (_) => notifier.returnToRealtime(),
                ),
                for (final (label, offset) in _kTimeShiftPresets)
                  ChoiceChip(
                    label: Text(label),
                    selected: currentOffset == offset,
                    onSelected: (_) => notifier.enterTimeShift(offset),
                  ),
              ],
            ),
            SizedBox(height: spacing.sm),
          ],
        ),
      ),
    );
  }
}
