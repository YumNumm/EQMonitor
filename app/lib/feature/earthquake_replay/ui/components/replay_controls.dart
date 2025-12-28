import 'package:eqmonitor/feature/earthquake_replay/data/model/replay_state.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/notifier/replay_notifier.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class ReplayControls extends HookConsumerWidget {
  const ReplayControls({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final replayState = ref.watch(replayProvider);

    if (replayState == null) {
      return const SizedBox.shrink();
    }

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _TimeDisplay(state: replayState),
            const SizedBox(height: 8),
            _SeekBar(state: replayState),
            const SizedBox(height: 8),
            _PlaybackControls(state: replayState),
          ],
        ),
      ),
    );
  }
}

class _TimeDisplay extends StatelessWidget {
  const _TimeDisplay({required this.state});

  final ReplayState state;

  static final _timeFormat = DateFormat('HH:mm:ss');

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Row(
      children: [
        Expanded(
          child: Text(
            _timeFormat.format(state.startTime.toLocal()),
            style: theme.textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            _timeFormat.format(state.currentTime.toLocal()),
            style: theme.textTheme.titleMedium?.copyWith(
              color: colorScheme.onPrimaryContainer,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: Text(
            _timeFormat.format(state.endTime.toLocal()),
            style: theme.textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

class _SeekBar extends ConsumerWidget {
  const _SeekBar({required this.state});

  final ReplayState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Slider(
      value: state.progress,
      onChanged: (value) async =>
          ref.read(replayProvider.notifier).seekToProgress(value),
    );
  }
}

class _PlaybackControls extends ConsumerWidget {
  const _PlaybackControls({required this.state});

  final ReplayState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final notifier = ref.read(replayProvider.notifier);

    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 4,
      runSpacing: 8,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _SpeedButton(
              speed: 0.5,
              currentSpeed: state.playbackSpeed,
              onPressed: () => notifier.setPlaybackSpeed(0.5),
            ),
            _SpeedButton(
              speed: 1,
              currentSpeed: state.playbackSpeed,
              onPressed: () => notifier.setPlaybackSpeed(1),
            ),
            _SpeedButton(
              speed: 2,
              currentSpeed: state.playbackSpeed,
              onPressed: () => notifier.setPlaybackSpeed(2),
            ),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.skip_previous),
              onPressed: notifier.previousFrame,
              tooltip: '前のフレーム',
            ),
            FilledButton.icon(
              onPressed: notifier.togglePlayPause,
              icon: Icon(state.isPlaying ? Icons.pause : Icons.play_arrow),
              label: Text(state.isPlaying ? '一時停止' : '再生'),
              style: FilledButton.styleFrom(
                backgroundColor: colorScheme.primary,
                foregroundColor: colorScheme.onPrimary,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.skip_next),
              onPressed: notifier.nextFrame,
              tooltip: '次のフレーム',
            ),
          ],
        ),
        Text(
          '${state.currentIndex + 1} / ${state.totalFrames}',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

class _SpeedButton extends StatelessWidget {
  const _SpeedButton({
    required this.speed,
    required this.currentSpeed,
    required this.onPressed,
  });

  final double speed;
  final double currentSpeed;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isSelected = (currentSpeed - speed).abs() < 0.01;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: isSelected
              ? colorScheme.primaryContainer
              : Colors.transparent,
          foregroundColor: isSelected
              ? colorScheme.onPrimaryContainer
              : colorScheme.primary,
          side: BorderSide(
            color: isSelected ? colorScheme.primary : colorScheme.outline,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          minimumSize: Size.zero,
        ),
        child: Text('${speed}x'),
      ),
    );
  }
}
