import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';

extension JmaIntensityDouble on double {
  JmaIntensity? get toJmaIntensity => switch (this) {
    < -0.5 => null,
    < 0.5 => JmaIntensity.zero,
    < 1.5 => JmaIntensity.one,
    < 2.5 => JmaIntensity.two,
    < 3.5 => JmaIntensity.three,
    < 4.5 => JmaIntensity.four,
    < 5.0 => JmaIntensity.fiveLower,
    < 5.5 => JmaIntensity.fiveUpper,
    < 6.0 => JmaIntensity.sixLower,
    < 6.5 => JmaIntensity.sixUpper,
    _ => JmaIntensity.seven,
  };
}

extension JmaIntensityRealtimeEx on JmaIntensity {
  (double min, double max) get toRealtimeValue => switch (this) {
    JmaIntensity.unknown => (double.negativeInfinity, double.infinity),
    JmaIntensity.zero => (double.negativeInfinity, 0.5),
    JmaIntensity.one => (0.5, 1.5),
    JmaIntensity.two => (1.5, 2.5),
    JmaIntensity.three => (2.5, 3.5),
    JmaIntensity.four => (3.5, 4.5),
    JmaIntensity.fiveUnknown => (4.5, double.infinity),
    JmaIntensity.fiveLower => (4.5, 5.0),
    JmaIntensity.fiveUpper => (5.0, 5.5),
    JmaIntensity.sixUnknown => (5.5, double.infinity),
    JmaIntensity.sixLower => (5.5, 6.0),
    JmaIntensity.sixUpper => (6.0, 6.5),
    JmaIntensity.seven => (6.5, double.infinity),
  };
}
