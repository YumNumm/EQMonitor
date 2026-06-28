import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OnboardingProvisioningErrorDetailsDialog extends StatelessWidget {
  const OnboardingProvisioningErrorDetailsDialog({
    required this.details,
    super.key,
  });

  final String details;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('エラー詳細'),
      content: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 520, maxHeight: 320),
        child: SingleChildScrollView(
          child: SelectableText(details),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('閉じる'),
        ),
        FilledButton.icon(
          onPressed: () async {
            await Clipboard.setData(ClipboardData(text: details));
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('エラー詳細をコピーしました')),
              );
            }
          },
          icon: const Icon(Icons.copy_rounded, size: 18),
          label: const Text('コピー'),
        ),
      ],
    );
  }
}
