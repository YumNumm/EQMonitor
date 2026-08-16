// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'feed_nankai_earthquake_info.dart';
import 'info_type.dart';
import 'nankai_telegram_code.dart';
import 'nankai_telegram_type.dart';

part 'feed_earthquake_nankai_data.freezed.dart';
part 'feed_earthquake_nankai_data.g.dart';

@Freezed()
abstract class FeedEarthquakeNankaiData with _$FeedEarthquakeNankaiData {
  const factory FeedEarthquakeNankaiData({
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
  }) = _FeedEarthquakeNankaiData;
  
  factory FeedEarthquakeNankaiData.fromJson(Map<String, Object?> json) => _$FeedEarthquakeNankaiDataFromJson(json);
}
