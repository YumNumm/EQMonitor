import 'package:eqmonitor/feature/ai_chat/data/model/ai_credentials.dart';
import 'package:eqmonitor/feature/ai_chat/data/model/ai_provider.dart';
import 'package:eqmonitor/feature/ai_chat/data/provider/ai_credentials_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AiChatSettingsPage extends HookConsumerWidget {
  const AiChatSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final storeAsync = ref.watch(aiCredentialsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('AI チャット 設定')),
      body: storeAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('エラー: $e')),
        data: (store) => _Body(store: store),
      ),
    );
  }
}

class _Body extends HookConsumerWidget {
  const _Body({required this.store});

  final AiCredentialsStore store;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = useState(store.selectedProvider);
    final credentials = store.credentials[provider.value];
    final apiKeyCtrl = useTextEditingController(
      text: credentials?.apiKey ?? '',
    );
    final selectedModel = useState(
      credentials?.model ?? provider.value.defaultModel,
    );
    final isSaving = useState(false);
    final obscure = useState(true);

    // プロバイダ切替時にコントローラを差し替える
    useEffect(() {
      final c = store.credentials[provider.value];
      apiKeyCtrl.text = c?.apiKey ?? '';
      selectedModel.value = c?.model ?? provider.value.defaultModel;
      return null;
    }, [provider.value]);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const _Note(),
        const SizedBox(height: 16),
        Text('プロバイダ', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        SegmentedButton<AiProvider>(
          segments: AiProvider.values
              .map(
                (p) => ButtonSegment(value: p, label: Text(p.displayName)),
              )
              .toList(),
          selected: {provider.value},
          onSelectionChanged: (s) => provider.value = s.first,
        ),
        const SizedBox(height: 24),
        Text('モデル', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          initialValue:
              provider.value.availableModels.contains(
                selectedModel.value,
              )
              ? selectedModel.value
              : provider.value.defaultModel,
          items: provider.value.availableModels
              .map((m) => DropdownMenuItem(value: m, child: Text(m)))
              .toList(),
          onChanged: (v) {
            if (v != null) {
              selectedModel.value = v;
            }
          },
          decoration: const InputDecoration(border: OutlineInputBorder()),
        ),
        const SizedBox(height: 24),
        Text('API キー', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        TextField(
          controller: apiKeyCtrl,
          obscureText: obscure.value,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            suffixIcon: IconButton(
              onPressed: () => obscure.value = !obscure.value,
              icon: Icon(
                obscure.value ? Icons.visibility : Icons.visibility_off,
              ),
            ),
            hintText: switch (provider.value) {
              AiProvider.anthropic => 'sk-ant-...',
              AiProvider.gemini => 'AIza...',
              AiProvider.openai => 'sk-...',
            },
          ),
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: FilledButton.icon(
                onPressed: isSaving.value
                    ? null
                    : () async {
                        isSaving.value = true;
                        try {
                          await ref
                              .read(aiCredentialsProvider.notifier)
                              .upsertCredentials(
                                AiCredentials(
                                  provider: provider.value,
                                  model: selectedModel.value,
                                  apiKey: apiKeyCtrl.text.trim(),
                                ),
                              );
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('保存しました')),
                            );
                          }
                        } finally {
                          isSaving.value = false;
                        }
                      },
                icon: const Icon(Icons.save),
                label: const Text('保存して選択中にする'),
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              onPressed: credentials == null
                  ? null
                  : () async {
                      await ref
                          .read(aiCredentialsProvider.notifier)
                          .clearProvider(provider.value);
                      apiKeyCtrl.clear();
                    },
              tooltip: 'このプロバイダのキーを削除',
              icon: const Icon(Icons.delete_outline),
            ),
          ],
        ),
        const Divider(height: 32),
        Text('保存済み', style: Theme.of(context).textTheme.titleMedium),
        for (final p in AiProvider.values)
          ListTile(
            title: Text(p.displayName),
            subtitle: Text(
              store.credentials[p]?.model ?? '未設定',
            ),
            trailing: store.selectedProvider == p
                ? const Icon(Icons.check_circle, color: Colors.green)
                : null,
            onTap: store.credentials[p] == null
                ? null
                : () => ref
                      .read(aiCredentialsProvider.notifier)
                      .selectProvider(p),
          ),
      ],
    );
  }
}

class _Note extends StatelessWidget {
  const _Note();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.tertiaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: DefaultTextStyle.merge(
          style: TextStyle(
            color: Theme.of(context).colorScheme.onTertiaryContainer,
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '実験機能 (デバッグメニュー専用)',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              Text(
                'API キーは端末の Secure Storage に保存されます。 通信は各プロバイダーへ直接行われ、サーバ経由ではありません。 使用するモデルおよびその料金体系はユーザの責任となります。',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
