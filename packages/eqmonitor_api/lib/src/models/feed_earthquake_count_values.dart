// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'feed_earthquake_count_values.freezed.dart';
part 'feed_earthquake_count_values.g.dart';

@Freezed()
abstract class FeedEarthquakeCountValues with _$FeedEarthquakeCountValues {
  const factory FeedEarthquakeCountValues({
    @JsonKey(includeIfNull: true)
    required String? all,
    @JsonKey(includeIfNull: true)
    required String? felt,
  }) = _FeedEarthquakeCountValues;
  
  factory FeedEarthquakeCountValues.fromJson(Map<String, Object?> json) => _$FeedEarthquakeCountValuesFromJson(json);
}
