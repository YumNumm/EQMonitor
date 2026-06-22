// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'revise.dart';
import 'wave_initial.dart';

part 'tsunami_station_observation_first_height.freezed.dart';
part 'tsunami_station_observation_first_height.g.dart';

@Freezed()
abstract class TsunamiStationObservationFirstHeight with _$TsunamiStationObservationFirstHeight {
  const factory TsunamiStationObservationFirstHeight({
    /// 欠測時、識別不能時は出現しない
    @JsonKey(includeIfNull: false,name: 'arrival_time')
    DateTime? arrivalTime,
    @JsonKey(includeIfNull: false)
    WaveInitial? initial,

    /// 識別不能時に出現する
    @JsonKey(includeIfNull: false,name: 'is_unidentifiable')
    dynamic isUnidentifiable,

    /// 欠測によりデータがない場合出現する
    @JsonKey(includeIfNull: false,name: 'is_missing')
    dynamic isMissing,
    @JsonKey(includeIfNull: false)
    Revise? revise,
  }) = _TsunamiStationObservationFirstHeight;
  
  factory TsunamiStationObservationFirstHeight.fromJson(Map<String, Object?> json) => _$TsunamiStationObservationFirstHeightFromJson(json);
}
