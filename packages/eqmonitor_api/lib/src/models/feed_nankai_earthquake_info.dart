// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'feed_nankai_earthquake_info_kind.dart';

part 'feed_nankai_earthquake_info.freezed.dart';
part 'feed_nankai_earthquake_info.g.dart';

@Freezed()
abstract class FeedNankaiEarthquakeInfo with _$FeedNankaiEarthquakeInfo {
  const factory FeedNankaiEarthquakeInfo({
    required String text,
    @JsonKey(includeIfNull: false)
    FeedNankaiEarthquakeInfoKind? kind,
    @JsonKey(includeIfNull: false)
    String? appendix,
  }) = _FeedNankaiEarthquakeInfo;
  
  factory FeedNankaiEarthquakeInfo.fromJson(Map<String, Object?> json) => _$FeedNankaiEarthquakeInfoFromJson(json);
}
