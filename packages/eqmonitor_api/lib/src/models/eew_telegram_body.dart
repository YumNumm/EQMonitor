// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'eew_telegram_body_eew.dart';
import 'eew_telegram_body_intensity_region.dart';
import 'eew_telegram_body_warning_area.dart';

part 'eew_telegram_body.freezed.dart';
part 'eew_telegram_body.g.dart';

@Freezed()
abstract class EewTelegramBody with _$EewTelegramBody {
  const factory EewTelegramBody({
    required String type,
    required EewTelegramBodyEew eew,
    required List<EewTelegramBodyIntensityRegion> eewIntensityRegions,
    required List<EewTelegramBodyWarningArea> eewWarningZones,
    required List<EewTelegramBodyWarningArea> eewWarningPrefectures,
    required List<EewTelegramBodyWarningArea> eewWarningRegions,
  }) = _EewTelegramBody;
  
  factory EewTelegramBody.fromJson(Map<String, Object?> json) => _$EewTelegramBodyFromJson(json);
}
