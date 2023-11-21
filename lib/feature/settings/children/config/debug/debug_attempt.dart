import 'package:eqmonitor/core/extension/string_ex.dart';
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
    if (str == null) {
      return false;
    }
    if ('SALT${str}SALT'.sha512 ==
        // ignore: lines_longer_than_80_chars
        '6e205e617f7b1a49310008f128abcd1f1a950486145f47b99c1a47c0edee63141420001eac07f0978bea3245026f71905086853bb2c26a06162c2bf5f3c56b11') {
      return true;
    }
    return false;
  }
}
