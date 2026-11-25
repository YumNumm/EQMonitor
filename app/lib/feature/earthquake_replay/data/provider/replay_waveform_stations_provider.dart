import 'package:eqmonitor/feature/earthquake_replay/data/logic/replay_waveform_station_calculator.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/model/replay_source.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/model/replay_waveform_station.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/notifier/replay_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'replay_waveform_stations_provider.g.dart';

@Riverpod(keepAlive: true)
Future<List<ReplayWaveformStation>> replayWaveformStations(Ref ref) async {
  final source = ref.watch(replayProvider.select((state) => state?.source));
  if (source is! ReplayEqrpSource) {
    return const [];
  }
  return ref
      .watch(replayWaveformStationCalculatorProvider)
      .calculate(source.file.data);
}
