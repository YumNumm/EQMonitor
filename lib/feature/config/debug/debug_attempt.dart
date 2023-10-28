import 'package:eqmonitor/core/foundation/string_ex.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class DebugAttempt extends HookWidget {
  const DebugAttempt({super.key});

  @override
  Widget build(BuildContext context) {
    final textFieldController = useTextEditingController();
    return AlertDialog(
      title: const Text('Debug Attempt'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Input debug key.'),
          const SizedBox(height: 8),
          TextFormField(
            controller: textFieldController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Debug Key',
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          child: const Text('Cancel'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextButton(
          child: const Text('OK'),
          onPressed: () => Navigator.of(context).pop(textFieldController.text),
        ),
      ],
    );
  }

  static Future<bool> attempt(BuildContext context) async {
    final str = await showDialog<String>(
      context: context,
      builder: (context) => const DebugAttempt(),
    );
    if (str?.sha512 ==
        'a18accfb22e45f501dc94cb4d6fbf0bb564a72bd6f37373728ee892855c31ae5d69364c5c9284ae860636cc21729c17d93ae5541bf112a9b95e9bc436b819073') {
      return true;
    }
    return false;
  }
}
