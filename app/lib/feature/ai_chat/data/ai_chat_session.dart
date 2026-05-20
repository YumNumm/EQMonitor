import 'dart:async';

import 'package:eqmonitor/feature/ai_chat/data/llm/genkit_client.dart';
import 'package:eqmonitor/feature/ai_chat/data/model/chat_turn.dart';
import 'package:eqmonitor/feature/ai_chat/data/model/token_usage.dart';
import 'package:flutter/foundation.dart';
import 'package:genkit/genkit.dart' as gk;
import 'package:genui/genui.dart';

/// AI チャット 1 セッション分の状態をまとめて保持する。
///
/// GenUI の [Conversation] / [SurfaceController] / [A2uiTransportAdapter] を
/// Genkit の `generateStream` と接続して、ユーザー入力 → LLM → A2UI 命令 → サーフェス描画
/// の一連を駆動する。
class AiChatSession with ChangeNotifier {
  AiChatSession({
    required this.client,
    required Catalog catalog,
    String? initialMessage,
    String? extraSystemPrompt,
  }) : _catalog = catalog {
    _surfaceController = SurfaceController(catalogs: [_catalog]);
    _promptBuilder = PromptBuilder.chat(
      catalog: _catalog,
      systemPromptFragments: [
        ?extraSystemPrompt,
        ..._defaultSystemPromptFragments,
      ],
    );
    _adapter = A2uiTransportAdapter(onSend: _onSendToLlm);
    _conversation = Conversation(
      controller: _surfaceController,
      transport: _adapter,
    );
    _eventSub = _conversation.events.listen(_handleConversationEvent);
    _conversation.state.addListener(_handleStateChange);

    if (initialMessage != null && initialMessage.isNotEmpty) {
      // 自動送信は呼び出し側に任せる: 初期メッセージはターン履歴にだけ追加。
      _turns.value = [..._turns.value, ChatTurn.user(initialMessage)];
    }
  }

  final GenkitClient client;
  final Catalog _catalog;

  late final SurfaceController _surfaceController;
  late final A2uiTransportAdapter _adapter;
  late final Conversation _conversation;
  late final PromptBuilder _promptBuilder;
  StreamSubscription<ConversationEvent>? _eventSub;

  final List<gk.Message> _llmHistory = [];

  final ValueNotifier<List<ChatTurn>> _turns = ValueNotifier(const []);
  final ValueNotifier<TokenUsage> _usage = ValueNotifier(const TokenUsage());
  final ValueNotifier<bool> _isWaiting = ValueNotifier(false);
  final ValueNotifier<String?> _lastError = ValueNotifier(null);

  ValueListenable<List<ChatTurn>> get turns => _turns;
  ValueListenable<TokenUsage> get usage => _usage;
  ValueListenable<bool> get isWaiting => _isWaiting;
  ValueListenable<String?> get lastError => _lastError;

  SurfaceController get surfaceController => _surfaceController;

  /// テキストを送信する。
  Future<void> sendText(String text) async {
    final trimmed = text.trim();
    if (trimmed.isEmpty) {
      return;
    }
    _turns.value = [..._turns.value, ChatTurn.user(trimmed)];
    _lastError.value = null;
    await _conversation.sendRequest(ChatMessage.user(trimmed));
  }

