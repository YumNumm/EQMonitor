import 'dart:convert';

import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_station.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jma_parameter_types/earthquake_param.pb.dart';

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
    @EarthquakeParameterRegionItemConverter()
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
    @EarthquakeParameterCityItemConverter()
    required EarthquakeParameterCityItem city,
    required JmaIntensity? maxIntensity,
    required List<StationIntensityNode> stations,
    @JsonKey(name: 'max_lpgm_intensity') JmaLpgmIntensity? maxLpgmIntensity,
  }) = _CityIntensityNode;

  factory CityIntensityNode.fromJson(Map<String, dynamic> json) =>
      _$CityIntensityNodeFromJson(json);
}

/// 観測点単位の震度ノード
@freezed
abstract class StationIntensityNode with _$StationIntensityNode {
  const factory StationIntensityNode({
    @EarthquakeParameterStationItemConverter()
    required EarthquakeParameterStationItem station,
    required IntensityStation? intensity,
  }) = _StationIntensityNode;

  factory StationIntensityNode.fromJson(Map<String, dynamic> json) =>
      _$StationIntensityNodeFromJson(json);
}

class EarthquakeParameterRegionItemConverter
    implements
        JsonConverter<EarthquakeParameterRegionItem, Map<String, dynamic>> {
  const EarthquakeParameterRegionItemConverter();
  @override
  EarthquakeParameterRegionItem fromJson(Map<String, dynamic> json) =>
      EarthquakeParameterRegionItem.fromJson(
        jsonEncode(json),
      );

  @override
  Map<String, dynamic> toJson(EarthquakeParameterRegionItem object) =>
      object.writeToJsonMap();
}

class EarthquakeParameterCityItemConverter
    implements
        JsonConverter<EarthquakeParameterCityItem, Map<String, dynamic>> {
  const EarthquakeParameterCityItemConverter();
  @override
  EarthquakeParameterCityItem fromJson(Map<String, dynamic> json) =>
      EarthquakeParameterCityItem.fromJson(jsonEncode(json));

  @override
  Map<String, dynamic> toJson(EarthquakeParameterCityItem object) =>
      object.writeToJsonMap();
}

class EarthquakeParameterStationItemConverter
    implements
        JsonConverter<EarthquakeParameterStationItem, Map<String, dynamic>> {
  const EarthquakeParameterStationItemConverter();
  @override
  EarthquakeParameterStationItem fromJson(Map<String, dynamic> json) =>
      EarthquakeParameterStationItem.fromJson(jsonEncode(json));

  @override
  Map<String, dynamic> toJson(EarthquakeParameterStationItem object) =>
      object.writeToJsonMap();
}
