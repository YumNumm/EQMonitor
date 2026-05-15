import 'package:flutter/material.dart';

class ThankYouDialog extends StatelessWidget {
  const ThankYouDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
      icon: Icon(
        Icons.favorite_rounded,
        color: theme.colorScheme.primary,
        size: 36,
      ),
      title: const Text('ありがとうございます'),
      content: const Text(
        'EQMonitor Pro へようこそ。\n'
        'いただいたご支援は、開発・運営費用に充てさせていただきます。',
      ),
      actions: [
        FilledButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('OK'),
        ),
      ],
    );
  }
}
