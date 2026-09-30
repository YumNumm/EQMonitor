import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:material_ui/material_ui.dart';

class NotificationSoundNameDialog extends HookWidget {
  const new({required this.initialName, super.key});

  final String initialName;

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController(text: initialName);
    final value = useValueListenable(controller);
    return AlertDialog(
      title: const Text('通知音の名前を変更'),
      content: TextField(
        controller: controller,
        maxLength: 100,
        decoration: const InputDecoration(labelText: '名前'),
      ),
      actions: [
        M3ETextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('キャンセル'),
        ),
        M3EFilledButton(
          onPressed: value.text.trim().isEmpty
              ? null
              : () => Navigator.of(context).pop(value.text.trim()),
          child: const Text('保存'),
        ),
      ],
    );
  }
}
