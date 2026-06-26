// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'revise.dart';
import 'wave_initial.dart';

part 'tsunami_station_observation_first_height.freezed.dart';
part 'tsunami_station_observation_first_height.g.dart';

@Freezed()
abstract class TsunamiStationObservationFirstHeight with _$TsunamiStationObservationFirstHeight {
  const factory TsunamiStationObservationFirstHeight({
    /// 識別不能時に出現する.
    /// const: true.
    @JsonKey(name: 'is_unidentifiable')
    required bool isUnidentifiable,

    /// 欠測によりデータがない場合出現する.
    /// const: true.
    @JsonKey(name: 'is_missing')
    required bool isMissing,

    /// 欠測時、識別不能時は出現しない
    @JsonKey(includeIfNull: false,name: 'arrival_time')
    DateTime? arrivalTime,
    @JsonKey(includeIfNull: false)
    WaveInitial? initial,
    @JsonKey(includeIfNull: false)
    Revise? revise,
  }) = _TsunamiStationObservationFirstHeight;
  
  factory TsunamiStationObservationFirstHeight.fromJson(Map<String, Object?> json) => _$TsunamiStationObservationFirstHeightFromJson(json);
}
