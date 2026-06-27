// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'earthquake_partial.dart';

part 'similar_earthquake_item.freezed.dart';
part 'similar_earthquake_item.g.dart';

@Freezed()
abstract class SimilarEarthquakeItem with _$SimilarEarthquakeItem {
  const factory SimilarEarthquakeItem({
    required EarthquakePartial earthquake,

    /// km相当の距離スコア（小さいほど類似）
    required num score,

    /// グループ内の他の地震（代表を除く）
    @JsonKey(name: 'grouped_earthquakes')
    required List<EarthquakePartial> groupedEarthquakes,
  }) = _SimilarEarthquakeItem;
  
  factory SimilarEarthquakeItem.fromJson(Map<String, Object?> json) => _$SimilarEarthquakeItemFromJson(json);
}
