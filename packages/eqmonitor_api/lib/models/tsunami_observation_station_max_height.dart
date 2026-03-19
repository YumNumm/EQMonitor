// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'observation_max_height_condition.dart';

part 'tsunami_observation_station_max_height.freezed.dart';
part 'tsunami_observation_station_max_height.g.dart';

@Freezed()
abstract class TsunamiObservationStationMaxHeight with _$TsunamiObservationStationMaxHeight {
  const factory TsunamiObservationStationMaxHeight({
    @JsonKey(name: 'date_time')
    required DateTime dateTime,
    required num value,
    required bool over,
    @JsonKey(name: 'is_rising')
    required bool isRising,
    required ObservationMaxHeightCondition condition,
    @JsonKey(name: 'is_missing')
    required bool isMissing,
  }) = _TsunamiObservationStationMaxHeight;
  
  factory TsunamiObservationStationMaxHeight.fromJson(Map<String, Object?> json) => _$TsunamiObservationStationMaxHeightFromJson(json);
}
