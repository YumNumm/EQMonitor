// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'earthquake_partial.dart';
import 'jma_intensity.dart';

part 'highest_intensity_item.freezed.dart';
part 'highest_intensity_item.g.dart';

@Freezed()
abstract class HighestIntensityItem with _$HighestIntensityItem {
  const factory HighestIntensityItem({
    /// 地域コード（気象庁防災情報XMLフォーマット コード表）
    required String code,

    /// 地域名
    required String name,
    required JmaIntensity intensity,

    /// 同震度を観測した地震の件数
    required int count,
    required EarthquakePartial earthquake,
  }) = _HighestIntensityItem;
  
  factory HighestIntensityItem.fromJson(Map<String, Object?> json) => _$HighestIntensityItemFromJson(json);
}
