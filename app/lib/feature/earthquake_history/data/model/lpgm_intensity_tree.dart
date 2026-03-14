import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_station.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_tree.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jma_parameter_types/earthquake_param.pb.dart';

part 'lpgm_intensity_tree.freezed.dart';
part 'lpgm_intensity_tree.g.dart';

/// 地方(都道府県)単位の長周期地震動階級ノード
@freezed
abstract class RegionLpgmIntensityNode with _$RegionLpgmIntensityNode {
  const factory RegionLpgmIntensityNode({
    @EarthquakeParameterRegionItemConverter()
    required EarthquakeParameterRegionItem region,
    required JmaLpgmIntensity? maxLpgmIntensity,
    required List<CityLpgmIntensityNode> cities,
  }) = _RegionLpgmIntensityNode;

  factory RegionLpgmIntensityNode.fromJson(Map<String, dynamic> json) =>
      _$RegionLpgmIntensityNodeFromJson(json);
}

/// 市区町村単位の長周期地震動階級ノード
@freezed
abstract class CityLpgmIntensityNode with _$CityLpgmIntensityNode {
  const factory CityLpgmIntensityNode({
    @EarthquakeParameterCityItemConverter()
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
    @EarthquakeParameterStationItemConverter()
    required EarthquakeParameterStationItem station,
    required IntensityStation? intensity,
  }) = _StationLpgmIntensityNode;

  factory StationLpgmIntensityNode.fromJson(Map<String, dynamic> json) =>
      _$StationLpgmIntensityNodeFromJson(json);
}
