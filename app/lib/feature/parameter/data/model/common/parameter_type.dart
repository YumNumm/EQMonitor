import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:freezed_annotation/freezed_annotation.dart';

@JsonEnum(fieldRename: .snake)
enum ParameterType {
  jmaCodeTable,
  kyoshinObservationPoints,
  earthquakeStations,
  tsunamiStations,
}

extension ParameterTypeApiExtension on ParameterType {
  String get pathSegment => switch (this) {
    .jmaCodeTable => 'jma_code_table',
    .kyoshinObservationPoints => 'kyoshin_observation_points',
    .earthquakeStations => 'earthquake_stations',
    .tsunamiStations => 'tsunami_stations',
  };

  api.ParameterType get toApi => switch (this) {
    .jmaCodeTable => .jmaCodeTable,
    .kyoshinObservationPoints => .kyoshinObservationPoints,
    .earthquakeStations => .earthquakeStations,
    .tsunamiStations => .tsunamiStations,
  };
}

extension ApiParameterTypeExtension on api.ParameterType {
  ParameterType toParameterType() => switch (this) {
    .jmaCodeTable => .jmaCodeTable,
    .kyoshinObservationPoints => .kyoshinObservationPoints,
    .earthquakeStations => .earthquakeStations,
    .tsunamiStations => .tsunamiStations,
  };
}
