// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'telegram_comments.freezed.dart';
part 'telegram_comments.g.dart';

@Freezed()
abstract class TelegramComments with _$TelegramComments {
  const factory TelegramComments({
    @JsonKey(includeIfNull: false) String? text,
    @JsonKey(includeIfNull: false) String? free,
    @JsonKey(includeIfNull: false) String? warning,
    @JsonKey(includeIfNull: false) String? forecast,

    /// 固定付加文, var
    @JsonKey(includeIfNull: false) String? additional,
    @JsonKey(includeIfNull: false) String? uri,
  }) = _TelegramComments;

  factory TelegramComments.fromJson(Map<String, Object?> json) =>
      _$TelegramCommentsFromJson(json);
}
