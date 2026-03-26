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
    @JsonKey(includeIfNull: false,name: 'date_time')
    DateTime? dateTime,
    @JsonKey(includeIfNull: false)
    num? value,
    @JsonKey(includeIfNull: false)
    bool? over,
    @JsonKey(includeIfNull: false,name: 'is_rising')
    bool? isRising,
    @JsonKey(includeIfNull: false)
    ObservationMaxHeightCondition? condition,
    @JsonKey(includeIfNull: false,name: 'is_missing')
    bool? isMissing,
  }) = _TsunamiObservationStationMaxHeight;
  
  factory TsunamiObservationStationMaxHeight.fromJson(Map<String, Object?> json) => _$TsunamiObservationStationMaxHeightFromJson(json);
}
