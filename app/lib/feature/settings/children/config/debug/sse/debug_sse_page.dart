import 'dart:convert';

import 'package:eqmonitor/core/gen/fonts.gen.dart';
import 'package:eqmonitor/core/provider/sse/sse_connection_provider.dart';
import 'package:eqmonitor/core/provider/telegram_url/provider/telegram_url_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DebugSsePage extends HookConsumerWidget {
  const DebugSsePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entries = useState<List<({DateTime at, Map<String, dynamic> data})>>(
      [],
    );
    final sseAsync = ref.watch(sseConnectionProvider);
    final status = ref.watch(sseConnectionStatusProvider);
    final restUrl = ref.watch(telegramUrlProvider).requireValue.restApiUrl;

    ref.listen(sseConnectionProvider, (_, next) {
      next.whenData((data) {
        final nextList = [
          (at: DateTime.now(), data: data),
          ...entries.value.take(99),
        ];
        entries.value = nextList;
      });
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('SSE デバッグ'),
        actions: [
          IconButton(
            tooltip: 'ログをクリア',
            icon: const Icon(Icons.delete_outline),
            onPressed: () => entries.value = [],
          ),
          IconButton(
            tooltip: '再接続',
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.invalidate(sseConnectionProvider),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _SseStatusCard(
            status: status,
            sseAsync: sseAsync,
            streamUrl: '$restUrl/v2/realtime/stream',
          ),
          const Divider(height: 1),
          Expanded(
            child: entries.value.isEmpty
                ? const Center(
                    child: Text('受信イベントはまだありません'),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: entries.value.length,
                    itemBuilder: (context, index) {
                      final e = entries.value[index];
                      return _SseEventCard(
                        receivedAt: e.at,
                        payload: e.data,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _SseStatusCard extends StatelessWidget {
  const _SseStatusCard({
    required this.status,
    required this.sseAsync,
    required this.streamUrl,
  });

  final SseConnectionState status;
  final AsyncValue<Map<String, dynamic>> sseAsync;
  final String streamUrl;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final statusLabel = switch (status) {
      SseConnectionState.connecting => '接続中',
      SseConnectionState.connected => '接続済み',
      SseConnectionState.disconnected => '切断',
    };
    final statusColor = switch (status) {
      SseConnectionState.connecting => theme.colorScheme.secondary,
      SseConnectionState.connected => theme.colorScheme.primary,
      SseConnectionState.disconnected => theme.colorScheme.error,
    };

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.circle, size: 12, color: statusColor),
              const SizedBox(width: 8),
              Text(
                statusLabel,
                style: theme.textTheme.titleMedium,
              ),
            ],
          ),
          const SizedBox(height: 8),
          SelectableText(
            streamUrl,
            style: theme.textTheme.bodySmall?.copyWith(
              fontFamily: FontFamily.notoSansMono,
            ),
          ),
          if (sseAsync.hasError) ...[
            const SizedBox(height: 8),
            Text(
              sseAsync.error.toString(),
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.error,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _SseEventCard extends StatelessWidget {
  const _SseEventCard({
    required this.receivedAt,
    required this.payload,
  });

  final DateTime receivedAt;
  final Map<String, dynamic> payload;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final type = payload['type']?.toString() ?? '—';
    final timeStr =
        '${receivedAt.hour.toString().padLeft(2, '0')}:'
        '${receivedAt.minute.toString().padLeft(2, '0')}:'
        '${receivedAt.second.toString().padLeft(2, '0')}.'
        '${receivedAt.millisecond.toString().padLeft(3, '0')}';
    String pretty;
    try {
      pretty = const JsonEncoder.withIndent('  ').convert(payload);
    } on Object {
      pretty = payload.toString();
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
                      type,
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
