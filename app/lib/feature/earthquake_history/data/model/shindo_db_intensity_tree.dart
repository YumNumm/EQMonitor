import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_catalog.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/shindo_db_intensity_class.dart';
import 'package:eqmonitor/feature/parameter/data/model/earthquake/earthquake_parameter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lat_lng/lat_lng.dart';

part 'shindo_db_intensity_tree.freezed.dart';

@Freezed(fromJson: false)
abstract class ShindoDbIntensityTree with _$ShindoDbIntensityTree {
  const factory ShindoDbIntensityTree({
    required Map<ShindoDbIntensityClass, List<ShindoDbPrefectureNode>> tree,
    required Map<ShindoDbIntensityClass, List<ShindoDbStationNode>>
    unresolvedStations,
    required int totalStationCount,
  }) = _ShindoDbIntensityTree;
}

@Freezed(fromJson: false)
abstract class ShindoDbPrefectureNode with _$ShindoDbPrefectureNode {
  const factory ShindoDbPrefectureNode({
    required EarthquakeParameterPrefectureItem prefecture,
    required List<ShindoDbCityNode> cities,
  }) = _ShindoDbPrefectureNode;
}

@Freezed(fromJson: false)
abstract class ShindoDbCityNode with _$ShindoDbCityNode {
  const factory ShindoDbCityNode({
    required EarthquakeParameterCityItem city,
    required EarthquakeParameterRegionItem region,
    required List<ShindoDbStationNode> stations,
  }) = _ShindoDbCityNode;
}

@Freezed(fromJson: false)
abstract class ShindoDbStationNode with _$ShindoDbStationNode {
  const factory ShindoDbStationNode({
    required EarthquakeCatalogStationRecord record,
    required String name,
    required LatLng? location,
  }) = _ShindoDbStationNode;
}
