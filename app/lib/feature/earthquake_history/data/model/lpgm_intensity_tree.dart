import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_station.dart';
import 'package:eqmonitor/feature/parameter/data/model/parameter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'lpgm_intensity_tree.freezed.dart';
part 'lpgm_intensity_tree.g.dart';

/// 都道府県単位の長周期地震動階級ノード
@freezed
abstract class PrefectureLpgmIntensityNode with _$PrefectureLpgmIntensityNode {
  const factory PrefectureLpgmIntensityNode({
    required EarthquakeParameterRegionItem region,
    required JmaLpgmIntensity? maxLpgmIntensity,
    required List<CityLpgmIntensityNode> cities,
  }) = _PrefectureLpgmIntensityNode;

  factory PrefectureLpgmIntensityNode.fromJson(Map<String, dynamic> json) =>
      _$PrefectureLpgmIntensityNodeFromJson(json);
}

@freezed
abstract class LpgmIntensityRegion with _$LpgmIntensityRegion {
  const factory LpgmIntensityRegion({
    required EarthquakeParameterRegionItem region,
    required JmaLpgmIntensity? maxLpgmIntensity,
  }) = _LpgmIntensityRegion;

  factory LpgmIntensityRegion.fromJson(Map<String, dynamic> json) =>
      _$LpgmIntensityRegionFromJson(json);
}

/// 市区町村単位の長周期地震動階級ノード
@freezed
abstract class CityLpgmIntensityNode with _$CityLpgmIntensityNode {
  const factory CityLpgmIntensityNode({
    required EarthquakeParameterCityItem city,
    required JmaLpgmIntensity? maxLpgmIntensity,
    required List<StationLpgmIntensityNode> stations,
  }) = _CityLpgmIntensityNode;

  factory CityLpgmIntensityNode.fromJson(Map<String, dynamic> json) =>
      _$CityLpgmIntensityNodeFromJson(json);
}

/// 観測点単位の長周期地震動階級ノード
@freezed
abstract class StationLpgmIntensityNode with _$StationLpgmIntensityNode {
  const factory StationLpgmIntensityNode({
    required EarthquakeParameterStationItem station,
    required IntensityStation? intensity,
  }) = _StationLpgmIntensityNode;

  factory StationLpgmIntensityNode.fromJson(Map<String, dynamic> json) =>
      _$StationLpgmIntensityNodeFromJson(json);
}
