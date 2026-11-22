import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/util/date_time_format.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/logic/replay_duration_formatter.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/model/replay_state.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/notifier/replay_notifier.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

class const ReplayControlSheetAction() {
  Future<void> show(BuildContext context) => showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    useSafeArea: true,
    builder: (context) => const _ReplayControlSheet(),
  );
}

class const _ReplayControlSheet() extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(replayProvider);
    if (state == null) {
      return const SizedBox.shrink();
    }
    final spacing = context.designSystem.spacing;

    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.fromLTRB(
        spacing.xl,
        0,
        spacing.xl,
        spacing.xl,
      ),
      children: [
        _ReplayHeader(fileName: state.fileName),
        SizedBox(height: spacing.lg),
        _ReplayTimeline(state: state),
        SizedBox(height: spacing.sm),
        _ReplayTransportControls(isPlaying: state.isPlaying),
        SizedBox(height: spacing.lg),
        _ReplaySpeedSelector(speed: state.playbackSpeed),
        SizedBox(height: spacing.xl),
        FilledButton.tonalIcon(
          onPressed: () {
            Navigator.of(context).pop();
            ref.read(replayProvider.notifier).exit();
          },
          icon: const Icon(Icons.stop_rounded),
          label: const Text('再生を終了して現在の情報に戻る'),
        ),
      ],
    );
  }
}

class const _ReplayHeader({required final String fileName})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final typography = designSystem.typography;
    final colorTheme = designSystem.colorTheme;

    return Row(
      children: [
        Icon(Icons.history_rounded, color: colorTheme.primary),
        SizedBox(width: designSystem.spacing.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Text('過去の地震を再生中', style: typography.titleMedium),
              Text(
                fileName,
                style: typography.bodySmall.copyWith(
                  color: colorTheme.onSurfaceVariant,
                ),
                maxLines: 1,
                overflow: .ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class const _ReplayTimeline({required final ReplayState state})
    extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dragValue = useState<double?>(null);
    final designSystem = context.designSystem;
    final typography = designSystem.typography;
    const formatter = ReplayDurationFormatter();

    final totalMs = state.duration.inMilliseconds;
    final canSeek = totalMs > 0;
    final progress = canSeek
        ? (state.elapsed.inMilliseconds / totalMs).clamp(0.0, 1.0)
        : 0.0;
    final shownElapsed = switch (dragValue.value) {
      final value? => state.duration * value,
      null => state.elapsed,
    };
    final shownTime = state.startTime.add(shownElapsed);

    return Column(
      crossAxisAlignment: .stretch,
      children: [
        Text(
          shownTime.formatWithTz(DateTimeFormat.yearMonthDayHourMinuteSecond),
          style: typography.monoLarge,
          textAlign: .center,
        ),
        Slider(
          value: dragValue.value ?? progress,
          onChanged: canSeek ? (value) => dragValue.value = value : null,
          onChangeEnd: canSeek
              ? (value) async {
                  dragValue.value = null;
                  await ref
                      .read(replayProvider.notifier)
                      .seek(state.startTime.add(state.duration * value));
                }
              : null,
        ),
        Row(
          mainAxisAlignment: .spaceBetween,
          children: [
            Text(formatter.format(shownElapsed), style: typography.monoSmall),
            Text(
              formatter.format(state.duration),
              style: typography.monoSmall,
            ),
          ],
        ),
      ],
    );
  }
}

class const _ReplayTransportControls({required final bool isPlaying})
    extends ConsumerWidget {
  static const _skip = Duration(seconds: 10);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(replayProvider.notifier);

    return Row(
      mainAxisAlignment: .center,
      spacing: context.designSystem.spacing.lg,
      children: [
        IconButton(
          tooltip: '10秒戻る',
          iconSize: 32,
          onPressed: () async => notifier.seekBy(-_skip),
          icon: const Icon(Icons.replay_10_rounded),
        ),
        IconButton.filled(
          tooltip: isPlaying ? '一時停止' : '再生',
          iconSize: 40,
          onPressed: () async => notifier.togglePlayPause(),
          icon: Icon(
            isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
          ),
        ),
        IconButton(
          tooltip: '10秒進む',
          iconSize: 32,
          onPressed: () async => notifier.seekBy(_skip),
          icon: const Icon(Icons.forward_10_rounded),
        ),
      ],
    );
  }
}

class const _ReplaySpeedSelector({required final double speed})
    extends ConsumerWidget {
  static const _speeds = [0.5, 1.0, 2.0, 4.0];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SegmentedButton<double>(
      showSelectedIcon: false,
      segments: [
        for (final value in _speeds)
          ButtonSegment(
            value: value,
            label: Text(
              '${value == value.roundToDouble() ? value.toInt() : value}x',
            ),
          ),
      ],
      selected: {speed},
      onSelectionChanged: (selection) =>
          ref.read(replayProvider.notifier).setPlaybackSpeed(selection.first),
    );
  }
}
