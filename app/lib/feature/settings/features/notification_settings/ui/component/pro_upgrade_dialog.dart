import 'package:eqmonitor/core/provider/environment/environment.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Pro プランへのアップグレード案内ダイアログの表示を担う。
class ProUpgradeDialogAction {
  const new();

  Future<void> show(BuildContext context) async {
    await showDialog<void>(
      context: context,
      builder: (context) => const _ProUpgradeDialog(),
    );
  }
}

class _ProUpgradeDialog extends ConsumerWidget {
  const new();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isProFeaturesEnabled = ref
        .watch(buildConfigProvider)
        .isProFeaturesEnabled;

    if (!isProFeaturesEnabled) {
      return AlertDialog(
        title: const Text('現在ご利用いただけません'),
        content: const Text('このビルドでは、'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('閉じる'),
          ),
        ],
      );
    }

    return AlertDialog(
      title: const Text('Proプランが必要です'),
      content: const Text('この機能を利用するにはProプランへのアップグレードが必要です。'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('閉じる'),
        ),
        FilledButton(
          onPressed: () async {
            Navigator.of(context).pop();
            await const PaywallRoute().push<void>(context);
          },
          child: const Text('Proを見る'),
        ),
      ],
    );
  }
}
