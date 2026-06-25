// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'earthquake_explanation_telegram_body.freezed.dart';
part 'earthquake_explanation_telegram_body.g.dart';

@Freezed()
abstract class EarthquakeExplanationTelegramBody with _$EarthquakeExplanationTelegramBody {
  const factory EarthquakeExplanationTelegramBody({
    required String type,
    required String text,
  }) = _EarthquakeExplanationTelegramBody;
  
  factory EarthquakeExplanationTelegramBody.fromJson(Map<String, Object?> json) => _$EarthquakeExplanationTelegramBodyFromJson(json);
}
