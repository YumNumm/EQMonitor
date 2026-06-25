// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'eew_telegram_body_accuracy.dart';
import 'info_type.dart';
import 'jma_intensity.dart';
import 'jma_lpgm_intensity.dart';
import 'telegram_status.dart';
import 'telegram_type.dart';

part 'eew_telegram_body_eew.freezed.dart';
part 'eew_telegram_body_eew.g.dart';

@Freezed()
abstract class EewTelegramBodyEew with _$EewTelegramBodyEew {
  const factory EewTelegramBodyEew({
    required String eventId,
    required TelegramType type,
    required TelegramStatus status,
    required InfoType infoType,
    required num serialNo,
    required bool isCanceled,
    required bool isLastInfo,
    required bool isPlum,
    @JsonKey(includeIfNull: false)
    String? headline,
    @JsonKey(includeIfNull: false)
    bool? isWarning,
    @JsonKey(includeIfNull: false)
    String? originTime,
    @JsonKey(includeIfNull: false)
    String? arrivalTime,
    @JsonKey(includeIfNull: false)
    num? hypocenterCode,
    @JsonKey(includeIfNull: false)
    String? hypocenterName,
    @JsonKey(includeIfNull: false)
    num? hypocenterReduceCode,
    @JsonKey(includeIfNull: false)
    String? hypocenterReduceName,
    @JsonKey(includeIfNull: false)
    num? depth,
    @JsonKey(includeIfNull: false)
    String? latitude,
    @JsonKey(includeIfNull: false)
    String? longitude,
    @JsonKey(includeIfNull: false)
    String? magnitude,
    @JsonKey(includeIfNull: false)
    JmaIntensity? forecastMaxIntensity,
    @JsonKey(includeIfNull: false)
    JmaLpgmIntensity? forecastMaxLpgmIntensity,
    @JsonKey(includeIfNull: false)
    bool? forecastMaxIntensityIsOver,
    @JsonKey(includeIfNull: false)
    bool? forecastMaxLpgmIntensityIsOver,
    @JsonKey(includeIfNull: false)
    EewTelegramBodyAccuracy? accuracy,
    @JsonKey(includeIfNull: false)
    String? editorialOffice,
    @JsonKey(includeIfNull: false)
    String? reportTime,
  }) = _EewTelegramBodyEew;
  
  factory EewTelegramBodyEew.fromJson(Map<String, Object?> json) => _$EewTelegramBodyEewFromJson(json);
}
