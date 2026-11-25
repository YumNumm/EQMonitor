import 'dart:typed_data';

import 'package:kyoshin_waveform/src/kyoshin_waveform_component.dart';

final class const KnetAsciiChannel({
  required final String stationCode,
  required final double stationLatitude,
  required final double stationLongitude,
  required final double stationHeightMeters,
  required final DateTime recordTime,
  required final int samplingRate,
  required final KyoshinWaveformComponent component,
  required final double scaleFactor,
  required final double maxAccelerationGal,
  required final Int32List counts,
}) {
  // 公開データはトリガーの15秒前から収録されている。Record Time はトリガーの時刻。
  static const pretriggerDuration = Duration(seconds: 15);

  DateTime get startTime => recordTime.subtract(pretriggerDuration);

  Float64List get accelerationGal {
    var sum = 0.0;
    for (final count in counts) {
      sum += count;
    }
    final offset = counts.isEmpty ? 0.0 : sum / counts.length;
    final result = Float64List(counts.length);
    for (var i = 0; i < counts.length; i++) {
      result[i] = (counts[i] - offset) * scaleFactor;
    }
    return result;
  }
}
