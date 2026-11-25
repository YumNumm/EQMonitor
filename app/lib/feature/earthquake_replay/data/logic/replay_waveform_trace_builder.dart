import 'package:eqmonitor/feature/earthquake_replay/data/model/kyoshin_waveform_quantity.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/model/kyoshin_waveform_trace.dart';
import 'package:kyoshin_waveform/kyoshin_waveform.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'replay_waveform_trace_builder.g.dart';

@riverpod
ReplayWaveformTraceBuilder replayWaveformTraceBuilder(Ref ref) =>
    const ReplayWaveformTraceBuilder(integrator: KyoshinWaveformIntegrator());

class const ReplayWaveformTraceBuilder({
  required final KyoshinWaveformIntegrator integrator,
}) {
  List<KyoshinWaveformTrace> build({
    required KyoshinWaveformRecord record,
    required KyoshinWaveformQuantity quantity,
  }) => [
    for (final channel in record.channels)
      KyoshinWaveformTrace(
        component: channel.component,
        samples: switch (quantity) {
          .acceleration => channel.accelerationGal,
          .velocity => integrator.velocity(
            accelerationGal: channel.accelerationGal,
            samplingRate: record.samplingRate,
          ),
          .displacement => integrator.displacement(
            accelerationGal: channel.accelerationGal,
            samplingRate: record.samplingRate,
          ),
        },
      ),
  ];
}
