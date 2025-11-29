import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../provider/qzss_serial_port_provider.dart';
import 'qzss_dcr_report_widget.dart';
import 'qzss_serial_port_settings_page.dart';

class QzssDcrPage extends HookConsumerWidget {
  const QzssDcrPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final connectionState = ref.watch(qzssSerialPortConnectionProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('QZSS災危通報'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'シリアルポート設定',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (context) => const QzssSerialPortSettingsPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // 接続状態インジケーター
          _ConnectionStatusCard(isConnected: connectionState.isConnected),
          const SizedBox(height: 16),

          // 災危通報表示
          const QzssDcrReportWidget(),
        ],
      ),
    );
  }
}

class _ConnectionStatusCard extends StatelessWidget {
  const _ConnectionStatusCard({
    required this.isConnected,
  });

  final bool isConnected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      color: isConnected
          ? colorScheme.primaryContainer
          : colorScheme.errorContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(
              isConnected ? Icons.check_circle : Icons.warning_amber,
              color: isConnected
                  ? colorScheme.onPrimaryContainer
                  : colorScheme.onErrorContainer,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isConnected ? 'シリアルポート接続中' : 'シリアルポート未接続',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: isConnected
                          ? colorScheme.onPrimaryContainer
                          : colorScheme.onErrorContainer,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (!isConnected)
                    Text(
                      '設定から接続してください',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onErrorContainer,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
