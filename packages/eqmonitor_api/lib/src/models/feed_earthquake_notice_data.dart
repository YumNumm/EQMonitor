// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'feed_earthquake_notice_data.freezed.dart';
part 'feed_earthquake_notice_data.g.dart';

@Freezed()
abstract class FeedEarthquakeNoticeData with _$FeedEarthquakeNoticeData {
  const factory FeedEarthquakeNoticeData({
    /// const: "EARTHQUAKE_NOTICE"
    required String type,
    required String text,
  }) = _FeedEarthquakeNoticeData;
  
  factory FeedEarthquakeNoticeData.fromJson(Map<String, Object?> json) => _$FeedEarthquakeNoticeDataFromJson(json);
}
