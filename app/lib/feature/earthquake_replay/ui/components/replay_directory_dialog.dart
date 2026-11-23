import 'package:eqmonitor/feature/earthquake_replay/ui/components/replay_directory_field.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:material_ui/material_ui.dart';

class const ReplayDirectoryDialog({
  required final String title,
  required final String initialDirectory,
  required final List<String> directories,
  required final String helperText,
  required final String confirmLabel,
  required final bool isEmptyAllowed,
  super.key,
}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController(text: initialDirectory);
    final value = useValueListenable(controller);
    return AlertDialog(
      title: Text(title),
      content: ReplayDirectoryField(
        controller: controller,
        directories: directories,
        helperText: helperText,
        autofocus: true,
      ),
      actions: [
        M3ETextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('キャンセル'),
        ),
        M3EFilledButton(
          onPressed: !isEmptyAllowed && value.text.trim().isEmpty
              ? null
              : () => Navigator.of(context).pop(controller.text),
          child: Text(confirmLabel),
        ),
      ],
    );
  }
}
