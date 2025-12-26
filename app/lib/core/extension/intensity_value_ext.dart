import 'package:eqapi_types/eqapi_types.dart';

extension IntensityValueToJmaForecastIntensity on IntensityValue {
  JmaForecastIntensity get toJmaForecastIntensity => switch (this) {
    IntensityValue.zero => JmaForecastIntensity.zero,
    IntensityValue.one => JmaForecastIntensity.one,
    IntensityValue.two => JmaForecastIntensity.two,
    IntensityValue.three => JmaForecastIntensity.three,
    IntensityValue.four => JmaForecastIntensity.four,
    IntensityValue.fiveLowerNoInput => JmaForecastIntensity.fiveLower,
    IntensityValue.fiveLower => JmaForecastIntensity.fiveLower,
    IntensityValue.fiveUpper => JmaForecastIntensity.fiveUpper,
    IntensityValue.sixLower => JmaForecastIntensity.sixLower,
    IntensityValue.sixUpper => JmaForecastIntensity.sixUpper,
    IntensityValue.seven => JmaForecastIntensity.seven,
  };
}

extension LpgmIntensityValueToJmaForecastLgIntensity on LpgmIntensityValue {
  JmaForecastLgIntensity get toJmaForecastLgIntensity => switch (this) {
    LpgmIntensityValue.zero => JmaForecastLgIntensity.zero,
    LpgmIntensityValue.one => JmaForecastLgIntensity.one,
    LpgmIntensityValue.two => JmaForecastLgIntensity.two,
    LpgmIntensityValue.three => JmaForecastLgIntensity.three,
    LpgmIntensityValue.four => JmaForecastLgIntensity.four,
  };
}
