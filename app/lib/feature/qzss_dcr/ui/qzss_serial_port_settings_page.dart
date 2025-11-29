import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../provider/qzss_serial_port_provider.dart';

class QzssSerialPortSettingsPage extends HookConsumerWidget {
  const QzssSerialPortSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final availablePorts = ref.watch(availableSerialPortsProvider);
    final connectionState = ref.watch(qzssSerialPortConnectionProvider);
    final selectedPort = useState<String?>(connectionState.portName);
    final selectedBaudRate = useState<int>(connectionState.baudRate);

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('QZSS災危通報 シリアルポート設定'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // 接続状態カード
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        connectionState.isConnected
                            ? Icons.check_circle
                            : Icons.error_outline,
                        color: connectionState.isConnected
                            ? colorScheme.primary
                            : colorScheme.error,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        connectionState.isConnected ? '接続中' : '未接続',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: connectionState.isConnected
                              ? colorScheme.primary
                              : colorScheme.error,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  if (connectionState.isConnected) ...[
                    const SizedBox(height: 8),
                    Text(
                      'ポート: ${connectionState.portName}',
                      style: theme.textTheme.bodyMedium,
                    ),
                    Text(
                      'ボーレート: ${connectionState.baudRate} bps',
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                  if (connectionState.error != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      'エラー: ${connectionState.error}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.error,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // シリアルポート選択
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'シリアルポート',
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  if (availablePorts.isEmpty)
                    const Text('利用可能なシリアルポートが見つかりません')
                  else
                    DropdownButtonFormField<String>(
                      value: selectedPort.value,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'ポートを選択',
                      ),
                      items: availablePorts.map((port) {
                        return DropdownMenuItem(
                          value: port,
                          child: Text(port),
                        );
                      }).toList(),
                      onChanged: connectionState.isConnected
                          ? null
                          : (value) {
                              selectedPort.value = value;
                            },
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // ボーレート選択
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ボーレート',
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<int>(
                    value: selectedBaudRate.value,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: 9600,
                        child: Text('9600 bps'),
                      ),
                      DropdownMenuItem(
                        value: 38400,
                        child: Text('38400 bps'),
                      ),
                      DropdownMenuItem(
                        value: 115200,
                        child: Text('115200 bps'),
                      ),
                    ],
                    onChanged: connectionState.isConnected
                        ? null
                        : (value) {
                            if (value != null) {
                              selectedBaudRate.value = value;
                            }
                          },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // 接続/切断ボタン
          if (connectionState.isConnected)
            FilledButton.icon(
              onPressed: () async {
                await ref
                    .read(qzssSerialPortConnectionProvider.notifier)
                    .disconnect();
              },
              icon: const Icon(Icons.stop),
              label: const Text('切断'),
              style: FilledButton.styleFrom(
                backgroundColor: colorScheme.error,
                foregroundColor: colorScheme.onError,
              ),
            )
          else
            FilledButton.icon(
              onPressed: selectedPort.value == null
                  ? null
                  : () async {
                      try {
                        await ref
                            .read(qzssSerialPortConnectionProvider.notifier)
                            .connect(
                              selectedPort.value!,
                              selectedBaudRate.value,
                            );
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('接続しました'),
                            ),
                          );
                        }
                      } catch (e) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('接続エラー: $e'),
                              backgroundColor: colorScheme.error,
                            ),
                          );
                        }
                      }
                    },
              icon: const Icon(Icons.play_arrow),
              label: const Text('接続'),
            ),
          const SizedBox(height: 16),

          // 説明
          Card(
            color: colorScheme.surfaceContainerHighest,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: colorScheme.primary,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '使い方',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '1. GNSS受信機（u-blox製など）をUSB/シリアル接続してください\n'
                    '2. 利用可能なシリアルポートから受信機のポートを選択\n'
                    '3. ボーレートを選択（通常は115200 bps）\n'
                    '4. 「接続」ボタンを押して接続開始\n'
                    '5. 災危通報を受信すると自動的に表示されます',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
