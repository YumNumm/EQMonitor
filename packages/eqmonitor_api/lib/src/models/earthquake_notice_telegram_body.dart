// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'earthquake_notice_telegram_body.freezed.dart';
part 'earthquake_notice_telegram_body.g.dart';

@Freezed()
abstract class EarthquakeNoticeTelegramBody with _$EarthquakeNoticeTelegramBody {
  const factory EarthquakeNoticeTelegramBody({
    /// const: "EARTHQUAKE_NOTICE"
    required String type,
  }) = _EarthquakeNoticeTelegramBody;
  
  factory EarthquakeNoticeTelegramBody.fromJson(Map<String, Object?> json) => _$EarthquakeNoticeTelegramBodyFromJson(json);
}
