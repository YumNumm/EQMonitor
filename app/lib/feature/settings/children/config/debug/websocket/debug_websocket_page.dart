import 'dart:convert';

import 'package:eqmonitor/core/gen/fonts.gen.dart';
import 'package:eqmonitor/core/model/websocket/ws_message.dart';
import 'package:eqmonitor/core/provider/websocket/websocket_connection_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DebugWebSocketPage extends HookConsumerWidget {
  const DebugWebSocketPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messages = useState<List<({DateTime at, WsMessage msg})>>([]);
    final status = ref.watch(wsConnectionStatusProvider);
    final currentUrl = ref.watch(wsCurrentUrlProvider);
    final lastPingAt = ref.watch(wsLastPingAtProvider);

    ref.listen(wsConnectionProvider, (_, next) {
      next.whenData((msg) {
        final nextList = [
          (at: DateTime.now(), msg: msg),
          ...messages.value.take(99),
        ];
        messages.value = nextList;
      });
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('WebSocket デバッグ'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () => messages.value = [],
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.invalidate(wsConnectionProvider),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _WsStatusCard(
            status: status,
            wsUrl: currentUrl,
            lastPingAt: lastPingAt,
          ),
          const Divider(height: 1),
          Expanded(
            child: messages.value.isEmpty
                ? const Center(
                    child: Text('受信メッセージはまだありません'),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: messages.value.length,
                    itemBuilder: (context, index) {
                      final e = messages.value[index];
                      return _WsMessageCard(
                        receivedAt: e.at,
                        msg: e.msg,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _WsStatusCard extends HookWidget {
  const _WsStatusCard({
    required this.status,
    required this.wsUrl,
    required this.lastPingAt,
  });

  final WsConnectionState status;
  final String? wsUrl;
  final DateTime? lastPingAt;

  @override
  Widget build(BuildContext context) {
    // Rebuild every second to update elapsed-since-ping display
    useStream(
      Stream.periodic(const Duration(seconds: 1), (i) => i),
      initialData: 0,
    );

    final theme = Theme.of(context);
    final statusLabel = switch (status) {
      WsConnectionState.connecting => '接続中',
      WsConnectionState.connected => '接続済み',
      WsConnectionState.disconnected => '切断',
    };
    final statusColor = switch (status) {
      WsConnectionState.connecting => theme.colorScheme.secondary,
      WsConnectionState.connected => theme.colorScheme.primary,
      WsConnectionState.disconnected => theme.colorScheme.error,
    };

    final pingLabel = lastPingAt == null
        ? 'なし'
        : _elapsedLabel(DateTime.now().difference(lastPingAt!));

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.circle, size: 12, color: statusColor),
              const SizedBox(width: 8),
              Text(statusLabel, style: theme.textTheme.titleMedium),
            ],
          ),
          if (wsUrl != null) ...[
            const SizedBox(height: 8),
            SelectableText(
              wsUrl!,
              style: theme.textTheme.bodySmall?.copyWith(
                fontFamily: FontFamily.notoSansMono,
              ),
            ),
          ],
          const SizedBox(height: 4),
          Text('最終 ping: $pingLabel', style: theme.textTheme.bodySmall),
        ],
      ),
    );
  }

  String _elapsedLabel(Duration d) {
    if (d.inSeconds < 60) {
      return '${d.inSeconds}秒前';
    }
    return '${d.inMinutes}分前';
  }
}

class _WsMessageCard extends StatelessWidget {
  const _WsMessageCard({
    required this.receivedAt,
    required this.msg,
  });

  final DateTime receivedAt;
  final WsMessage msg;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final displayType = switch (msg) {
      WsSnapshotMessage() => 'snapshot',
      WsRealtimeMessage(:final data) => 'realtime / ${data.runtimeType}',
    };

    final timeStr =
        '${receivedAt.hour.toString().padLeft(2, '0')}:'
        '${receivedAt.minute.toString().padLeft(2, '0')}:'
        '${receivedAt.second.toString().padLeft(2, '0')}.'
        '${receivedAt.millisecond.toString().padLeft(3, '0')}';

    String pretty;
    try {
      pretty = const JsonEncoder.withIndent('  ').convert(msg.toJson());
    } on Object {
      pretty = msg.toString();
    }

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: InkWell(
        onTap: () async => Clipboard.setData(ClipboardData(text: pretty)),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      displayType,
                      style: theme.textTheme.titleSmall,
                    ),
                  ),
                  Text(
                    timeStr,
                    style: theme.textTheme.labelSmall?.copyWith(
                      fontFamily: FontFamily.notoSansMono,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              SelectableText(
                pretty,
                style: theme.textTheme.bodySmall?.copyWith(
                  fontFamily: FontFamily.notoSansMono,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
