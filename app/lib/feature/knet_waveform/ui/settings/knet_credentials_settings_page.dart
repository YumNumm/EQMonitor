import 'package:eqmonitor/feature/knet_waveform/data/provider/knet_credentials_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:knet_api_client/knet_api_client.dart';

class KnetCredentialsSettingsPage extends HookConsumerWidget {
  const KnetCredentialsSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userIdController = useTextEditingController();
    final passwordController = useTextEditingController();
    final isVerifying = useState(false);
    final verifyResult = useState<bool?>(null);

    final credentials = ref.watch(knetCredentialsProvider);

    useEffect(
      () {
        credentials.whenData((data) {
          if (data != null) {
            userIdController.text = data.userId;
            passwordController.text = data.password;
          }
        });
        return null;
      },
      [credentials],
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('K-NET 認証設定'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '防災科研 強震観測網 認証情報',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '防災科学技術研究所（NIED）の強震観測網データをダウンロードするために、'
                    'ユーザー登録済みの BOSAI アカウント情報を入力してください。',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: userIdController,
            decoration: const InputDecoration(
              labelText: 'ユーザーID',
              hintText: 'BOSAI ユーザーID',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.person),
            ),
            textInputAction: TextInputAction.next,
            onChanged: (_) => verifyResult.value = null,
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: passwordController,
            decoration: const InputDecoration(
              labelText: 'パスワード',
              hintText: 'BOSAI パスワード',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.lock),
            ),
            obscureText: true,
            textInputAction: TextInputAction.done,
            onChanged: (_) => verifyResult.value = null,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: FilledButton.tonal(
                  onPressed: isVerifying.value
                      ? null
                      : () async {
                          final userId = userIdController.text.trim();
                          final password = passwordController.text.trim();
                          if (userId.isEmpty || password.isEmpty) {
                            return;
                          }
                          isVerifying.value = true;
                          verifyResult.value = null;
                          try {
                            final client = KnetDownloadClient(
                              userId: userId,
                              password: password,
                            );
                            final ok = await client.verifyAuthentication();
                            verifyResult.value = ok;
                          } on Exception catch (_) {
                            verifyResult.value = false;
                          } finally {
                            isVerifying.value = false;
                          }
                        },
                  child: isVerifying.value
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('認証テスト'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: FilledButton(
                  onPressed: isVerifying.value
                      ? null
                      : () async {
                          final userId = userIdController.text.trim();
                          final password = passwordController.text.trim();
                          if (userId.isEmpty || password.isEmpty) {
                            return;
                          }
                          await ref
                              .read(knetCredentialsProvider.notifier)
                              .save(userId: userId, password: password);
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('認証情報を保存しました')),
                            );
                          }
                        },
                  child: const Text('保存'),
                ),
              ),
            ],
          ),
          if (verifyResult.value != null) ...[
            const SizedBox(height: 12),
            _VerifyResultBanner(success: verifyResult.value!),
          ],
          const SizedBox(height: 24),
          credentials.when(
            loading: () => const SizedBox.shrink(),
            error: (_, _) => const SizedBox.shrink(),
            data: (data) {
              if (data == null) {
                return const SizedBox.shrink();
              }
              return OutlinedButton.icon(
                icon: const Icon(Icons.delete_outline),
                label: const Text('認証情報を削除'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.error,
                ),
                onPressed: () async {
                  await ref.read(knetCredentialsProvider.notifier).clear();
                  if (context.mounted) {
                    Navigator.of(context).pop();
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class _VerifyResultBanner extends StatelessWidget {
  const _VerifyResultBanner({required this.success});

  final bool success;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: success
            ? Theme.of(context).colorScheme.primaryContainer
            : Theme.of(context).colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(
            success ? Icons.check_circle_outline : Icons.error_outline,
            color: success
                ? Theme.of(context).colorScheme.onPrimaryContainer
                : Theme.of(context).colorScheme.onErrorContainer,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              success ? '認証に成功しました' : '認証に失敗しました。IDまたはパスワードを確認してください。',
              style: TextStyle(
                color: success
                    ? Theme.of(context).colorScheme.onPrimaryContainer
                    : Theme.of(context).colorScheme.onErrorContainer,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
