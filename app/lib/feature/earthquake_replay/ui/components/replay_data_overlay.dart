import 'package:earthquake_replay/earthquake_replay.dart';
import 'package:eqmonitor/core/gen/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReplayDataOverlay extends StatelessWidget {
  const ReplayDataOverlay({
    required this.events,
    super.key,
  });

  final List<ReplayData> events;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      constraints: const BoxConstraints(maxWidth: 400, maxHeight: 300),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.list_alt,
                  size: 16,
                  color: colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'イベントログ (${events.length}件)',
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          if (events.isEmpty)
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                '周辺にイベントはありません',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            )
          else
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: events.map((e) => _EventTile(event: e)).toList(),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _EventTile extends StatelessWidget {
  const _EventTile({required this.event});

  final ReplayData event;

  static final _timeFormat = DateFormat('HH:mm:ss');

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final (icon, title, subtitle) = _getEventInfo(event);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: colorScheme.onSurfaceVariant),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      _timeFormat.format(event.time.toLocal()),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        title,
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                if (subtitle != null)
                  Text(
                    subtitle,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                      fontSize: 7,
                      fontFamily: FontFamily.googleSansCode,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  (IconData, String, String?) _getEventInfo(ReplayData event) {
    return switch (event) {
      JmaXmlTelegramReplayData(:final title, :final telegram) => (
        Icons.article,
        'JMA XML',
        '$title: $telegram',
      ),
      JmaBinaryTelegramReplayData(:final telegramType, :final data) => (
        Icons.data_object,
        'JMA Binary: $telegramType',
        '${data.length} bytes',
      ),
      KyoshinMonitorEewJsonReplayData(:final json) => (
        Icons.warning_amber,
        'KyoshinMonitor EEW',
        json,
      ),
      KeviJsonReplayData(:final jsonType, :final json) => (
        Icons.notifications_active,
        'KEVI: ${jsonType.name}',
        json,
      ),
      SnpLogEntryReplayData(:final message) => (
        Icons.message,
        'ログ',
        message,
      ),
      AxisJsonReplayData(:final json) => (
        Icons.analytics,
        'AXIS',
        json,
      ),
      KyoshinMonitorImageReplayData() => (
        Icons.image,
        '強震モニタ画像',
        null,
      ),
    };
  }
}
