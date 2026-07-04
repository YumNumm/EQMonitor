import 'dart:async';
import 'dart:convert';

import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/feature/telemetry/data/provider/telemetry_database_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:telemetry_store/telemetry_store.dart';

class DebugTelemetryPage extends HookConsumerWidget {
  const DebugTelemetryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final events = useState<List<TelemetryEventRow>>([]);
    final totalCount = useState(0);
    final isLoading = useState(true);

    Future<void> refresh() async {
      isLoading.value = true;
      final db = ref.read(telemetryDatabaseProvider);
      final results = await db.getAllEvents();
      final count = await db.countEvents();
      events.value = results;
      totalCount.value = count;
      isLoading.value = false;
    }

    useEffect(
      () {
        unawaited(refresh());
        return null;
      },
      const [],
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Telemetry Events'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: refresh,
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () async {
              final confirmed = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('全イベントを削除'),
                  content: Text('${totalCount.value}件のイベントを削除しますか？'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text('キャンセル'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text('削除'),
                    ),
                  ],
                ),
              );
              if (confirmed ?? false) {
                await ref.read(telemetryDatabaseProvider).deleteAllEvents();
                await refresh();
              }
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _SummaryCard(
            totalCount: totalCount.value,
            unsyncedCount:
                events.value.where((e) => !e.synced).length,
          ),
          const Divider(height: 1),
          Expanded(
            child: isLoading.value
                ? const Center(child: CircularProgressIndicator.adaptive())
                : events.value.isEmpty
                    ? const Center(child: Text('イベントはまだありません'))
                    : ListView.separated(
                        itemCount: events.value.length,
                        separatorBuilder: (_, _) => const Divider(height: 1),
                        itemBuilder: (context, index) =>
                            _EventTile(event: events.value[index]),
                      ),
          ),
        ],
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.totalCount,
    required this.unsyncedCount,
  });

  final int totalCount;
  final int unsyncedCount;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '合計: $totalCount件',
                  style: theme.textTheme.titleMedium,
                ),
                Text(
                  '未送信: $unsyncedCount件',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: unsyncedCount > 0
                        ? context.designSystem.colorTheme.error
                        : context.designSystem.colorTheme.outline,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _EventTile extends StatelessWidget {
  const _EventTile({required this.event});

  final TelemetryEventRow event;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final time = DateTime.fromMillisecondsSinceEpoch(event.timestampMs);
    final timeStr =
        '${time.month}/${time.day} ${time.hour}:${time.minute.toString().padLeft(2, '0')}:${time.second.toString().padLeft(2, '0')}';

    String prettyPayload;
    try {
      final decoded = jsonDecode(event.payload) as Map<String, dynamic>;
      prettyPayload = const JsonEncoder.withIndent('  ').convert(decoded);
    } on Object {
      prettyPayload = event.payload;
    }

    return ListTile(
      dense: true,
      leading: Icon(
        event.synced ? Icons.cloud_done : Icons.cloud_upload_outlined,
        size: 20,
        color: event.synced
            ? context.designSystem.colorTheme.outline
            : context.designSystem.colorTheme.primary,
      ),
      title: Text(
        event.eventType,
        style: theme.textTheme.bodyMedium?.copyWith(
          fontFamily: 'monospace',
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            timeStr,
            style: theme.textTheme.bodySmall,
          ),
          if (event.eventId != null)
            Text(
              'eventId: ${event.eventId}',
              style: theme.textTheme.bodySmall?.copyWith(
                color: context.designSystem.colorTheme.outline,
              ),
            ),
        ],
      ),
      onTap: () async {
        await showModalBottomSheet<void>(
          context: context,
          isScrollControlled: true,
          builder: (context) => DraggableScrollableSheet(
            initialChildSize: 0.6,
            minChildSize: 0.3,
            maxChildSize: 0.9,
            expand: false,
            builder: (context, scrollController) => Column(
              children: [
                AppBar(
                  title: Text(event.eventType),
                  automaticallyImplyLeading: false,
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.copy),
                      onPressed: () async {
                        await Clipboard.setData(
                          ClipboardData(text: prettyPayload),
                        );
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('コピーしました')),
                          );
                        }
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    controller: scrollController,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _DetailRow('ID', '${event.id}'),
                        _DetailRow('Type', event.eventType),
                        _DetailRow('Time', time.toIso8601String()),
                        _DetailRow('Event ID', event.eventId ?? '(null)'),
                        _DetailRow('Synced', event.synced ? 'Yes' : 'No'),
                        const SizedBox(height: 12),
                        Text(
                          'Payload:',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        const SizedBox(height: 4),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: context.designSystem.colorTheme.surfaceContainerHighest,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: SelectableText(
                            prettyPayload,
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontFamily: 'monospace',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow(this.label, this.value);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(
                color: context.designSystem.colorTheme.outline,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: theme.textTheme.bodySmall?.copyWith(
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
