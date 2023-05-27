import 'package:eqapi_schema/model/lat_lng.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'earthquake.freezed.dart';
part 'earthquake.g.dart';

@freezed
class Earthquake with _$Earthquake {
  const factory Earthquake({
    required DateTime originTime,
    required DateTime arrivalTime,
    required EarthquakeHypocenter hypocenter,
    required EarthquakeMagnitude magnitude,
  }) = _Earthquake;

  factory Earthquake.fromJson(Map<String, dynamic> json) =>
      _$EarthquakeFromJson(json);
}

@freezed
class EarthquakeHypocenter with _$EarthquakeHypocenter {
  const factory EarthquakeHypocenter({
    required String name,
    required String code,

    /// 0: ごく浅い
    /// 700: 700km以上
    /// null: 不明
    required int? depth,
    required EarthquakeHypocenterDetailed? detailed,
    required LatLng? coordinate,
  }) = _EarthquakeHypocenter;

  factory EarthquakeHypocenter.fromJson(Map<String, dynamic> json) =>
      _$EarthquakeHypocenterFromJson(json);
}

@freezed
class EarthquakeHypocenterDetailed with _$EarthquakeHypocenterDetailed {
  const factory EarthquakeHypocenterDetailed({
    required String code,
    required String name,
  }) = _EarthquakeHypocenterDetailed;

  factory EarthquakeHypocenterDetailed.fromJson(Map<String, dynamic> json) =>
      _$EarthquakeHypocenterDetailedFromJson(json);
}

@freezed
class EarthquakeMagnitude with _$EarthquakeMagnitude {
  const factory EarthquakeMagnitude({
    required double? value,
    required String? condition,
  }) = _EarthquakeMagnitude;

  factory EarthquakeMagnitude.fromJson(Map<String, dynamic> json) =>
      _$EarthquakeMagnitudeFromJson(json);
}
