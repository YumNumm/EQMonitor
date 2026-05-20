import 'dart:async';

import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/ai_chat/data/ai_chat_session.dart';
import 'package:eqmonitor/feature/ai_chat/data/model/chat_turn.dart';
import 'package:eqmonitor/feature/ai_chat/data/provider/ai_chat_session_provider.dart';
import 'package:eqmonitor/feature/ai_chat/data/provider/ai_credentials_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:genui/genui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AiChatPage extends HookConsumerWidget {
  const AiChatPage({super.key, this.eventId, this.epicenterName});

  /// 地震詳細から飛んできた場合の eventId（あれば最初のヒントに使う）
  final String? eventId;
  final String? epicenterName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final storeAsync = ref.watch(aiCredentialsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('AI チャット (実験)'),
        actions: [
          IconButton(
            tooltip: '設定',
            icon: const Icon(Icons.settings),
            onPressed: () => const AiChatSettingsRoute().push<void>(context),
          ),
        ],
      ),
      body: storeAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('エラー: $e')),
        data: (store) {
          if (!store.hasUsableCredentials) {
            return _NoCredentialsView();
          }
          return _ChatBody(
            eventId: eventId,
            epicenterName: epicenterName,
          );
        },
      ),
    );
  }
}

class _NoCredentialsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.key_off, size: 48),
            const SizedBox(height: 12),
            const Text('AI API キーが未設定です'),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: () => const AiChatSettingsRoute().push<void>(context),
              child: const Text('設定画面を開く'),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChatBody extends HookConsumerWidget {
  const _ChatBody({this.eventId, this.epicenterName});

  final String? eventId;
  final String? epicenterName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final extraSystemPrompt = useMemoized(() {
      if (eventId == null) {
        return null;
      }
      final hint = epicenterName == null ? '' : ' (震央: $epicenterName)';
      return '初期の関心対象は eventId="$eventId"$hint。 まず get_earthquake_detail でこの地震の詳細を取得し、 続いて search_by_epicenter で同じ震央の過去地震を提示してください。';
    }, [eventId, epicenterName]);

    final sessionAsync = ref.watch(
      aiChatSessionProvider(
        initialMessage: eventId == null
            ? null
            : 'この地震 (eventId=$eventId) について教えて。 同じ震央付近で過去に起きた地震もあわせて教えてください。',
        extraSystemPrompt: extraSystemPrompt,
      ),
    );

    return sessionAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('セッションエラー: $e')),
      data: (session) => _ChatWithSession(session: session),
    );
  }
}

class _ChatWithSession extends HookConsumerWidget {
  const _ChatWithSession({required this.session});

  final AiChatSession session;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inputCtrl = useTextEditingController();
    final scrollCtrl = useScrollController();
    final turns = useValueListenable(session.turns);
    final isWaiting = useValueListenable(session.isWaiting);

    // 初期メッセージが既に追加されている場合は最初に送信
    useEffect(() {
      final hasInitialUser = turns.isNotEmpty && turns.first is ChatTurnUser;
      if (hasInitialUser && session.turns.value.length == 1) {
        final first = turns.first as ChatTurnUser;
        unawaited(Future.microtask(() => session.sendText(first.text)));
      }
      return null;
    }, const []);

    // 新しいターン追加時に末尾までスクロール
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (scrollCtrl.hasClients) {
          unawaited(
            scrollCtrl.animateTo(
              scrollCtrl.position.maxScrollExtent,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
            ),
          );
        }
      });
      return null;
    }, [turns.length]);

    void send() {
      final text = inputCtrl.text.trim();
      if (text.isEmpty || isWaiting) {
        return;
      }
      inputCtrl.clear();
      unawaited(session.sendText(text));
    }

    return Column(
      children: [
        _UsageBar(session: session),
        Expanded(
          child: ListView.builder(
            controller: scrollCtrl,
            padding: const EdgeInsets.all(12),
            itemCount: turns.length + (isWaiting ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == turns.length && isWaiting) {
                return const _ThinkingBubble();
              }
              return _TurnView(
                turn: turns[index],
                session: session,
              );
            },
          ),
        ),
        const Divider(height: 1),
        SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: inputCtrl,
                    minLines: 1,
                    maxLines: 4,
                    enabled: !isWaiting,
                    decoration: InputDecoration(
                      hintText: isWaiting ? 'AI 応答待ち...' : 'メッセージを入力',
                      border: const OutlineInputBorder(),
                      isDense: true,
                    ),
                    textInputAction: TextInputAction.send,
                    onSubmitted: (_) => send(),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton.filled(
                  onPressed: isWaiting ? null : send,
                  icon: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _UsageBar extends HookWidget {
  const _UsageBar({required this.session});

  final AiChatSession session;

  @override
  Widget build(BuildContext context) {
    final usage = useValueListenable(session.usage);
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      color: theme.colorScheme.surfaceContainerHighest,
      child: DefaultTextStyle.merge(
        style: theme.textTheme.labelSmall,
        child: Row(
          children: [
            const Icon(Icons.bolt, size: 14),
            const SizedBox(width: 4),
            Text(
              'in ${_fmt(usage.inputTokens)} / out ${_fmt(usage.outputTokens)}'
              ' / total ${_fmt(usage.totalTokens)} tokens'
              ' (turns: ${usage.turns})',
            ),
          ],
        ),
      ),
    );
  }

  String _fmt(int v) => v.toString().replaceAllMapped(
    RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
    (m) => '${m[1]},',
  );
}

class _TurnView extends StatelessWidget {
  const _TurnView({required this.turn, required this.session});

  final ChatTurn turn;
  final AiChatSession session;

  @override
  Widget build(BuildContext context) {
    return switch (turn) {
      ChatTurnUser(:final text) => _Bubble(text: text, isUser: true),
      ChatTurnAssistantText(:final text) => _Bubble(text: text, isUser: false),
      ChatTurnAssistantSurface(:final surfaceId) => _SurfaceView(
        session: session,
        surfaceId: surfaceId,
      ),
      ChatTurnThinking() => const _ThinkingBubble(),
      ChatTurnError(:final message) => _ErrorBubble(message: message),
    };
  }
}

class _Bubble extends StatelessWidget {
  const _Bubble({required this.text, required this.isUser});

  final String text;
  final bool isUser;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bg = isUser
        ? theme.colorScheme.primaryContainer
        : theme.colorScheme.surfaceContainerHighest;
    final fg = isUser
        ? theme.colorScheme.onPrimaryContainer
        : theme.colorScheme.onSurface;
    final align = isUser ? Alignment.centerRight : Alignment.centerLeft;
    return Align(
      alignment: align,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        constraints: const BoxConstraints(maxWidth: 360),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(text, style: TextStyle(color: fg)),
      ),
    );
  }
}

class _ThinkingBubble extends StatelessWidget {
  const _ThinkingBubble();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
          SizedBox(width: 8),
          Text('AI が考えています...'),
        ],
      ),
    );
  }
}

class _ErrorBubble extends StatelessWidget {
  const _ErrorBubble({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: theme.colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline, color: theme.colorScheme.onErrorContainer),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: TextStyle(color: theme.colorScheme.onErrorContainer),
            ),
          ),
        ],
      ),
    );
  }
}

class _SurfaceView extends StatelessWidget {
  const _SurfaceView({required this.session, required this.surfaceId});

  final AiChatSession session;
  final String surfaceId;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border.all(
          color: Theme.of(context).dividerColor,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Surface(
        surfaceContext: session.surfaceController.contextFor(surfaceId),
      ),
    );
  }
}
