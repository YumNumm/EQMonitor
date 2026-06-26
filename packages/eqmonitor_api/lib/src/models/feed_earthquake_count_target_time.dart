// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'feed_earthquake_count_target_time.freezed.dart';
part 'feed_earthquake_count_target_time.g.dart';

@Freezed()
abstract class FeedEarthquakeCountTargetTime with _$FeedEarthquakeCountTargetTime {
  const factory FeedEarthquakeCountTargetTime({
    required String start,
    required String end,
  }) = _FeedEarthquakeCountTargetTime;
  
  factory FeedEarthquakeCountTargetTime.fromJson(Map<String, Object?> json) => _$FeedEarthquakeCountTargetTimeFromJson(json);
}
