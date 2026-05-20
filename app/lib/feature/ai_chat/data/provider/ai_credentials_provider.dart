import 'package:eqmonitor/feature/ai_chat/data/model/ai_credentials.dart';
import 'package:eqmonitor/feature/ai_chat/data/model/ai_provider.dart';
import 'package:eqmonitor/feature/ai_chat/data/repository/ai_credentials_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ai_credentials_provider.g.dart';

@Riverpod(keepAlive: true)
class AiCredentialsNotifier extends _$AiCredentialsNotifier {
  @override
  Future<AiCredentialsStore> build() async {
    return ref.read(aiCredentialsRepositoryProvider).load();
  }

  Future<void> selectProvider(AiProvider provider) async {
    final current = await future;
    final next = current.copyWith(selectedProvider: provider);
    await ref.read(aiCredentialsRepositoryProvider).save(next);
    state = AsyncData(next);
  }

  Future<void> upsertCredentials(AiCredentials credentials) async {
    final current = await future;
    final updated = Map<AiProvider, AiCredentials>.from(current.credentials)
      ..[credentials.provider] = credentials;
    final next = current.copyWith(
      selectedProvider: credentials.provider,
      credentials: updated,
    );
    await ref.read(aiCredentialsRepositoryProvider).save(next);
    state = AsyncData(next);
  }

  Future<void> clearProvider(AiProvider provider) async {
    final current = await future;
    final updated = Map<AiProvider, AiCredentials>.from(current.credentials)
      ..remove(provider);
    final next = current.copyWith(credentials: updated);
    await ref.read(aiCredentialsRepositoryProvider).save(next);
    state = AsyncData(next);
  }
}
