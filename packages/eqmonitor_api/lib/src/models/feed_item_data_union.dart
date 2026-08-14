// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

import 'feed_comments.dart';
import 'feed_earthquake_count.dart';
import 'feed_naming.dart';
import 'feed_nankai_earthquake_info.dart';
import 'info_type.dart';
import 'nankai_telegram_code.dart';
import 'nankai_telegram_type.dart';

part 'feed_item_data_union.freezed.dart';
part 'feed_item_data_union.g.dart';

@Freezed()
sealed class FeedItemDataUnion with _$FeedItemDataUnion {
  @JsonSerializable()
  const factory FeedItemDataUnion.feedEarthquakeNoticeData({
    /// const: "EARTHQUAKE_NOTICE"
    required String type,
    required String text,
  }) = FeedItemDataUnionFeedEarthquakeNoticeData;
  
  @JsonSerializable()
  const factory FeedItemDataUnion.feedEarthquakeExplanationData({
    /// const: "EARTHQUAKE_EXPLANATION"
    required String type,
    required InfoType infoType,
    required String text,
    @JsonKey(includeIfNull: false)
    FeedNaming? naming,
    @JsonKey(includeIfNull: false)
    FeedComments? comments,
  }) = FeedItemDataUnionFeedEarthquakeExplanationData;
  
  @JsonSerializable()
  const factory FeedItemDataUnion.feedEarthquakeCountsData({
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
  }) = FeedItemDataUnionFeedEarthquakeCountsData;
  
  @JsonSerializable()
  const factory FeedItemDataUnion.feedEarthquakeNankaiData({
    /// const: "EARTHQUAKE_NANKAI"
    required String type,
    required InfoType infoType,
    required NankaiTelegramType telegramType,
    @JsonKey(includeIfNull: false)
    NankaiTelegramCode? telegramCode,
    @JsonKey(includeIfNull: false)
    FeedNankaiEarthquakeInfo? earthquakeInfo,
    @JsonKey(includeIfNull: false)
    String? nextAdvisory,
    @JsonKey(includeIfNull: false)
    String? text,
  }) = FeedItemDataUnionFeedEarthquakeNankaiData;
  
  @JsonSerializable()
  const factory FeedItemDataUnion.feedAppUpdateData({
    /// const: "APP_UPDATE"
    required String type,
    @JsonKey(includeIfNull: false)
    String? version,
    @JsonKey(includeIfNull: false)
    String? url,
  }) = FeedItemDataUnionFeedAppUpdateData;
  
  @JsonSerializable()
  const factory FeedItemDataUnion.feedIncidentData({
    /// const: "INCIDENT"
    required String type,
    @JsonKey(includeIfNull: false)
    String? url,
  }) = FeedItemDataUnionFeedIncidentData;
  
  @JsonSerializable()
  const factory FeedItemDataUnion.feedDeveloperMessageData({
    /// const: "DEVELOPER_MESSAGE"
    required String type,
    @JsonKey(includeIfNull: false)
    String? url,
  }) = FeedItemDataUnionFeedDeveloperMessageData;
  

  factory FeedItemDataUnion.fromJson(Map<String, Object?> json) =>
      switch (json['type']) {
        'EARTHQUAKE_NOTICE' =>
          FeedItemDataUnionFeedEarthquakeNoticeData.fromJson(json),
        'EARTHQUAKE_EXPLANATION' =>
          FeedItemDataUnionFeedEarthquakeExplanationData.fromJson(json),
        'EARTHQUAKE_COUNTS' =>
          FeedItemDataUnionFeedEarthquakeCountsData.fromJson(json),
        'EARTHQUAKE_NANKAI' =>
          FeedItemDataUnionFeedEarthquakeNankaiData.fromJson(json),
        'APP_UPDATE' =>
          FeedItemDataUnionFeedAppUpdateData.fromJson(json),
        'INCIDENT' =>
          FeedItemDataUnionFeedIncidentData.fromJson(json),
        'DEVELOPER_MESSAGE' =>
          FeedItemDataUnionFeedDeveloperMessageData.fromJson(json),
        final value => throw ArgumentError.value(
          value,
          'type',
          'Unknown FeedItemDataUnion type',
        ),
      };

}
