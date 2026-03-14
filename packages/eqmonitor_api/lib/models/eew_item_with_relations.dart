// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'eew_accuracy.dart';
import 'eew_hypocenter.dart';
import 'eew_intensity.dart';
import 'eew_item_with_relations_info_type.dart';
import 'eew_warning.dart';
import 'telegram_status.dart';
import 'telegram_type.dart';

part 'eew_item_with_relations.freezed.dart';
part 'eew_item_with_relations.g.dart';

@Freezed()
abstract class EewItemWithRelations with _$EewItemWithRelations {
  const factory EewItemWithRelations({
    /// yyyyMMddHHmmss形式のイベントID
    @JsonKey(name: 'event_id')
    required String eventId,
    required TelegramType type,
    required TelegramStatus status,
    @JsonKey(name: 'info_type')
    required EewItemWithRelationsInfoType infoType,
    @JsonKey(name: 'serial_no')
    required num serialNo,
    @JsonKey(includeIfNull: true)
    required String? headline,
    @JsonKey(name: 'is_canceled')
    required bool isCanceled,
    @JsonKey(includeIfNull: true,name: 'is_warning')
    required bool? isWarning,
    @JsonKey(name: 'is_last_info')
    required bool isLastInfo,
    @JsonKey(includeIfNull: true,name: 'origin_time')
    required DateTime? originTime,
    @JsonKey(includeIfNull: true,name: 'arrival_time')
    required DateTime? arrivalTime,
    @JsonKey(includeIfNull: true)
    required EewAccuracy? accuracy,
    @JsonKey(name: 'is_plum')
    required bool isPlum,
    @JsonKey(includeIfNull: true,name: 'editorial_office')
    required String? editorialOffice,
    @JsonKey(name: 'report_time')
    required DateTime reportTime,
    @JsonKey(includeIfNull: false)
    EewHypocenter? hypocenter,
    @JsonKey(includeIfNull: false,name: 'forecast_intensity')
    EewIntensity? forecastIntensity,
    @JsonKey(includeIfNull: false)
    EewWarning? warning,
  }) = _EewItemWithRelations;
  
  factory EewItemWithRelations.fromJson(Map<String, Object?> json) => _$EewItemWithRelationsFromJson(json);
}
