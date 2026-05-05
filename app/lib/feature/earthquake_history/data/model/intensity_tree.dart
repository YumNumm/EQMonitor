import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_station.dart';
import 'package:eqmonitor/feature/parameter/data/model/parameter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'intensity_tree.freezed.dart';
part 'intensity_tree.g.dart';

/// 都道府県単位の震度ノード
@freezed
abstract class PrefectureIntensityNode with _$PrefectureIntensityNode {
  const factory PrefectureIntensityNode({
    required IntensityRegion region,
    required List<CityIntensityNode> cities,
  }) = _PrefectureIntensityNode;

  factory PrefectureIntensityNode.fromJson(Map<String, dynamic> json) =>
      _$PrefectureIntensityNodeFromJson(json);
}

@freezed
abstract class IntensityRegion with _$IntensityRegion {
  const factory IntensityRegion({
    required EarthquakeParameterRegionItem region,
    required JmaIntensity? maxIntensity,
  }) = _IntensityRegion;

  factory IntensityRegion.fromJson(Map<String, dynamic> json) =>
      _$IntensityRegionFromJson(json);
}

/// 市区町村単位の震度ノード
@freezed
abstract class CityIntensityNode with _$CityIntensityNode {
  const factory CityIntensityNode({
    required EarthquakeParameterCityItem city,
    required JmaIntensity? maxIntensity,
    required List<StationIntensityNode> stations,
    JmaLpgmIntensity? maxLpgmIntensity,
  }) = _CityIntensityNode;

  factory CityIntensityNode.fromJson(Map<String, dynamic> json) =>
      _$CityIntensityNodeFromJson(json);
}

/// 観測点単位の震度ノード
@freezed
abstract class StationIntensityNode with _$StationIntensityNode {
  const factory StationIntensityNode({
    required EarthquakeParameterStationItem station,
    required IntensityStation? intensity,
  }) = _StationIntensityNode;

  factory StationIntensityNode.fromJson(Map<String, dynamic> json) =>
      _$StationIntensityNodeFromJson(json);
}
