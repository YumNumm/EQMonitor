import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UpdateHistoryButtonWidget extends StatelessWidget {
  const UpdateHistoryButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    const descriptionTextStyle = TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 14,
    );
    const titleTextStyle = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
    );

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      title: const Text(
        '更新履歴',
        style: titleTextStyle,
      ),
      subtitle: const Text('更新履歴を確認する', style: descriptionTextStyle),
      onTap: () => context.push('/settings/appinfo/updateHistory'),
    );
  }
}
