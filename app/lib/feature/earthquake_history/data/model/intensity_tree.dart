import 'package:eqapi_types/eqapi_types.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jma_parameter_types/earthquake_param.pb.dart';

part 'intensity_tree.freezed.dart';

/// 震度別にグループ化されたツリー構造
@freezed
abstract class IntensityTree with _$IntensityTree {
  const factory IntensityTree({
    required Map<IntensityValue, List<RegionIntensityNode>> byIntensity,
  }) = _IntensityTree;
}

/// 地方(都道府県)単位の震度ノード
@freezed
abstract class RegionIntensityNode with _$RegionIntensityNode {
  const factory RegionIntensityNode({
    required EarthquakeParameterRegionItem region,
    required IntensityValue? maxIntensity,
    required List<CityIntensityNode> cities,
  }) = _RegionIntensityNode;
}

/// 市区町村単位の震度ノード
@freezed
abstract class CityIntensityNode with _$CityIntensityNode {
  const factory CityIntensityNode({
    required EarthquakeParameterCityItem city,
    required IntensityValue? maxIntensity,
    required List<StationIntensityNode> stations,
  }) = _CityIntensityNode;
}

/// 観測点単位の震度ノード
@freezed
abstract class StationIntensityNode with _$StationIntensityNode {
  const factory StationIntensityNode({
    required EarthquakeParameterStationItem station,
    required IntensityStationItem? intensity,
  }) = _StationIntensityNode;
}
