import '../../../route.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LogViewButtonWidget extends StatelessWidget {
  const LogViewButtonWidget({super.key});

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
        'ログ',
        style: titleTextStyle,
      ),
      subtitle: const Text('ログを確認する', style: descriptionTextStyle),
      leading: const Icon(Icons.logo_dev),
      onTap: () => LogRoute().push(context),
    );
  }
}
