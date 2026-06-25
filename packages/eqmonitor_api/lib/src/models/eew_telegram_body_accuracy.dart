// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'eew_telegram_body_accuracy.freezed.dart';
part 'eew_telegram_body_accuracy.g.dart';

@Freezed()
abstract class EewTelegramBodyAccuracy with _$EewTelegramBodyAccuracy {
  const factory EewTelegramBodyAccuracy({
    required List<num> epicenters,
    required num depth,
    required num magnitudeCalculation,
    required num numberOfMagnitudeCalculation,
  }) = _EewTelegramBodyAccuracy;
  
  factory EewTelegramBodyAccuracy.fromJson(Map<String, Object?> json) => _$EewTelegramBodyAccuracyFromJson(json);
}
