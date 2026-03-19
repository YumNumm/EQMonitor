// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'wave_initial.dart';

part 'tsunami_observation_station_first_height.freezed.dart';
part 'tsunami_observation_station_first_height.g.dart';

@Freezed()
abstract class TsunamiObservationStationFirstHeight with _$TsunamiObservationStationFirstHeight {
  const factory TsunamiObservationStationFirstHeight({
    @JsonKey(name: 'arrival_time')
    required DateTime arrivalTime,
    required WaveInitial initial,
    @JsonKey(name: 'is_unidentifiable')
    required bool isUnidentifiable,
    @JsonKey(name: 'is_missing')
    required bool isMissing,
  }) = _TsunamiObservationStationFirstHeight;
  
  factory TsunamiObservationStationFirstHeight.fromJson(Map<String, Object?> json) => _$TsunamiObservationStationFirstHeightFromJson(json);
}
