import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_station.dart';
import 'package:eqmonitor/feature/parameter/data/model/earthquake/earthquake_parameter_json_converters.dart';
import 'package:eqmonitor/feature/parameter/data/model/parameter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'intensity_tree.freezed.dart';
part 'intensity_tree.g.dart';

/// 都道府県単位の震度ノード
@freezed
abstract class PrefectureIntensityNode with _$PrefectureIntensityNode {
  const factory({
    required IntensityPrefecture prefecture,
    required List<CityIntensityNode> cities,
  }) = _PrefectureIntensityNode;

  factory fromJson(Map<String, dynamic> json) =>
      _$PrefectureIntensityNodeFromJson(json);
}

@freezed
abstract class IntensityPrefecture with _$IntensityPrefecture {
  const factory({
    @EarthquakeParameterPrefectureItemJsonConverter()
    required EarthquakeParameterPrefectureItem prefecture,
    required JmaIntensity? maxIntensity,
  }) = _IntensityPrefecture;

  factory fromJson(Map<String, dynamic> json) =>
      _$IntensityPrefectureFromJson(json);
}

@freezed
abstract class IntensityRegion with _$IntensityRegion {
  const factory({
    @EarthquakeParameterRegionItemJsonConverter()
    required EarthquakeParameterRegionItem region,
    required JmaIntensity? maxIntensity,
  }) = _IntensityRegion;

  factory fromJson(Map<String, dynamic> json) =>
      _$IntensityRegionFromJson(json);
}

/// 市区町村単位の震度ノード
@freezed
abstract class CityIntensityNode with _$CityIntensityNode {
  const factory({
    @EarthquakeParameterCityItemJsonConverter()
    required EarthquakeParameterCityItem city,
    required JmaIntensity? maxIntensity,
    required List<StationIntensityNode> stations,
    JmaLpgmIntensity? maxLpgmIntensity,
  }) = _CityIntensityNode;

  factory fromJson(Map<String, dynamic> json) =>
      _$CityIntensityNodeFromJson(json);
}

/// 観測点単位の震度ノード
@freezed
abstract class StationIntensityNode with _$StationIntensityNode {
  const factory({
    @EarthquakeParameterStationItemJsonConverter()
    required EarthquakeParameterStationItem station,
    required IntensityStation? intensity,
  }) = _StationIntensityNode;

  factory fromJson(Map<String, dynamic> json) =>
      _$StationIntensityNodeFromJson(json);
}
