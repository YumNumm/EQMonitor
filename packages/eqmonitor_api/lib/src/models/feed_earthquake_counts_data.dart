// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'feed_comments.dart';
import 'feed_earthquake_count.dart';
import 'info_type.dart';

part 'feed_earthquake_counts_data.freezed.dart';
part 'feed_earthquake_counts_data.g.dart';

@Freezed()
abstract class FeedEarthquakeCountsData with _$FeedEarthquakeCountsData {
  const factory FeedEarthquakeCountsData({
    /// const: "EARTHQUAKE_COUNTS"
    required String type,
    required InfoType infoType,
    @JsonKey(includeIfNull: false)
    List<FeedEarthquakeCount>? earthquakeCounts,
    @JsonKey(includeIfNull: false)
    String? nextAdvisory,
    @JsonKey(includeIfNull: false)
    String? text,
    @JsonKey(includeIfNull: false)
    FeedComments? comments,
  }) = _FeedEarthquakeCountsData;
  
  factory FeedEarthquakeCountsData.fromJson(Map<String, Object?> json) => _$FeedEarthquakeCountsDataFromJson(json);
}
