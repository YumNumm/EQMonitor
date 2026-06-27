// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'eew_telegram_body.freezed.dart';
part 'eew_telegram_body.g.dart';

@Freezed()
abstract class EewTelegramBody with _$EewTelegramBody {
  const factory EewTelegramBody({
    /// const: "EEW"
    required String type,
    required Object? eew,
    required List<Object?> eewIntensityRegions,
    required List<Object?> eewWarningZones,
    required List<Object?> eewWarningPrefectures,
    required List<Object?> eewWarningRegions,
  }) = _EewTelegramBody;
  
  factory EewTelegramBody.fromJson(Map<String, Object?> json) => _$EewTelegramBodyFromJson(json);
}
