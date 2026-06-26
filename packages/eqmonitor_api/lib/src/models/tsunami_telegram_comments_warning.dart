// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'tsunami_telegram_comments_warning.freezed.dart';
part 'tsunami_telegram_comments_warning.g.dart';

@Freezed()
abstract class TsunamiTelegramCommentsWarning with _$TsunamiTelegramCommentsWarning {
  const factory TsunamiTelegramCommentsWarning({
    required String text,
    required List<String> codes,
  }) = _TsunamiTelegramCommentsWarning;
  
  factory TsunamiTelegramCommentsWarning.fromJson(Map<String, Object?> json) => _$TsunamiTelegramCommentsWarningFromJson(json);
}
