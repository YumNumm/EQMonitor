// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'fallback_telegram_body.freezed.dart';
part 'fallback_telegram_body.g.dart';

@Freezed()
abstract class FallbackTelegramBody with _$FallbackTelegramBody {
  const factory FallbackTelegramBody({
    required String type,
  }) = _FallbackTelegramBody;
  
  factory FallbackTelegramBody.fromJson(Map<String, Object?> json) => _$FallbackTelegramBodyFromJson(json);
}
