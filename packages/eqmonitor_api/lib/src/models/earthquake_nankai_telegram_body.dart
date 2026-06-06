// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'earthquake_nankai_telegram_body.freezed.dart';
part 'earthquake_nankai_telegram_body.g.dart';

@Freezed()
abstract class EarthquakeNankaiTelegramBody with _$EarthquakeNankaiTelegramBody {
  const factory EarthquakeNankaiTelegramBody({
    required dynamic type,
  }) = _EarthquakeNankaiTelegramBody;
  
  factory EarthquakeNankaiTelegramBody.fromJson(Map<String, Object?> json) => _$EarthquakeNankaiTelegramBodyFromJson(json);
}
