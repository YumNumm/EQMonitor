// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'earthquake_partial.dart';
import 'jma_intensity.dart';

part 'intensity_prefecture_search_item.freezed.dart';
part 'intensity_prefecture_search_item.g.dart';

@Freezed()
abstract class IntensityPrefectureSearchItem with _$IntensityPrefectureSearchItem {
  const factory IntensityPrefectureSearchItem({
    required JmaIntensity intensity,
    required EarthquakePartial earthquake,
  }) = _IntensityPrefectureSearchItem;
  
  factory IntensityPrefectureSearchItem.fromJson(Map<String, Object?> json) => _$IntensityPrefectureSearchItemFromJson(json);
}
