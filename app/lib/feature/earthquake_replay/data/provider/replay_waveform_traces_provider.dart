import 'package:eqmonitor/feature/earthquake_replay/data/logic/replay_waveform_trace_builder.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/model/kyoshin_waveform_quantity.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/model/kyoshin_waveform_trace.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/provider/replay_waveform_record_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'replay_waveform_traces_provider.g.dart';

@riverpod
List<KyoshinWaveformTrace> replayWaveformTraces(
  Ref ref, {
  required String stationCode,
  required KyoshinWaveformQuantity quantity,
}) {
  final record = ref.watch(
    replayWaveformRecordProvider(stationCode: stationCode),
  );
  if (record == null) {
    return const [];
  }
  return ref
      .watch(replayWaveformTraceBuilderProvider)
      .build(record: record, quantity: quantity);
}
