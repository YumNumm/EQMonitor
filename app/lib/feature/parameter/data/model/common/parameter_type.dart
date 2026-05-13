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
}
