import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
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
}

extension ParameterTypeApiExtension on ParameterType {
  String get pathSegment => switch (this) {
    .jmaCodeTable => 'jma_code_table',
    .kyoshinObservationPoints => 'kyoshin_observation_points',
    .earthquakeStations => 'earthquake_stations',
    .tsunamiStations => 'tsunami_stations',
  };

  api.ParameterType get toApiParameterType => switch (this) {
    .jmaCodeTable => .jmaCodeTable,
    .kyoshinObservationPoints => .kyoshinObservationPoints,
    .earthquakeStations => .earthquakeStations,
    .tsunamiStations => .tsunamiStations,
  };
}
