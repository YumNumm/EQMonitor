// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

import 'comments.dart';
import 'comments2.dart';
import 'earthquake_counts.dart';
import 'earthquake_info.dart';
import 'info_type.dart';
import 'naming.dart';
import 'telegram_type.dart';

part 'feed_item_data_union.freezed.dart';
part 'feed_item_data_union.g.dart';

@Freezed()
sealed class FeedItemDataUnion with _$FeedItemDataUnion {
  @JsonSerializable()
  const factory FeedItemDataUnion.variant1({
    /// const: "EARTHQUAKE_NOTICE"
    required String type,
    required String text,
  }) = FeedItemDataUnionVariant1;
  
  @JsonSerializable()
  const factory FeedItemDataUnion.variant2({
    /// const: "EARTHQUAKE_EXPLANATION"
    required String type,

    /// const: "PUBLICATION" | const: "CORRECTION" | const: "CANCELLATION"
    required InfoType infoType,
    required String text,
    @JsonKey(includeIfNull: false)
    Naming? naming,
    @JsonKey(includeIfNull: false)
    Comments? comments,
  }) = FeedItemDataUnionVariant2;
  
  @JsonSerializable()
  const factory FeedItemDataUnion.variant3({
    /// const: "EARTHQUAKE_COUNTS"
    required String type,

    /// const: "PUBLICATION" | const: "CORRECTION" | const: "CANCELLATION"
    required InfoType infoType,
    @JsonKey(includeIfNull: false)
    List<EarthquakeCounts>? earthquakeCounts,
    @JsonKey(includeIfNull: false)
    String? nextAdvisory,
    @JsonKey(includeIfNull: false)
    String? text,
    @JsonKey(includeIfNull: false)
    Comments2? comments,
  }) = FeedItemDataUnionVariant3;
  
  @JsonSerializable()
  const factory FeedItemDataUnion.variant4({
    /// const: "EARTHQUAKE_NANKAI"
    required String type,

    /// const: "PUBLICATION" | const: "CORRECTION" | const: "CANCELLATION"
    required InfoType infoType,

    /// const: "南海トラフ地震臨時情報" | const: "南海トラフ地震関連解説情報" | const: "北海道・三陸沖後発地震注意情報"
    required TelegramType telegramType,
    @JsonKey(includeIfNull: false)
    EarthquakeInfo? earthquakeInfo,
    @JsonKey(includeIfNull: false)
    String? nextAdvisory,
    @JsonKey(includeIfNull: false)
    String? text,
  }) = FeedItemDataUnionVariant4;
  
  @JsonSerializable()
  const factory FeedItemDataUnion.variant5({
    /// const: "APP_UPDATE"
    required String type,
    @JsonKey(includeIfNull: false)
    String? version,
    @JsonKey(includeIfNull: false)
    String? url,
  }) = FeedItemDataUnionVariant5;
  
  @JsonSerializable()
  const factory FeedItemDataUnion.variant6({
    /// const: "INCIDENT"
    required String type,
    @JsonKey(includeIfNull: false)
    String? url,
  }) = FeedItemDataUnionVariant6;
  
  @JsonSerializable()
  const factory FeedItemDataUnion.variant7({
    /// const: "DEVELOPER_MESSAGE"
    required String type,
    @JsonKey(includeIfNull: false)
    String? url,
  }) = FeedItemDataUnionVariant7;
  

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
