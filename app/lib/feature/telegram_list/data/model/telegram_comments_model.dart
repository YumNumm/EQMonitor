import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'telegram_comments_model.freezed.dart';

/// 電文コメント（固定付加文・自由付加文など）のドメインモデル
@freezed
abstract class TelegramCommentsModel with _$TelegramCommentsModel {
  const factory({
    String? text,
    String? free,
    String? warning,
    String? forecast,
    String? additional,
    String? uri,
  }) = _TelegramCommentsModel;
}

extension TelegramCommentsApiExtension on api.TelegramComments {
  TelegramCommentsModel toTelegramCommentsModel() => TelegramCommentsModel(
    text: text,
    free: free,
    warning: warning,
    forecast: forecast,
    additional: additional,
    uri: uri,
  );
}
