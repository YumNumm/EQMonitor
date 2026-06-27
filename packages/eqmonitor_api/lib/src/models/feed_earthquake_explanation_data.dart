// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'feed_comments.dart';
import 'feed_naming.dart';
import 'info_type.dart';

part 'feed_earthquake_explanation_data.freezed.dart';
part 'feed_earthquake_explanation_data.g.dart';

@Freezed()
abstract class FeedEarthquakeExplanationData with _$FeedEarthquakeExplanationData {
  const factory FeedEarthquakeExplanationData({
    /// const: "EARTHQUAKE_EXPLANATION"
    required String type,
    required InfoType infoType,
    required String text,
    @JsonKey(includeIfNull: false)
    FeedNaming? naming,
    @JsonKey(includeIfNull: false)
    FeedComments? comments,
  }) = _FeedEarthquakeExplanationData;
  
  factory FeedEarthquakeExplanationData.fromJson(Map<String, Object?> json) => _$FeedEarthquakeExplanationDataFromJson(json);
}
