// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'tsunami_observation_station_first_height.dart';
import 'tsunami_observation_station_max_height.dart';

part 'merged_offshore_observation.freezed.dart';
part 'merged_offshore_observation.g.dart';

@Freezed()
abstract class MergedOffshoreObservation with _$MergedOffshoreObservation {
  const factory MergedOffshoreObservation({
    @JsonKey(name: 'station_code')
    required String stationCode,
    @JsonKey(name: 'station_name')
    required String stationName,
    @JsonKey(includeIfNull: false)
    String? sensor,
    @JsonKey(includeIfNull: false,name: 'first_height')
    TsunamiObservationStationFirstHeight? firstHeight,
    @JsonKey(includeIfNull: false,name: 'max_height')
    TsunamiObservationStationMaxHeight? maxHeight,
  }) = _MergedOffshoreObservation;
  
  factory MergedOffshoreObservation.fromJson(Map<String, Object?> json) => _$MergedOffshoreObservationFromJson(json);
}
