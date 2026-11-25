import 'dart:typed_data';

import 'package:kyoshin_waveform/kyoshin_waveform.dart';

final class const KyoshinWaveformTrace({
  required final KyoshinWaveformComponent component,
  required final Float64List samples,
}) {
  double get peakAbsolute {
    var peak = 0.0;
    for (final value in samples) {
      final absolute = value.abs();
      if (absolute > peak) {
        peak = absolute;
      }
    }
    return peak;
  }
}
