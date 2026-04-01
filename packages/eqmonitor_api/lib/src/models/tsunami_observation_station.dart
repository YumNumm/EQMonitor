// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'tsunami_observation_station_first_height.dart';
import 'tsunami_observation_station_max_height.dart';

part 'tsunami_observation_station.freezed.dart';
part 'tsunami_observation_station.g.dart';

@Freezed()
abstract class TsunamiObservationStation with _$TsunamiObservationStation {
  const factory TsunamiObservationStation({
    required String code,
    required String name,
    @JsonKey(name: 'first_height')
    required TsunamiObservationStationFirstHeight firstHeight,
    @JsonKey(includeIfNull: false)
    String? sensor,
    @JsonKey(includeIfNull: false,name: 'max_height')
    TsunamiObservationStationMaxHeight? maxHeight,
  }) = _TsunamiObservationStation;
  
  factory TsunamiObservationStation.fromJson(Map<String, Object?> json) => _$TsunamiObservationStationFromJson(json);
}