  Future<void> _onSendToLlm(ChatMessage userMessage) async {
    // GenUI ChatMessage から最新ユーザ発話のテキストを抽出。
    final text = _extractText(userMessage);
    if (text.isEmpty) {
      return;
    }
    _llmHistory.add(
      gk.Message(
        role: gk.Role.user,
        content: [gk.TextPart(text: text)],
      ),
    );

    final systemPrompt = _promptBuilder.systemPromptJoined();
    final messages = <gk.Message>[
      gk.Message(
        role: gk.Role.system,
        content: [gk.TextPart(text: systemPrompt)],
      ),
      ..._llmHistory,
    ];

    try {
      final stream = client.genkit.generateStream<Object?, void>(
        model: client.model,
        messages: messages,
        toolNames: client.toolNames,
        maxTurns: 8,
      );

      await for (final chunk in stream) {
        final chunkText = chunk.text;
        if (chunkText.isNotEmpty) {
          _adapter.addChunk(chunkText);
        }
      }
      await _adapter.flush();
      final response = await stream.onResult;
      final assistantText = response.text;
      if (assistantText.isNotEmpty) {
        _llmHistory.add(
          gk.Message(
            role: gk.Role.model,
            content: [gk.TextPart(text: assistantText)],
          ),
        );
        // A2UI コマンドだけだったケース以外はテキストもチャット欄に残す。
        if (!_looksLikeOnlyA2ui(assistantText)) {
          _turns.value = [
            ..._turns.value,
            ChatTurn.assistantText(_stripA2uiBlocks(assistantText)),
          ];
        }
      }
      _updateUsage(response.usage);
    } on Exception catch (e) {
      _lastError.value = e.toString();
      _turns.value = [..._turns.value, ChatTurn.error(e.toString())];
      rethrow;
    }
  }

  void _handleConversationEvent(ConversationEvent event) {
    switch (event) {
      case ConversationSurfaceAdded(:final surfaceId):
        _turns.value = [
          ..._turns.value,
          ChatTurn.assistantSurface(surfaceId),
        ];
      case ConversationError(:final error):
        _lastError.value = error.toString();
        _turns.value = [
          ..._turns.value,
          ChatTurn.error(error.toString()),
        ];
      case ConversationContentReceived():
      case ConversationWaiting():
      case ConversationComponentsUpdated():
      case ConversationSurfaceRemoved():
        // 必要に応じて UI 更新ロジックを追加する余地。
        break;
    }
  }

  void _handleStateChange() {
    _isWaiting.value = _conversation.state.value.isWaiting;
  }

  void _updateUsage(gk.GenerationUsage? usage) {
    if (usage == null) {
      return;
    }
    _usage.value = _usage.value.add(
      input: usage.inputTokens?.toInt(),
      output: usage.outputTokens?.toInt(),
      total: usage.totalTokens?.toInt(),
    );
  }

  String _extractText(ChatMessage msg) =>
      msg.parts.whereType<TextPart>().map((p) => p.text).join();

  /// 応答テキストが A2UI JSON ブロックのみで構成されているか。
  bool _looksLikeOnlyA2ui(String text) {
    final stripped = _stripA2uiBlocks(text).trim();
    return stripped.isEmpty;
  }

  String _stripA2uiBlocks(String text) {
    // ```json ... ``` のフェンスを除去（PromptBuilder は a2ui を fenced JSON で出させる）
    return text.replaceAll(
      RegExp(r'```(?:json|a2ui)?\s*\{[\s\S]*?\}\s*```', multiLine: true),
      '',
    );
  }

  @override
  void dispose() {
    unawaited(_eventSub?.cancel());
    _conversation.state.removeListener(_handleStateChange);
    _conversation.dispose();
    _adapter.dispose();
    _turns.dispose();
    _usage.dispose();
    _isWaiting.dispose();
    _lastError.dispose();
    super.dispose();
  }

  static const _defaultSystemPromptFragments = <String>[
    'あなたは日本の地震モニタリングアプリ EQMonitor のアシスタントです。',
    'ユーザの自然言語の問い合わせに応じて、提供されたツール (search_earthquakes / get_earthquake_detail / search_by_epicenter) を用いて地震情報を取得し、結果は A2UI の createSurface + updateComponents を用いて、Card / Column / Text 等で読みやすく整形して提示してください。',
    '地震の詳細を提示するとき、hypocenter.code がある場合は「同じ震央の過去地震を見る」誘導文を Text として添えてください。',
    'ツールの結果に originTime が含まれる場合は、JST にフォーマットして読みやすく表示してください。',
    'マグニチュード・震度・震源名 (hypocenter.name) は強調されるように表示してください。',
  ];
}
