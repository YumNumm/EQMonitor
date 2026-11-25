import 'dart:isolate';

import 'package:collection/collection.dart';
import 'package:earthquake_replay/earthquake_replay.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/logic/replay_waveform_record_assembler.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/model/replay_waveform_station.dart';
import 'package:kyoshin_waveform/kyoshin_waveform.dart';
import 'package:realtime_seismic_intensity/realtime_seismic_intensity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'replay_waveform_station_calculator.g.dart';

@riverpod
ReplayWaveformStationCalculator replayWaveformStationCalculator(Ref ref) =>
    ReplayWaveformStationCalculator(
      records: ref.watch(replayWaveformRecordAssemblerProvider),
    );

class const ReplayWaveformStationCalculator({
  required final ReplayWaveformRecordAssembler records,
}) {
  static const stepsPerSecond = 10;

  Future<List<ReplayWaveformStation>> calculate(List<ReplayData> frames) {
    final waveforms = frames.whereType<KyoshinWaveformReplayData>().toList();
    if (waveforms.isEmpty) {
      return Future.value(const []);
    }
    return Isolate.run(() => calculateSync(waveforms));
  }

  // 観測点ごとに組み立てて捨て、全観測点の加速度を同時にメモリへ載せない。
  List<ReplayWaveformStation> calculateSync(
    List<KyoshinWaveformReplayData> waveforms,
  ) {
    final stations = <ReplayWaveformStation>[];
    final groups = groupBy(
      waveforms,
      (frame) => frame.metadata.stationCode,
    );
    for (final group in groups.values) {
      for (final record in records.assemble(group)) {
        final station = _station(record);
        if (station != null) {
          stations.add(station);
        }
      }
    }
    return stations;
  }

  // 強震モニタの地表と同じく、KiK-net は地表（NS2・EW2・UD2）で求める。
  ReplayWaveformStation? _station(KyoshinWaveformRecord record) {
    final components = record.threeComponents(.surface);
    if (components == null) {
      return null;
    }
    return ReplayWaveformStation(
      stationCode: record.stationCode,
      latitude: record.latitude,
      longitude: record.longitude,
      intensities: const RealtimeIntensitySeriesCalculator().calculate(
        startTime: record.startTime,
        samplingRate: record.samplingRate,
        ns: components.ns.accelerationGal,
        ew: components.ew.accelerationGal,
        ud: components.ud.accelerationGal,
        stepsPerSecond: record.samplingRate % stepsPerSecond == 0
            ? stepsPerSecond
            : 1,
      ),
    );
  }
}
