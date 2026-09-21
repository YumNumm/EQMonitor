import 'package:flutter/material.dart';
import 'package:m3e_core/m3e_core.dart';

class EewHistoryNoticeDialog extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('緊急地震速報の履歴について'),
      content: const Text('履歴一覧では、1つの緊急地震速報につき、最終報の情報を表示しています。'),
      actions: [
        M3ETextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text('OK'),
        ),
      ],
    );
  }
}
