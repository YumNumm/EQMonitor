import 'package:collection/collection.dart';
import 'package:kyoshin_waveform/src/kyoshin_raw_channel.dart';
import 'package:kyoshin_waveform/src/kyoshin_waveform_channel.dart';
import 'package:kyoshin_waveform/src/kyoshin_waveform_record.dart';

final class const KyoshinWaveformRecordAssembler() {
  List<KyoshinWaveformRecord> assemble(List<KyoshinRawChannel> channels) {
    final groups = groupBy(
      channels,
      (channel) => (channel.stationCode, channel.recordTime),
    );
    return [
      for (final group in groups.values) _assembleStation(group),
    ]..sort((a, b) => a.stationCode.compareTo(b.stationCode));
  }

  KyoshinWaveformRecord _assembleStation(List<KyoshinRawChannel> channels) {
    final first = channels.first;
    if (channels.any((channel) => channel.samplingRate != first.samplingRate)) {
      throw FormatException(
        'Sampling rates differ between channels',
        first.stationCode,
      );
    }
    final sorted = [...channels]
      ..sort((a, b) => a.component.index.compareTo(b.component.index));
    return KyoshinWaveformRecord(
      stationCode: first.stationCode,
      latitude: first.stationLatitude,
      longitude: first.stationLongitude,
      heightMeters: first.stationHeightMeters,
      startTime: first.startTime,
      samplingRate: first.samplingRate,
      channels: [
        for (final channel in sorted)
          KyoshinWaveformChannel(
            component: channel.component,
            accelerationGal: channel.accelerationGal,
          ),
      ],
    );
  }
}
