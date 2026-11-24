import 'package:m3e_core/m3e_core.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:material_ui/material_ui.dart';

/// Pro プランへのアップグレード案内ダイアログの表示を担う。
class const ProUpgradeDialogAction() {
  Future<void> show(BuildContext context) async {
    await showDialog<void>(
      context: context,
      builder: (context) => const _ProUpgradeDialog(),
    );
  }
}

class const _ProUpgradeDialog() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Pro プランが必要です'),
      content: const Text('この機能を利用するには Pro プランへのアップグレードが必要です。'),
      actions: [
        M3ETextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('閉じる'),
        ),
        M3EFilledButton(
          onPressed: () async {
            Navigator.of(context).pop();
            await const PaywallRoute().push<void>(context);
          },
          child: const Text('Pro を見る'),
        ),
      ],
    );
  }
}
