// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'qualitative_height.dart';

part 'tsunami_forecast_max_height.freezed.dart';
part 'tsunami_forecast_max_height.g.dart';

@Freezed()
abstract class TsunamiForecastMaxHeight with _$TsunamiForecastMaxHeight {
  const factory TsunamiForecastMaxHeight({
    @JsonKey(includeIfNull: false) num? value,
    @JsonKey(includeIfNull: false) bool? over,
    @JsonKey(includeIfNull: false) QualitativeHeight? qualitative,
    @JsonKey(includeIfNull: false, name: 'is_important') bool? isImportant,
  }) = _TsunamiForecastMaxHeight;

  factory TsunamiForecastMaxHeight.fromJson(Map<String, Object?> json) =>
      _$TsunamiForecastMaxHeightFromJson(json);
}
