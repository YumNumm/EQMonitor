import 'dart:async';

import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/core/util/date_time_format.dart';
import 'package:eqmonitor/core/util/haptic.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/logic/replay_duration_formatter.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/model/replay_state.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/notifier/replay_notifier.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/provider/replay_waveform_stations_provider.dart';
import 'package:eqmonitor/feature/earthquake_replay/ui/components/replay_origin_track_shape.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

class const ReplayControlPanel({required final ReplayState state, super.key})
    extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final designSystem = context.designSystem;
    final spacing = designSystem.spacing;

    return Padding(
      padding: EdgeInsets.fromLTRB(spacing.md, 0, spacing.md, spacing.md),
      child: Column(
        mainAxisSize: .min,
        crossAxisAlignment: .stretch,
        children: [
          Text(
            state.source.title,
            style: designSystem.typography.bodySmall.copyWith(
              color: designSystem.colorTheme.onSurfaceVariant,
            ),
            maxLines: 1,
            overflow: .ellipsis,
          ),
          SizedBox(height: spacing.xs),
          _ReplayTimeline(state: state),
          _ReplayTransportControls(isPlaying: state.isPlaying),
          SizedBox(height: spacing.sm),
          _ReplaySpeedSelector(
            speeds: state.source.playbackSpeeds,
            speed: state.playbackSpeed,
          ),
          const _ReplayWaveformButton(),
          SizedBox(height: spacing.sm),
          FilledButton.tonalIcon(
            onPressed: () => HapticUtil.light(
              () => ref.read(replayProvider.notifier).exit(),
            ),
            icon: const Icon(Icons.stop_rounded),
            label: const Text('再生を終了して現在の情報に戻る'),
          ),
        ],
      ),
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
    final colorTheme = designSystem.colorTheme;
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
    final originTime = switch (state.source.originTime) {
      final time?
          when canSeek &&
              !time.isBefore(state.startTime) &&
              !time.isAfter(state.endTime) =>
        time,
      _ => null,
    };
    final originLabel = switch (originTime) {
      null => null,
      final time when state.source.isOriginApproximate =>
        '発生 ${time.formatWithTz(DateTimeFormat.hourMinute)}頃',
      final time => '発生 ${time.formatWithTz(DateTimeFormat.hourMinuteSecond)}',
    };

    return Column(
      crossAxisAlignment: .stretch,
      children: [
        FittedBox(
          fit: .scaleDown,
          child: Text(
            shownTime.formatWithTz(
              DateTimeFormat.yearMonthDayHourMinuteSecond,
            ),
            style: typography.monoLarge,
          ),
        ),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackShape: ReplayOriginTrackShape(
              originFraction: originTime == null
                  ? null
                  : originTime.difference(state.startTime).inMilliseconds /
                        totalMs,
              markerColor: colorTheme.error,
            ),
          ),
          child: Slider(
            value: dragValue.value ?? progress,
            semanticFormatterCallback: (value) => [
              state.startTime
                  .add(state.duration * value)
                  .formatWithTz(DateTimeFormat.hourMinuteSecond),
              ?originLabel,
            ].join('、'),
            onChanged: canSeek ? (value) => dragValue.value = value : null,
            onChangeEnd: canSeek
                ? (value) async {
                    unawaited(HapticFeedback.selectionClick());
                    dragValue.value = null;
                    await ref
                        .read(replayProvider.notifier)
                        .seek(state.startTime.add(state.duration * value));
                  }
                : null,
          ),
        ),
        Row(
          children: [
            Text(formatter.format(shownElapsed), style: typography.monoSmall),
            Expanded(
              child: originTime == null || originLabel == null
                  ? const SizedBox.shrink()
                  : FittedBox(
                      fit: .scaleDown,
                      child: TextButton.icon(
                        onPressed: () => HapticUtil.light(
                          () => ref
                              .read(replayProvider.notifier)
                              .seek(originTime),
                        ),
                        style: TextButton.styleFrom(
                          foregroundColor: colorTheme.error,
                          visualDensity: .compact,
                        ),
                        icon: const Icon(Icons.crisis_alert_rounded, size: 16),
                        label: Text(originLabel),
                      ),
                    ),
            ),
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
          iconSize: 28,
          onPressed: () => HapticUtil.light(() => notifier.seekBy(-_skip)),
          icon: const Icon(Icons.replay_10_rounded),
        ),
        IconButton.filled(
          tooltip: isPlaying ? '一時停止' : '再生',
          iconSize: 32,
          onPressed: () => HapticUtil.light(notifier.togglePlayPause),
          icon: Icon(
            isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
          ),
        ),
        IconButton(
          tooltip: '10秒進む',
          iconSize: 28,
          onPressed: () => HapticUtil.light(() => notifier.seekBy(_skip)),
          icon: const Icon(Icons.forward_10_rounded),
        ),
      ],
    );
  }
}

class const _ReplaySpeedSelector({
  required final List<double> speeds,
  required final double speed,
}) extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SegmentedButton<double>(
      showSelectedIcon: false,
      segments: [
        for (final value in speeds)
          ButtonSegment(
            value: value,
            label: Text(
              '${value == value.roundToDouble() ? value.toInt() : value}x',
            ),
          ),
      ],
      selected: {speed},
      onSelectionChanged: (selection) => HapticUtil.selection(
        () =>
            ref.read(replayProvider.notifier).setPlaybackSpeed(selection.first),
      ),
    );
  }
}

class const _ReplayWaveformButton() extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stationCount = ref.watch(
      replayWaveformStationsProvider.select((s) => s.value?.length ?? 0),
    );
    if (stationCount == 0) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: EdgeInsets.only(top: context.designSystem.spacing.sm),
      child: OutlinedButton.icon(
        onPressed: () =>
            const ReplayWaveformStationListRoute().push<void>(context),
        icon: const Icon(Icons.ssid_chart_rounded),
        label: Text('観測点の波形（$stationCount地点）'),
      ),
    );
  }
}
