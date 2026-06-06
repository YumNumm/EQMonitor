// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'eew_telegram_body.freezed.dart';
part 'eew_telegram_body.g.dart';

@Freezed()
abstract class EewTelegramBody with _$EewTelegramBody {
  const factory EewTelegramBody({
    required dynamic type,
    required dynamic eew,
    @JsonKey(includeIfNull: false)
    dynamic eewIntensityRegions,
    @JsonKey(includeIfNull: false)
    dynamic eewWarningZones,
    @JsonKey(includeIfNull: false)
    dynamic eewWarningPrefectures,
    @JsonKey(includeIfNull: false)
    dynamic eewWarningRegions,
  }) = _EewTelegramBody;
  
  factory EewTelegramBody.fromJson(Map<String, Object?> json) => _$EewTelegramBodyFromJson(json);
}
