// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'qualitative_height.dart';
import 'revise.dart';

part 'tsunami_region_forecast_max_height.freezed.dart';
part 'tsunami_region_forecast_max_height.g.dart';

@Freezed()
abstract class TsunamiRegionForecastMaxHeight with _$TsunamiRegionForecastMaxHeight {
  const factory TsunamiRegionForecastMaxHeight({
    /// 津波の予想される高さ 定性的表現をする場合は出現しない
    @JsonKey(includeIfNull: false)
    num? value,

    /// 10m超となるときに出現 数値情報より大きいことを示す場合に出現
    @JsonKey(includeIfNull: false,name: 'is_over')
    bool? isOver,
    @JsonKey(includeIfNull: false)
    QualitativeHeight? qualitative,
    @JsonKey(includeIfNull: false,name: 'is_important')
    bool? isImportant,
    @JsonKey(includeIfNull: false)
    Revise? revise,
  }) = _TsunamiRegionForecastMaxHeight;
  
  factory TsunamiRegionForecastMaxHeight.fromJson(Map<String, Object?> json) => _$TsunamiRegionForecastMaxHeightFromJson(json);
}
