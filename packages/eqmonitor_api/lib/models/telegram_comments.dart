// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'telegram_comments.freezed.dart';
part 'telegram_comments.g.dart';

@Freezed()
abstract class TelegramComments with _$TelegramComments {
  const factory TelegramComments({
    required String text,
    required String free,
    required String warning,
    required String forecast,

    /// The name has been replaced because it contains a keyword. Original name: `var`.
    @JsonKey(name: 'var') required String varValue,
    required String uri,
  }) = _TelegramComments;

  factory TelegramComments.fromJson(Map<String, Object?> json) =>
      _$TelegramCommentsFromJson(json);
}
