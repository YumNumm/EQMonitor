import 'package:eqmonitor/feature/ai_chat/data/ai_chat_session.dart';
import 'package:eqmonitor/feature/ai_chat/data/llm/genkit_client.dart';
import 'package:eqmonitor/feature/ai_chat/data/provider/ai_credentials_provider.dart';
import 'package:eqmonitor/feature/ai_chat/data/tool/eq_tool_runner.dart';
import 'package:eqmonitor/feature/earthquake_history/data/repository/earthquake_history_repository.dart';
import 'package:genui/genui.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ai_chat_session_provider.g.dart';

@riverpod
Future<AiChatSession> aiChatSession(
  Ref ref, {
  String? initialMessage,
  String? extraSystemPrompt,
}) async {
  final store = await ref.watch(aiCredentialsProvider.future);
  final credentials = store.selected;
  if (credentials == null || credentials.apiKey.trim().isEmpty) {
    throw StateError('AI 認証情報が未設定です。');
  }
  final repository = await ref.watch(
    earthquakeHistoryRepositoryProvider.future,
  );
  final toolRunner = EqToolRunner(repository: repository);
  final client = createGenkitClient(
    credentials: credentials,
    toolRunner: toolRunner,
  );
  final session = AiChatSession(
    client: client,
    catalog: BasicCatalogItems.asCatalog(),
    initialMessage: initialMessage,
    extraSystemPrompt: extraSystemPrompt,
  );
  ref.onDispose(session.dispose);
  return session;
}
