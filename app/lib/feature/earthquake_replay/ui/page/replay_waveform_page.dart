import 'package:collection/collection.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/util/haptic.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/model/kyoshin_waveform_quantity.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/notifier/replay_notifier.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/provider/replay_waveform_features_provider.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/provider/replay_waveform_record_provider.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/provider/replay_waveform_stations_provider.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/provider/replay_waveform_time_provider.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/provider/replay_waveform_traces_provider.dart';
import 'package:eqmonitor/feature/earthquake_replay/ui/components/kyoshin_waveform_chart.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kyoshin_waveform/kyoshin_waveform.dart';
import 'package:material_ui/material_ui.dart';

class const ReplayWaveformPage({required final String stationCode, super.key})
    extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final record = ref.watch(
      replayWaveformRecordProvider(stationCode: stationCode),
    );
    final name = ref.watch(replayWaveformStationNamesProvider)[stationCode];
    final isPlaying = ref.watch(
      replayProvider.select((s) => s?.isPlaying ?? false),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(name == null ? stationCode : '$name（$stationCode）'),
        actions: [
          IconButton(
            tooltip: isPlaying ? '一時停止' : '再生',
            onPressed: () => HapticUtil.light(
              ref.read(replayProvider.notifier).togglePlayPause,
            ),
            icon: Icon(
              isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
            ),
          ),
        ],
      ),
      body: record == null
          ? const Center(child: Text('この観測点の波形はありません'))
          : _WaveformBody(record: record),
    );
  }
}

class const _WaveformBody({required final KyoshinWaveformRecord record})
    extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final designSystem = context.designSystem;
    final spacing = designSystem.spacing;
    final quantity = useState(KyoshinWaveformQuantity.acceleration);
    final surfaceOnly = useState(false);
    final selected = useState(<KyoshinWaveformComponent>{});
    final hasBorehole = record.channels.any(
      (channel) => channel.component.position == .borehole,
    );
    final visibleComponents = [
      for (final channel in record.channels)
        if (!surfaceOnly.value || channel.component.position == .surface)
          channel.component,
    ];
    final traces = ref.watch(
      replayWaveformTracesProvider(
        stationCode: record.stationCode,
        quantity: quantity.value,
      ),
    );
    final shownTraces = useMemoized(
      () => [
        for (final trace in traces)
          if ((!surfaceOnly.value || trace.component.position == .surface) &&
              (selected.value.isEmpty ||
                  selected.value.contains(trace.component)))
            trace,
      ],
      [traces, surfaceOnly.value, selected.value],
    );
    final time =
        ref.watch(replayWaveformTimeProvider).value ??
        ref.watch(replayProvider.select((s) => s?.currentTime));
    final station = ref
        .watch(replayWaveformStationsProvider)
        .value
        ?.firstWhereOrNull((s) => s.stationCode == record.stationCode);
    final current = time == null ? null : station?.intensities.valueAt(time);
    final max = station?.intensities.maxValue;
    final unit = quantity.value.unit;
    final peaks = shownTraces
        .map(
          (t) =>
              '${t.component.label} ${t.peakAbsolute.toStringAsFixed(2)} $unit',
        )
        .join('、');
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(spacing.md),
        child: Column(
          crossAxisAlignment: .stretch,
          children: [
            Text(
              'リアルタイム震度 現在 ${current?.toStringAsFixed(1) ?? '-'}'
              '・最大 ${max?.toStringAsFixed(1) ?? '-'}',
              style: designSystem.typography.titleSmall,
            ),
            SizedBox(height: spacing.sm),
            SegmentedButton<KyoshinWaveformQuantity>(
              showSelectedIcon: false,
              segments: [
                for (final value in KyoshinWaveformQuantity.values)
                  ButtonSegment(value: value, label: Text(value.label)),
              ],
              selected: {quantity.value},
              onSelectionChanged: (value) => quantity.value = value.first,
            ),
            SizedBox(height: spacing.xs),
            Wrap(
              spacing: spacing.xs,
              runSpacing: spacing.xs,
              children: [
                if (hasBorehole)
                  FilterChip(
                    label: const Text('地表のみ'),
                    selected: surfaceOnly.value,
                    onSelected: (value) {
                      surfaceOnly.value = value;
                      selected.value = {
                        for (final component in selected.value)
                          if (!value || component.position == .surface)
                            component,
                      };
                    },
                  ),
                for (final component in visibleComponents)
                  FilterChip(
                    label: Text(component.label),
                    selected: selected.value.contains(component),
                    onSelected: (value) => selected.value = value
                        ? {...selected.value, component}
                        : ({...selected.value}..remove(component)),
                  ),
              ],
            ),
            SizedBox(height: spacing.xs),
            Text(
              '成分を選ぶと、選んだ成分だけを大きく表示します。'
              '速度・変位は 0.1 Hz のハイパスフィルタを掛けて積分した値。'
              'リアルタイム震度は計測震度相当の値で、気象庁の発表する震度ではありません。',
              style: designSystem.typography.bodySmall.copyWith(
                color: designSystem.colorTheme.onSurfaceVariant,
              ),
            ),
            SizedBox(height: spacing.md),
            Expanded(
              child: Semantics(
                label:
                    '${record.stationCode} の${quantity.value.label}波形。'
                    '最大振幅 $peaks',
                child: KyoshinWaveformChart(
                  traces: shownTraces,
                  unit: unit,
                  samplingRate: record.samplingRate,
                  startTime: record.startTime,
                  duration: record.duration,
                  intensities: station?.intensities,
                  position: time?.difference(record.startTime),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
