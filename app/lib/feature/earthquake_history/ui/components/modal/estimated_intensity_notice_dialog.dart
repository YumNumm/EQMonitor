import 'package:eqmonitor/feature/earthquake_history/ui/components/estimated_intensity_notice_content.dart';
import 'package:material_ui/material_ui.dart';

class EstimatedIntensityNoticeDialog extends StatelessWidget {
  const new({super.key});

  static Future<void> show(BuildContext context) => showDialog<void>(
    context: context,
    builder: (context) => const EstimatedIntensityNoticeDialog(),
  );

  @override
  Widget build(BuildContext context) {
    return const AlertDialog(
      title: Text('推計震度分布図について'),
      content: SingleChildScrollView(child: EstimatedIntensityNoticeContent()),
      actions: [_OkButton()],
    );
  }
}

class _OkButton extends StatelessWidget {
  const new();

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.of(context).pop(),
      child: const Text('OK'),
    );
  }
}
