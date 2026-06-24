import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/provider/clock/app_clock.dart';
import 'package:eqmonitor/core/provider/clock/time_mode.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/notifier/replay_notifier.dart';
import 'package:eqmonitor/feature/playback_mode/data/notifier/auto_return_to_realtime_notifier.dart';
import 'package:file_picker/file_picker.dart';
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

/// リプレイ再生速度のプリセット。
const _kSpeedPresets = <double>[0.5, 1, 2, 4];

/// 再生モード（通常 / タイムシフト / EQRP リプレイ）を切り替えるモーダル。
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

    final replay = ref.watch(replayProvider);

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
            SizedBox(height: spacing.md),
            if (replay != null)
              const _ReplayControls()
            else ...[
              const _TimeShiftSection(),
              SizedBox(height: spacing.md),
              const _OpenReplayFileButton(),
            ],
            SizedBox(height: spacing.sm),
            const Divider(),
            const _AutoReturnToggle(),
            SizedBox(height: spacing.sm),
          ],
        ),
      ),
    );
  }
}

class _TimeShiftSection extends ConsumerWidget {
  const _TimeShiftSection();

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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'タイムシフトを選ぶと強震モニタ・EEW・揺れ検知が指定時刻基準で再生されます。',
          style: typography.labelSmall.copyWith(color: textColor.secondary),
        ),
        SizedBox(height: spacing.sm),
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
      ],
    );
  }
}

class _AutoReturnToggle extends ConsumerWidget {
  const _AutoReturnToggle();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final enabled = ref.watch(autoReturnToRealtimeProvider);
    return SwitchListTile(
      contentPadding: EdgeInsets.zero,
      title: const Text('リアルタイムイベントで通常再生に戻る'),
      subtitle: const Text('再生中にEEW・揺れ検知が発生したら自動で現在へ復帰します'),
      value: enabled,
      onChanged: (value) async =>
          ref.read(autoReturnToRealtimeProvider.notifier).set(value: value),
    );
  }
}

class _OpenReplayFileButton extends ConsumerWidget {
  const _OpenReplayFileButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FilledButton.tonalIcon(
      icon: const Icon(Icons.folder_open_rounded),
      label: const Text('EQRP リプレイファイルを開く'),
      onPressed: () async {
        final result = await FilePicker.pickFiles(
          type: .custom,
          allowedExtensions: const ['eqrp'],
        );
        final picked = result?.files.singleOrNull;
        final bytes = await picked?.readAsBytes();
        if (bytes == null) {
          return;
        }
        await ref
            .read(replayProvider.notifier)
            .loadFile(bytes: bytes, fileName: picked!.name);
      },
    );
  }
}

class _ReplayControls extends ConsumerWidget {
  const _ReplayControls();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final designSystem = context.designSystem;
    final spacing = designSystem.spacing;
    final typography = designSystem.typography;
    final textColor = designSystem.textColor;

    final replay = ref.watch(replayProvider);
    final notifier = ref.read(replayProvider.notifier);
    if (replay == null) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Icon(Icons.movie_rounded, color: textColor.secondary, size: 18),
            SizedBox(width: spacing.xs),
            Expanded(
              child: Text(
                replay.fileName,
                style: typography.labelMedium,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        Slider(
          value: replay.progress.clamp(0.0, 1.0),
          onChanged: (value) async => notifier.seekToProgress(value),
        ),
        Row(
          children: [
            IconButton.filledTonal(
              icon: Icon(
                replay.isPlaying
                    ? Icons.pause_rounded
                    : Icons.play_arrow_rounded,
              ),
              onPressed: notifier.togglePlayPause,
            ),
            SizedBox(width: spacing.sm),
            Text(
              '${replay.currentIndex + 1} / ${replay.totalFrames}',
              style: typography.labelSmall,
            ),
            const Spacer(),
            DropdownButton<double>(
              value: replay.playbackSpeed,
              underline: const SizedBox.shrink(),
              items: [
                for (final speed in _kSpeedPresets)
                  DropdownMenuItem(value: speed, child: Text('${speed}x')),
              ],
              onChanged: (value) {
                if (value != null) {
                  notifier.setPlaybackSpeed(value);
                }
              },
            ),
          ],
        ),
        SizedBox(height: spacing.xs),
        TextButton.icon(
          icon: const Icon(Icons.stop_rounded),
          label: const Text('リプレイを終了して通常再生へ'),
          onPressed: notifier.exit,
        ),
      ],
    );
  }
}
