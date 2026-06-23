// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'telegram.dart';
import 'telegram_comments.dart';

part 'telegrams.freezed.dart';
part 'telegrams.g.dart';

@Freezed()
abstract class Telegrams with _$Telegrams {
  const factory Telegrams({
    required Telegram telegram,
    @JsonKey(includeIfNull: true) required TelegramComments? comments,
  }) = _Telegrams;

  factory Telegrams.fromJson(Map<String, Object?> json) =>
      _$TelegramsFromJson(json);
}
