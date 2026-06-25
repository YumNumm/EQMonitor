// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'eew_telegram_body_warning_area.freezed.dart';
part 'eew_telegram_body_warning_area.g.dart';

@Freezed()
abstract class EewTelegramBodyWarningArea with _$EewTelegramBodyWarningArea {
  const factory EewTelegramBodyWarningArea({
    required String eventId,
    required num serialNo,
    required String code,
    required String name,
    required bool hadWarning,
  }) = _EewTelegramBodyWarningArea;
  
  factory EewTelegramBodyWarningArea.fromJson(Map<String, Object?> json) => _$EewTelegramBodyWarningAreaFromJson(json);
}
