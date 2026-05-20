import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_turn.freezed.dart';

/// チャットの 1 メッセージ単位（UI 表示用）。
@freezed
sealed class ChatTurn with _$ChatTurn {
  /// ユーザー発話。
  const factory ChatTurn.user(String text) = ChatTurnUser;

  /// AI のテキスト応答（A2UI で UI を生成しないチャンクの集約）。
  const factory ChatTurn.assistantText(String text) = ChatTurnAssistantText;

  /// AI が生成した A2UI サーフェスの参照（実体は SurfaceController が保持）。
  const factory ChatTurn.assistantSurface(String surfaceId) =
      ChatTurnAssistantSurface;

  /// LLM 呼び出し中。
  const factory ChatTurn.thinking() = ChatTurnThinking;

  /// エラー。
  const factory ChatTurn.error(String message) = ChatTurnError;
}
