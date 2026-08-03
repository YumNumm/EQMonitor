// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'tsunami_station_observation_first_height.dart';
import 'tsunami_station_observation_max_height.dart';

part 'tsunami_station_observation.freezed.dart';
part 'tsunami_station_observation.g.dart';

@Freezed()
abstract class TsunamiStationObservation with _$TsunamiStationObservation {
  const factory TsunamiStationObservation({
    @JsonKey(name: 'first_height')
    required TsunamiStationObservationFirstHeight firstHeight,

    /// 特殊な観測機器の場合に出現
    @JsonKey(includeIfNull: false)
    String? sensor,
    @JsonKey(includeIfNull: false,name: 'max_height')
    TsunamiStationObservationMaxHeight? maxHeight,
  }) = _TsunamiStationObservation;

  factory TsunamiStationObservation.fromJson(Map<String, Object?> json) => _$TsunamiStationObservationFromJson(json);
}
