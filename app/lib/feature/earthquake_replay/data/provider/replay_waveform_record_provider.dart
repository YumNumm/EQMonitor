import 'package:eqmonitor/feature/earthquake_replay/data/logic/replay_waveform_record_assembler.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/model/replay_source.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/notifier/replay_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kyoshin_waveform/kyoshin_waveform.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'replay_waveform_record_provider.g.dart';

@riverpod
KyoshinWaveformRecord? replayWaveformRecord(
  Ref ref, {
  required String stationCode,
}) {
  final source = ref.watch(replayProvider.select((state) => state?.source));
  if (source is! ReplayEqrpSource) {
    return null;
  }
  return ref
      .watch(replayWaveformRecordAssemblerProvider)
      .assembleStation(frames: source.file.data, stationCode: stationCode);
}
