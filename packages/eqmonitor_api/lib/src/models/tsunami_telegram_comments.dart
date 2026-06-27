// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'tsunami_telegram_comments_warning.dart';

part 'tsunami_telegram_comments.freezed.dart';
part 'tsunami_telegram_comments.g.dart';

@Freezed()
abstract class TsunamiTelegramComments with _$TsunamiTelegramComments {
  const factory TsunamiTelegramComments({
    @JsonKey(includeIfNull: false)
    String? free,
    @JsonKey(includeIfNull: false)
    TsunamiTelegramCommentsWarning? warning,
  }) = _TsunamiTelegramComments;
  
  factory TsunamiTelegramComments.fromJson(Map<String, Object?> json) => _$TsunamiTelegramCommentsFromJson(json);
}
