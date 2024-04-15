import 'package:eqapi_types/eqapi_types.dart';

extension JmaForecastIntensityDouble on double {
  JmaForecastIntensity? get toJmaForecastIntensity => switch (this) {
        < -0.5 => null,
        < 0.5 => JmaForecastIntensity.zero,
        < 1.5 => JmaForecastIntensity.one,
        < 2.5 => JmaForecastIntensity.two,
        < 3.5 => JmaForecastIntensity.three,
        < 4.5 => JmaForecastIntensity.four,
        < 5.0 => JmaForecastIntensity.fiveLower,
        < 5.5 => JmaForecastIntensity.fiveUpper,
        < 6.0 => JmaForecastIntensity.sixLower,
        < 6.5 => JmaForecastIntensity.sixUpper,
        _ => JmaForecastIntensity.seven,
      };
}

extension JmaForecastIntensityEx on JmaForecastIntensity {
  (double min, double max) get toRealtimeValue => switch (this) {
        JmaForecastIntensity.zero => (double.negativeInfinity, 0.5),
        JmaForecastIntensity.one => (0.5, 1.5),
        JmaForecastIntensity.two => (1.5, 2.5),
        JmaForecastIntensity.three => (2.5, 3.5),
        JmaForecastIntensity.four => (3.5, 4.5),
        JmaForecastIntensity.fiveLower => (4.5, 5.0),
        JmaForecastIntensity.fiveUpper => (5.0, 5.5),
        JmaForecastIntensity.sixLower => (5.5, 6.0),
        JmaForecastIntensity.sixUpper => (6.0, 6.5),
        JmaForecastIntensity.seven => (6.5, double.infinity),
        _ => throw UnimplementedError(),
      };
}
