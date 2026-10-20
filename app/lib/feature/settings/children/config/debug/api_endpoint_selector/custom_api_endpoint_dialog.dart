import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/core/provider/telegram_url/model/api_endpoint_url.dart';
import 'package:eqmonitor/core/provider/telegram_url/provider/telegram_url_provider.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:material_ui/material_ui.dart';
import 'package:riverpod/experimental/mutation.dart';

class CustomApiEndpointDialog extends HookConsumerWidget {
  const new({required this.initialUrl, super.key});

  final String initialUrl;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController(text: initialUrl);
    final formKey = useMemoized(GlobalKey<FormState>.new);
    final mutation = ref.watch(TelegramUrl.updateMutation);
    final isSaving = mutation is MutationPending;

    return PopScope(
      canPop: !isSaving,
      child: AlertDialog(
        title: const Text('APIの接続先を入力'),
        scrollable: true,
        content: SizedBox(
          width: 400,
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: controller,
                  autofocus: true,
                  enabled: !isSaving,
                  autocorrect: false,
                  enableSuggestions: false,
                  keyboardType: TextInputType.url,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: const ApiEndpointUrl().validate,
                  decoration: const InputDecoration(
                    labelText: 'REST API URL',
                    hintText: 'https://cf.v2.api.eqmonitor.app',
                    border: OutlineInputBorder(),
                    errorMaxLines: 3,
                  ),
                ),
                const SizedBox(height: 16),
                const Text('保存すると接続先を切り替えます。アプリを再起動しても設定は保持されます。'),
                const SizedBox(height: 8),
                const Text('WebSocketはAPIが案内する接続先に自動で接続します。'),
                const SizedBox(height: 8),
                const Text('カスタム接続先ではGoogle・Apple・Passkey認証を利用できません。'),
                if (mutation is MutationError) ...[
                  const SizedBox(height: 8),
                  Text(
                    '接続先を保存できませんでした。もう一度お試しください。',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
        actions: [
          M3ETextButton(
            onPressed: isSaving ? null : () => Navigator.of(context).pop(),
            child: const Text('キャンセル'),
          ),
          M3EFilledButton(
            onPressed: isSaving
                ? null
                : () async {
                    if (formKey.currentState?.validate() != true) {
                      return;
                    }
                    try {
                      await TelegramUrl.updateMutation.run(
                        ref,
                        (tsx) => tsx
                            .get(telegramUrlProvider.notifier)
                            .updateRestUrl(controller.text),
                      );
                      if (context.mounted) {
                        Navigator.of(context).pop();
                      }
                      // Mutation retains the error so the form can offer a retry.
                      // ignore: avoid_catches_without_on_clauses
                    } catch (error, stackTrace) {
                      talker.error('API接続先の保存に失敗しました', error, stackTrace);
                    }
                  },
            child: Text(isSaving ? '保存中…' : '保存'),
          ),
        ],
      ),
    );
  }
}
