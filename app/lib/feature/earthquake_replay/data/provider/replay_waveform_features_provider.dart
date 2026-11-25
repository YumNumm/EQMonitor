import 'package:eqmonitor/core/provider/kmoni_observation_points/provider/kyoshin_observation_points_provider.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/logic/replay_waveform_feature_builder.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/notifier/replay_notifier.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/provider/replay_waveform_stations_provider.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/provider/replay_waveform_time_provider.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/provider/kyoshin_color_map.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'replay_waveform_features_provider.g.dart';

@riverpod
Map<String, String> replayWaveformStationNames(Ref ref) {
  final parameter = ref.watch(kyoshinObservationPointsProvider).value;
  if (parameter == null) {
    return const {};
  }
  return {for (final point in parameter.points) point.code: point.name};
}

@riverpod
List<Map<String, dynamic>> replayWaveformFeatures(Ref ref) {
  final stations = ref.watch(replayWaveformStationsProvider).value;
  if (stations == null || stations.isEmpty) {
    return const [];
  }
  final time =
      ref.watch(replayWaveformTimeProvider).value ??
      ref.watch(replayProvider.select((state) => state?.currentTime));
  if (time == null) {
    return const [];
  }
  return ReplayWaveformFeatureBuilder(
    colorMap: ref.watch(kyoshinColorMapProvider),
    stationNames: ref.watch(replayWaveformStationNamesProvider),
  ).build(stations: stations, time: time);
}
