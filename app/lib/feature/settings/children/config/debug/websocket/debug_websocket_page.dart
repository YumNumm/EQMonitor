import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/gen/fonts.gen.dart';
import 'package:eqmonitor/core/realtime/data_source/eqmonitor/eqmonitor_ws_ping_probe.dart';
import 'package:eqmonitor/core/realtime/data_source/eqmonitor/eqmonitor_ws_status_notifier.dart';
import 'package:eqmonitor/core/realtime/data_source/eqmonitor/eqmonitor_ws_status_state.dart';
import 'package:eqmonitor/core/realtime/model/realtime_event.dart';
import 'package:eqmonitor/core/realtime/realtime_event_provider.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DebugWebSocketPage extends HookConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messages = useState<List<({DateTime at, RealtimeEvent event})>>([]);
    final wsStatus = ref.watch(eqMonitorWsStatusProvider);
    // この画面を開いている間だけクライアント起因 ping を送出して RTT を測る。
    final rtt = ref.watch(eqmonitorWsPingProbeProvider);

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
            onPressed: () {
              ref
                ..invalidate(eqMonitorWsStatusProvider, asReload: true)
                ..invalidate(eqmonitorWsPingProbeProvider, asReload: true);
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _WsStatusCard(wsStatus: wsStatus, rtt: rtt),
          const Divider(height: 1),
          Expanded(
            child: messages.value.isEmpty
                ? const Center(child: Text('受信メッセージはまだありません'))
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: messages.value.length,
                    itemBuilder: (context, index) {
                      final e = messages.value[index];
                      return _WsEventCard(receivedAt: e.at, event: e.event);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _WsStatusCard extends HookWidget {
  const new({required this.wsStatus, required this.rtt});

  final EqMonitorWsStatusState wsStatus;
  final WsRttSample? rtt;

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
      WsPhase.connecting => context.designSystem.colorTheme.secondary,
      WsPhase.connected => context.designSystem.colorTheme.primary,
      WsPhase.disconnected => context.designSystem.colorTheme.error,
    };

    final now = DateTime.now();

    final lastPingAt = wsStatus.lastPingAt;
    final interval = wsStatus.serverPingInterval;
    final serverPingLabel = switch ((lastPingAt, interval)) {
      (null, _) => 'なし',
      (final at?, null) => _elapsedLabel(now.difference(at)),
      (final at?, final i?) =>
        '${_elapsedLabel(now.difference(at))} (間隔 ${i.inMilliseconds}ms)',
    };

    // 応答が返るまで、または pong を返さないサーバーでは null のまま。
    final rttLabel = switch (rtt) {
      null => '計測中…',
      final sample =>
        '${sample.rtt.inMilliseconds}ms '
            '(${_elapsedLabel(now.difference(sample.measuredAt))})',
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
              Text(statusLabel, style: theme.textTheme.titleMedium),
            ],
          ),
          if (wsStatus.currentUrl case final currentUrl?) ...[
            const SizedBox(height: 8),
            SelectableText(
              currentUrl,
              style: theme.textTheme.bodySmall?.copyWith(
                fontFamily: FontFamily.googleSansCode,
              ),
            ),
          ],
          const SizedBox(height: 4),
          Text('RTT: $rttLabel', style: theme.textTheme.bodySmall),
          const SizedBox(height: 2),
          Text(
            'サーバー ping 受信: $serverPingLabel',
            style: theme.textTheme.bodySmall,
          ),
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
  const new({required this.receivedAt, required this.event});

  final DateTime receivedAt;
  final RealtimeEvent event;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final displayType = switch (event) {
      RealtimeReadyEvent() => 'ready',
      RealtimeEewUpsertEvent() => 'eew/upsert',
      RealtimeEarthquakeUpsertEvent() => 'earthquake/upsert',
      RealtimeEarthquakeDeleteEvent() => 'earthquake/delete',
      RealtimeTsunamiUpsertEvent() => 'tsunami/upsert',
      RealtimeTsunamiDeleteEvent() => 'tsunami/delete',
      RealtimeShakeSnapshotEvent() => 'shake_detection/snapshot',
      RealtimeEstimatedIntensityUpsertEvent() => 'estimated_intensity/upsert',
    };

    final detail = switch (event) {
      RealtimeReadyEvent(:final source) => 'source=$source',
      RealtimeEewUpsertEvent(:final record) => 'eventId=${record.eventId}',
      RealtimeEarthquakeUpsertEvent(:final record) =>
        'eventId=${record.eventId}',
      RealtimeEarthquakeDeleteEvent(:final eventId) => 'eventId=$eventId',
      RealtimeTsunamiUpsertEvent(:final eventId, :final groupId) =>
        'eventId=$eventId groupId=$groupId',
      RealtimeTsunamiDeleteEvent(:final eventId, :final groupId) =>
        'eventId=$eventId groupId=$groupId',
      RealtimeShakeSnapshotEvent(:final record) =>
        'revision=${record.revision} events=${record.events.length}',
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
