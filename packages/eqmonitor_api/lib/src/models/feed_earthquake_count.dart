// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'feed_earthquake_count_target_time.dart';
import 'feed_earthquake_count_values.dart';
import 'type.dart';

part 'feed_earthquake_count.freezed.dart';
part 'feed_earthquake_count.g.dart';

@Freezed()
abstract class FeedEarthquakeCount with _$FeedEarthquakeCount {
  const factory FeedEarthquakeCount({
    /// const: "１時間地震回数" | const: "累積地震回数" | const: "地震回数"
    required Type type,
    required FeedEarthquakeCountTargetTime targetTime,
    required FeedEarthquakeCountValues values,
  }) = _FeedEarthquakeCount;
  
  factory FeedEarthquakeCount.fromJson(Map<String, Object?> json) => _$FeedEarthquakeCountFromJson(json);
}
