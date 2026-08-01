import 'package:eqmonitor/feature/asset_pack/data/model/asset_pack_manifest.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

@JsonEnum()
enum ParameterType {
  @JsonValue('JMA_CODE_TABLE')
  jmaCodeTable,
  @JsonValue('KYOSHIN_OBSERVATION_POINTS')
  kyoshinObservationPoints,
  @JsonValue('EARTHQUAKE_STATIONS')
  earthquakeStations,
  @JsonValue('TSUNAMI_STATIONS')
  tsunamiStations,
  @JsonValue('SHINDO_DB_STATIONS')
  shindoDbStations,
}

extension ParameterTypeApiExtension on ParameterType {
  String get pathSegment => switch (this) {
    .jmaCodeTable => 'jma_code_table',
    .kyoshinObservationPoints => 'kyoshin_observation_points',
    .earthquakeStations => 'earthquake_stations',
    .tsunamiStations => 'tsunami_stations',
    .shindoDbStations => 'shindo_db_stations',
  };

  String get serializedValue => switch (this) {
    .jmaCodeTable => 'JMA_CODE_TABLE',
    .kyoshinObservationPoints => 'KYOSHIN_OBSERVATION_POINTS',
    .earthquakeStations => 'EARTHQUAKE_STATIONS',
    .tsunamiStations => 'TSUNAMI_STATIONS',
    .shindoDbStations => 'SHINDO_DB_STATIONS',
  };

  /// Maps to the corresponding Asset Pack asset id (see
  /// `AssetPackAssetId` / backend `AssetId`). Every [ParameterType] has a
  /// 1:1 counterpart asset id; only `BASE_MAP_PMTILES` has no
  /// [ParameterType] counterpart (it's map data, not a parameter).
  AssetPackAssetId get toAssetPackAssetId => switch (this) {
    .jmaCodeTable => .jmaCodeTable,
    .kyoshinObservationPoints => .kyoshinObservationPoints,
    .earthquakeStations => .earthquakeStations,
    .tsunamiStations => .tsunamiStations,
    .shindoDbStations => .shindoDbStations,
  };
}
