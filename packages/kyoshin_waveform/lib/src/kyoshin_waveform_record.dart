import 'package:collection/collection.dart';
import 'package:kyoshin_waveform/src/kyoshin_waveform_channel.dart';
import 'package:kyoshin_waveform/src/kyoshin_waveform_component.dart';

final class const KyoshinWaveformRecord({
  required final String stationCode,
  required final double latitude,
  required final double longitude,
  required final double heightMeters,
  required final DateTime startTime,
  required final int samplingRate,
  required final List<KyoshinWaveformChannel> channels,
}) {
  Duration get duration {
    final sampleCount = channels
        .map((channel) => channel.accelerationGal.length)
        .fold(0, (a, b) => a > b ? a : b);
    return Duration(
      microseconds:
          sampleCount * Duration.microsecondsPerSecond ~/ samplingRate,
    );
  }

  KyoshinWaveformChannel? channelOf(KyoshinWaveformComponent component) =>
      channels.firstWhereOrNull((channel) => channel.component == component);

  ({
    KyoshinWaveformChannel ns,
    KyoshinWaveformChannel ew,
    KyoshinWaveformChannel ud,
  })?
  threeComponents(KyoshinSensorPosition position) {
    KyoshinWaveformChannel? find(KyoshinWaveformAxis axis) =>
        channels.firstWhereOrNull(
          (channel) =>
              channel.component.position == position &&
              channel.component.axis == axis,
        );
    final ns = find(.northSouth);
    final ew = find(.eastWest);
    final ud = find(.upDown);
    if (ns == null || ew == null || ud == null) {
      return null;
    }
    return (ns: ns, ew: ew, ud: ud);
  }
}
