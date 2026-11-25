import 'package:collection/collection.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/util/haptic.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/notifier/replay_notifier.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/provider/replay_waveform_features_provider.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/provider/replay_waveform_record_provider.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/provider/replay_waveform_stations_provider.dart';
import 'package:eqmonitor/feature/earthquake_replay/ui/components/kyoshin_waveform_chart.dart';
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
    extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final designSystem = context.designSystem;
    final spacing = designSystem.spacing;
    final time = ref.watch(replayProvider.select((s) => s?.currentTime));
    final station = ref
        .watch(replayWaveformStationsProvider)
        .value
        ?.firstWhereOrNull((s) => s.stationCode == record.stationCode);
    final current = time == null ? null : station?.intensities.valueAt(time);
    final max = station?.intensities.maxValue;
    final peaks = record.channels
        .map(
          (c) =>
              '${c.component.label} ${c.peakAbsoluteGal.toStringAsFixed(1)} gal',
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
            SizedBox(height: spacing.xs),
            Text(
              '加速度は記録全長の平均値を引いた値。計測震度相当の値で、気象庁の発表する震度ではありません。',
              style: designSystem.typography.bodySmall.copyWith(
                color: designSystem.colorTheme.onSurfaceVariant,
              ),
            ),
            SizedBox(height: spacing.md),
            Expanded(
              child: Semantics(
                label: '${record.stationCode} の加速度波形。最大振幅 $peaks',
                child: KyoshinWaveformChart(
                  record: record,
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
