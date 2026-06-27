// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'telegram_body_pre_period.freezed.dart';
part 'telegram_body_pre_period.g.dart';

@Freezed()
abstract class TelegramBodyPrePeriod with _$TelegramBodyPrePeriod {
  const factory TelegramBodyPrePeriod({
    required num band,
    @JsonKey(includeIfNull: false,name: 'lpgm_intensity')
    String? lpgmIntensity,
    @JsonKey(includeIfNull: false)
    num? sva,
  }) = _TelegramBodyPrePeriod;
  
  factory TelegramBodyPrePeriod.fromJson(Map<String, Object?> json) => _$TelegramBodyPrePeriodFromJson(json);
}
