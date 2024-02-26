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
