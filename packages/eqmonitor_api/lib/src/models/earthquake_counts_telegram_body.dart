// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'earthquake_counts_telegram_body.freezed.dart';
part 'earthquake_counts_telegram_body.g.dart';

@Freezed()
abstract class EarthquakeCountsTelegramBody with _$EarthquakeCountsTelegramBody {
  const factory EarthquakeCountsTelegramBody({
    required dynamic type,
  }) = _EarthquakeCountsTelegramBody;
  
  factory EarthquakeCountsTelegramBody.fromJson(Map<String, Object?> json) => _$EarthquakeCountsTelegramBodyFromJson(json);
}
