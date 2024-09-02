import 'package:eqapi_types/eqapi_types.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'earthquake_early.freezed.dart';
part 'earthquake_early.g.dart';

@freezed
class EarthquakeEarly with _$EarthquakeEarly {
  const factory EarthquakeEarly({
    required String id,
    required int? depth,
    required double? latitude,
    required double? longitude,
    required double? magnitude,
    required JmaForecastIntensity? maxIntensity,
    required bool maxIntensityIsEarly,
    required String name,
    required DateTime originTime,
    required OriginTimePrecision originTimePrecision,
  }) = _EarthquakeEarly;

  factory EarthquakeEarly.fromJson(Map<String, dynamic> json) =>
      _$EarthquakeEarlyFromJson(json);
}

enum OriginTimePrecision {
  month,
  day,
  hour,
  minute,
  second,
  millisecond,
  ;
}
