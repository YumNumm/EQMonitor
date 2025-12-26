import 'package:freezed_annotation/freezed_annotation.dart';

part 'telegram_comments.freezed.dart';
part 'telegram_comments.g.dart';

/// 電文のコメント情報
@freezed
abstract class TelegramComments with _$TelegramComments {
  const factory TelegramComments({
    String? text,
    String? free,
    String? warning,
    String? forecast,
    @JsonKey(name: 'var') String? varComment,
    String? uri,
  }) = _TelegramComments;

  factory TelegramComments.fromJson(Map<String, dynamic> json) =>
      _$TelegramCommentsFromJson(json);
}
