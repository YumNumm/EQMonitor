import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:material_ui/material_ui.dart';

class ThankYouDialog extends StatelessWidget {
  const ThankYouDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: Icon(
        Icons.favorite_rounded,
        color: context.designSystem.colorTheme.primary,
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
