// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'telegram.dart';
import 'telegram_comments.dart';

part 'earthquake_telegram.freezed.dart';
part 'earthquake_telegram.g.dart';

@Freezed()
abstract class EarthquakeTelegram with _$EarthquakeTelegram {
  const factory EarthquakeTelegram({
    required Telegram telegram,
    @JsonKey(includeIfNull: true)
    required TelegramComments? comments,
  }) = _EarthquakeTelegram;
  
  factory EarthquakeTelegram.fromJson(Map<String, Object?> json) => _$EarthquakeTelegramFromJson(json);
}
