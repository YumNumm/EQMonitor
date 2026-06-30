import 'package:eqmonitor/core/router/router.dart';
import 'package:flutter/material.dart';

Future<void> showProUpgradeDialog(BuildContext context) async {
  await showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
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
    ),
  );
}
