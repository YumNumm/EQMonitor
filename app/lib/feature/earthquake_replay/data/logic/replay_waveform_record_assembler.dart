import 'package:earthquake_replay/earthquake_replay.dart';
import 'package:kyoshin_waveform/kyoshin_waveform.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'replay_waveform_record_assembler.g.dart';

@riverpod
ReplayWaveformRecordAssembler replayWaveformRecordAssembler(Ref ref) =>
    const ReplayWaveformRecordAssembler();

class const ReplayWaveformRecordAssembler() {
  List<KyoshinWaveformRecord> assemble(
    Iterable<KyoshinWaveformReplayData> frames,
  ) => const KyoshinWaveformRecordAssembler().assemble([
    for (final frame in frames) _channel(frame),
  ]);

  KyoshinWaveformRecord? assembleStation({
    required List<ReplayData> frames,
    required String stationCode,
  }) => assemble(
    frames.whereType<KyoshinWaveformReplayData>().where(
      (frame) => frame.metadata.stationCode == stationCode,
    ),
  ).firstOrNull;

  KyoshinRawChannel _channel(KyoshinWaveformReplayData frame) {
    final metadata = frame.metadata;
    return KyoshinRawChannel(
      stationCode: metadata.stationCode,
      stationLatitude: metadata.stationLatitude,
      stationLongitude: metadata.stationLongitude,
      stationHeightMeters: metadata.stationHeightMeters,
      recordTime: metadata.recordTime.toUtc(),
      samplingRate: metadata.samplingHz,
      component: KyoshinWaveformComponent.fromDirection(metadata.direction),
      scaleFactor: metadata.scaleNumeratorGal / metadata.scaleDenominator,
      maxAccelerationGal: metadata.maxAccelerationGal,
      counts: frame.counts,
    );
  }
}
