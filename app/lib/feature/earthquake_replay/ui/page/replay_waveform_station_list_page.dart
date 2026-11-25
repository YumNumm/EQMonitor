import 'package:eqmonitor/core/component/progress/accessible_progress_indicator.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/model/replay_waveform_station.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/notifier/replay_notifier.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/provider/replay_waveform_features_provider.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/provider/replay_waveform_stations_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

class const ReplayWaveformStationListPage({super.key}) extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stationsAsync = ref.watch(replayWaveformStationsProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('観測点の波形')),
      body: switch (stationsAsync) {
        AsyncData(value: final stations) when stations.isEmpty => const Center(
          child: Text('再生中のファイルに K-NET・KiK-net の波形はありません'),
        ),
        AsyncData(value: final stations) => _StationList(
          stations: [...stations]
            ..sort(
              (a, b) => (b.intensities.maxValue ?? double.negativeInfinity)
                  .compareTo(a.intensities.maxValue ?? double.negativeInfinity),
            ),
        ),
        AsyncError() => const Center(child: Text('波形からの震度の計算に失敗しました')),
        _ => const Center(child: AccessibleCircularProgressIndicator()),
      },
    );
  }
}

class const _StationList({required final List<ReplayWaveformStation> stations})
    extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final names = ref.watch(replayWaveformStationNamesProvider);
    final time = ref.watch(replayProvider.select((s) => s?.currentTime));
    return ListView.builder(
      itemCount: stations.length,
      itemBuilder: (context, index) {
        final station = stations[index];
        final current = time == null ? null : station.intensities.valueAt(time);
        final max = station.intensities.maxValue;
        return ListTile(
          title: Text(
            '${names[station.stationCode] ?? station.stationCode}'
            '（${station.stationCode}）',
          ),
          subtitle: Text(
            '最大 ${max?.toStringAsFixed(1) ?? '-'}'
            '・現在 ${current?.toStringAsFixed(1) ?? '-'}',
          ),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => ReplayWaveformRoute(
            stationCode: station.stationCode,
          ).push<void>(context),
        );
      },
    );
  }
}
