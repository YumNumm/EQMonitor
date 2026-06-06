import 'package:eqmonitor/core/gen/fonts.gen.dart';
import 'package:eqmonitor/core/realtime/data_source/eqmonitor/eqmonitor_ws_status_notifier.dart';
import 'package:eqmonitor/core/realtime/data_source/eqmonitor/eqmonitor_ws_status_state.dart';
import 'package:eqmonitor/core/realtime/model/realtime_event.dart';
import 'package:eqmonitor/core/realtime/realtime_event_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DebugWebSocketPage extends HookConsumerWidget {
  const DebugWebSocketPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messages = useState<List<({DateTime at, RealtimeEvent event})>>([]);
    final wsStatus = ref.watch(eqMonitorWsStatusProvider);

    ref.listen(realtimeEventsProvider, (_, next) {
      next.whenData((event) {
        final nextList = [
          (at: DateTime.now(), event: event),
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
            onPressed: () => ref.invalidate(eqMonitorWsStatusProvider, asReload: true),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _WsStatusCard(wsStatus: wsStatus),
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
                      return _WsEventCard(
                        receivedAt: e.at,
                        event: e.event,
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
  const _WsStatusCard({required this.wsStatus});

  final EqMonitorWsStatusState wsStatus;

  @override
  Widget build(BuildContext context) {
    // Rebuild every second to update elapsed-since-ping display
    useStream(
      Stream.periodic(const Duration(seconds: 1), (i) => i),
      initialData: 0,
    );

    final theme = Theme.of(context);
    final statusLabel = switch (wsStatus.phase) {
      WsPhase.connecting => '接続中',
      WsPhase.connected => '接続済み',
      WsPhase.disconnected => '切断',
    };
    final statusColor = switch (wsStatus.phase) {
      WsPhase.connecting => theme.colorScheme.secondary,
      WsPhase.connected => theme.colorScheme.primary,
      WsPhase.disconnected => theme.colorScheme.error,
    };

    final pingLabel = wsStatus.lastPingAt == null
        ? 'なし'
        : _elapsedLabel(DateTime.now().difference(wsStatus.lastPingAt!));

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
          if (wsStatus.currentUrl != null) ...[
            const SizedBox(height: 8),
            SelectableText(
              wsStatus.currentUrl!,
              style: theme.textTheme.bodySmall?.copyWith(
                fontFamily: FontFamily.googleSansCode,
              ),
            ),
          ],
          const SizedBox(height: 4),
          Text('最終 ping: $pingLabel', style: theme.textTheme.bodySmall),
          if (wsStatus.pingRtt != null) ...[
            const SizedBox(height: 2),
            Text(
              'Ping RTT: ${wsStatus.pingRtt!.inMilliseconds}ms',
              style: theme.textTheme.bodySmall,
            ),
          ],
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

class _WsEventCard extends StatelessWidget {
  const _WsEventCard({
    required this.receivedAt,
    required this.event,
  });

  final DateTime receivedAt;
  final RealtimeEvent event;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final displayType = switch (event) {
      RealtimeSnapshotEvent() => 'snapshot',
      RealtimeEewUpsertEvent() => 'eew/upsert',
      RealtimeEarthquakeUpsertEvent() => 'earthquake/upsert',
      RealtimeEarthquakeDeleteEvent() => 'earthquake/delete',
      RealtimeShakeDetectedEvent() => 'shake_detected',
      RealtimeEstimatedIntensityUpsertEvent() => 'estimated_intensity/upsert',
    };

    final detail = switch (event) {
      RealtimeSnapshotEvent(:final eews, :final earthquakes, :final shakes) =>
        'eews=${eews.length} earthquakes=${earthquakes.length} shakes=${shakes.length}',
      RealtimeEewUpsertEvent(:final item) => 'eventId=${item.eventId}',
      RealtimeEarthquakeUpsertEvent(:final record) =>
        'eventId=${record.eventId}',
      RealtimeEarthquakeDeleteEvent(:final eventId) => 'eventId=$eventId',
      RealtimeShakeDetectedEvent(:final data) => 'eventId=${data.eventId}',
      RealtimeEstimatedIntensityUpsertEvent(:final eventId) =>
        'eventId=$eventId',
    };

    final timeStr =
        '${receivedAt.hour.toString().padLeft(2, '0')}:'
        '${receivedAt.minute.toString().padLeft(2, '0')}:'
        '${receivedAt.second.toString().padLeft(2, '0')}.'
        '${receivedAt.millisecond.toString().padLeft(3, '0')}';

    final copyText = '[$timeStr] $displayType $detail';

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: InkWell(
        onTap: () async => Clipboard.setData(ClipboardData(text: copyText)),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(displayType, style: theme.textTheme.titleSmall),
                    const SizedBox(height: 4),
                    Text(
                      detail,
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontFamily: FontFamily.googleSansCode,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                timeStr,
                style: theme.textTheme.labelSmall?.copyWith(
                  fontFamily: FontFamily.googleSansCode,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
