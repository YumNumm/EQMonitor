import 'package:adaptive_platform_ui/adaptive_platform_ui.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NotificationLocalSettingsPage extends StatelessWidget {
  const NotificationLocalSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AdaptiveScaffold(
      appBar: AdaptiveAppBar(title: '通知音・表示設定'),
      body: _Body(),
    );
  }
}

class _Body extends ConsumerWidget {
  const _Body();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}
