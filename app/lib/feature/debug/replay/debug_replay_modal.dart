import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/feature/debug/replay/debug_replay_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

const _kNotoScenarioPath = 'assets/debug/eew/noto_peninsula_20240101';

class DebugReplayModal extends ConsumerWidget {
  const DebugReplayModal({super.key});

  static Future<void> show(BuildContext context) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => const DebugReplayModal(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final designSystem = context.designSystem;
    final spacing = designSystem.spacing;
    final typography = designSystem.typography;
    final textColor = designSystem.textColor;
    final replayState = ref.watch(debugReplayProvider);
    final notifier = ref.read(debugReplayProvider.notifier);

    final isPlaying = replayState.status == DebugReplayStatus.playing;
    final isCompleted = replayState.status == DebugReplayStatus.completed;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(spacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Icon(Icons.bug_report_rounded, color: textColor.secondary),
                SizedBox(width: spacing.sm),
                Text('デバッグリプレイ', style: typography.titleMedium),
              ],
            ),
            SizedBox(height: spacing.md),
            _ScenarioCard(
              title: '能登半島地震 EEW (2024-01-01)',
              subtitle: 'M7.6 / 石川県能登地方 / 震度7',
              icon: Icons.tsunami_rounded,
              isPlaying: isPlaying,
              isCompleted: isCompleted,
              currentIndex: replayState.currentIndex,
              totalCount: replayState.totalCount,
              onTap:
                  isPlaying
                      ? null
                      : () async => notifier.start(_kNotoScenarioPath),
              onStop: notifier.stop,
            ),
            SizedBox(height: spacing.sm),
          ],
        ),
      ),
    );
  }
}

class _ScenarioCard extends StatelessWidget {
  const _ScenarioCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.isPlaying,
    required this.isCompleted,
    required this.currentIndex,
    required this.totalCount,
    required this.onTap,
    required this.onStop,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final bool isPlaying;
  final bool isCompleted;
  final int currentIndex;
  final int totalCount;
  final VoidCallback? onTap;
  final VoidCallback onStop;

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final color = designSystem.color;
    final textColor = designSystem.textColor;
    final spacing = designSystem.spacing;
    final shape = designSystem.shape;
    final typography = designSystem.typography;

    Widget trailing;
    if (isCompleted) {
      trailing = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.check_circle_rounded, color: Colors.green),
          SizedBox(width: spacing.xs),
          TextButton(onPressed: onStop, child: const Text('リセット')),
        ],
      );
    } else if (isPlaying) {
      trailing = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
          SizedBox(width: spacing.sm),
          Text(
            '$currentIndex / $totalCount',
            style: typography.labelSmall,
          ),
          SizedBox(width: spacing.xs),
          IconButton(
            icon: const Icon(Icons.stop_rounded),
            onPressed: onStop,
            tooltip: '停止',
          ),
        ],
      );
    } else {
      trailing = Icon(Icons.play_arrow_rounded, color: textColor.secondary);
    }

    return Card(
      color: color.surfaceRaised,
      elevation: 0,
      shape: RoundedSuperellipseBorder(
        borderRadius: BorderRadius.circular(shape.card),
        side: BorderSide(color: color.outlineSoft),
      ),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title, style: typography.bodyMedium),
        subtitle: Text(subtitle, style: typography.labelSmall),
        trailing: trailing,
        onTap: onTap,
      ),
    );
  }
}
