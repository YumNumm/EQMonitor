// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'observation_max_height_condition.dart';
import 'revise.dart';

part 'tsunami_station_observation_max_height.freezed.dart';
part 'tsunami_station_observation_max_height.g.dart';

@Freezed()
abstract class TsunamiStationObservationMaxHeight with _$TsunamiStationObservationMaxHeight {
  const factory TsunamiStationObservationMaxHeight({
    /// 観測範囲より津波の高さが超過した場合に使用し、数値情報を補助する.
    /// const: true.
    @JsonKey(name: 'is_over')
    required bool isOver,

    /// 数値情報に付加的情報が必要な場合に出現.
    /// const: true.
    @JsonKey(name: 'is_rising')
    required bool isRising,

    /// 欠測によりデータが現在取得できていない場合に出現する.
    /// const: true.
    @JsonKey(name: 'is_missing')
    required bool isMissing,

    /// 津波の最大波を観測した日時
    @JsonKey(includeIfNull: false,name: 'observed_at')
    DateTime? observedAt,
    @JsonKey(includeIfNull: false)
    num? value,
    @JsonKey(includeIfNull: false)
    ObservationMaxHeightCondition? condition,
    @JsonKey(includeIfNull: false)
    Revise? revise,
  }) = _TsunamiStationObservationMaxHeight;
  
  factory TsunamiStationObservationMaxHeight.fromJson(Map<String, Object?> json) => _$TsunamiStationObservationMaxHeightFromJson(json);
}
