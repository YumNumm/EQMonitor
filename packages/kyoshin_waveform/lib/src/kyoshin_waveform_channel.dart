import 'dart:typed_data';

import 'package:kyoshin_waveform/src/kyoshin_waveform_component.dart';

final class const KyoshinWaveformChannel({
  required final KyoshinWaveformComponent component,
  required final Float64List accelerationGal,
}) {
  double get peakAbsoluteGal {
    var peak = 0.0;
    for (final value in accelerationGal) {
      final absolute = value.abs();
      if (absolute > peak) {
        peak = absolute;
      }
    }
    return peak;
  }
}
