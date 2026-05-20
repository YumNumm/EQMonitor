import 'package:eqmonitor/feature/ai_chat/data/model/ai_provider.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ai_credentials.freezed.dart';
part 'ai_credentials.g.dart';

@freezed
abstract class AiCredentials with _$AiCredentials {
  const factory AiCredentials({
    required AiProvider provider,
    required String model,
    required String apiKey,
  }) = _AiCredentials;

  factory AiCredentials.fromJson(Map<String, dynamic> json) =>
      _$AiCredentialsFromJson(json);
}

@freezed
abstract class AiCredentialsStore with _$AiCredentialsStore {
  const factory AiCredentialsStore({
    required AiProvider selectedProvider,
    @Default({}) Map<AiProvider, AiCredentials> credentials,
  }) = _AiCredentialsStore;

  const AiCredentialsStore._();

  factory AiCredentialsStore.fromJson(Map<String, dynamic> json) =>
      _$AiCredentialsStoreFromJson(json);

  factory AiCredentialsStore.initial() => const AiCredentialsStore(
    selectedProvider: AiProvider.anthropic,
  );

  /// 現在選択されているプロバイダーの認証情報。
  AiCredentials? get selected => credentials[selectedProvider];

  /// 選択中のプロバイダーが API キーを保持しているか。
  bool get hasUsableCredentials =>
      selected != null && selected!.apiKey.trim().isNotEmpty;
}
