// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

import 'comments.dart';
import 'comments2.dart';
import 'earthquake_counts.dart';
import 'earthquake_info.dart';
import 'naming.dart';

part 'feed_item_data_union.freezed.dart';
part 'feed_item_data_union.g.dart';

@Freezed()
sealed class FeedItemDataUnion with _$FeedItemDataUnion {
  @JsonSerializable()
  const factory FeedItemDataUnion.variant1({
    required dynamic type,
    required String text,
  }) = FeedItemDataUnionVariant1;
  
  @JsonSerializable()
  const factory FeedItemDataUnion.variant2({
    required dynamic type,
    required dynamic infoType,
    required String text,
    @JsonKey(includeIfNull: false)
    Naming? naming,
    @JsonKey(includeIfNull: false)
    Comments? comments,
  }) = FeedItemDataUnionVariant2;
  
  @JsonSerializable()
  const factory FeedItemDataUnion.variant3({
    required dynamic type,
    required dynamic infoType,
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
    required dynamic type,
    required dynamic infoType,
    required dynamic telegramType,
    @JsonKey(includeIfNull: false)
    EarthquakeInfo? earthquakeInfo,
    @JsonKey(includeIfNull: false)
    String? nextAdvisory,
    @JsonKey(includeIfNull: false)
    String? text,
  }) = FeedItemDataUnionVariant4;
  
  @JsonSerializable()
  const factory FeedItemDataUnion.variant5({
    required dynamic type,
    @JsonKey(includeIfNull: false)
    String? version,
    @JsonKey(includeIfNull: false)
    String? url,
  }) = FeedItemDataUnionVariant5;
  
  @JsonSerializable()
  const factory FeedItemDataUnion.variant6({
    required dynamic type,
    @JsonKey(includeIfNull: false)
    String? url,
  }) = FeedItemDataUnionVariant6;
  
  @JsonSerializable()
  const factory FeedItemDataUnion.variant7({
    required dynamic type,
    @JsonKey(includeIfNull: false)
    String? url,
  }) = FeedItemDataUnionVariant7;
  

  factory FeedItemDataUnion.fromJson(Map<String, Object?> json) =>
      switch (json['type']) {
        'EARTHQUAKE_NOTICE' => FeedItemDataUnionVariant1.fromJson(json),
        'EARTHQUAKE_EXPLANATION' => FeedItemDataUnionVariant2.fromJson(json),
        'EARTHQUAKE_COUNTS' => FeedItemDataUnionVariant3.fromJson(json),
        'EARTHQUAKE_NANKAI' => FeedItemDataUnionVariant4.fromJson(json),
        'APP_UPDATE' => FeedItemDataUnionVariant5.fromJson(json),
        'INCIDENT' => FeedItemDataUnionVariant6.fromJson(json),
        'DEVELOPER_MESSAGE' => FeedItemDataUnionVariant7.fromJson(json),
        final value => throw ArgumentError.value(
          value,
          'type',
          'Unknown FeedItemDataUnion type',
        ),
      };

}
