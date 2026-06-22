// ignore_for_file: avoid_eqmonitor_api_in_ui
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/gen/fonts.gen.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_event.dart';
import 'package:eqmonitor/feature/shake_detection/data/provider/shake_detection_history_provider.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class ShakeDetectionHistoryPage extends ConsumerWidget {
  const ShakeDetectionHistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final events = ref.watch(shakeDetectionHistoryProvider);
    final ds = context.designSystem;

    return Scaffold(
      backgroundColor: ds.color.backgroundDefault,
      appBar: AppBar(
        backgroundColor: ds.color.backgroundDefault,
        title: const Text('揺れ検知履歴'),
      ),
      body: events.isEmpty
          ? _EmptyState(ds: ds)
          : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: events.length,
              itemBuilder: (context, index) {
                final event = events[index];
                return _ShakeDetectionHistoryTile(
                  event: event,
                  onTap: () => ShakeDetectionHistoryDetailsRoute(
                    eventId: event.eventId,
                    $extra: event,
                  ).push<void>(context),
                );
              },
            ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.ds});

  final dynamic ds;

  @override
  Widget build(BuildContext context) {
    final ds = context.designSystem;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.sensors_off_rounded,
            size: 48,
            color: ds.textColor.tertiary,
          ),
          const SizedBox(height: 12),
          Text(
            '履歴なし',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: ds.textColor.secondary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'このセッション中に揺れ検知イベントが\n受信されていません',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: ds.textColor.tertiary,
            ),
          ),
        ],
      ),
    );
  }
}

class _ShakeDetectionHistoryTile extends StatelessWidget {
  const _ShakeDetectionHistoryTile({
    required this.event,
    required this.onTap,
  });

  final ShakeDetectionEvent event;
  final VoidCallback onTap;

  static final _timeFormat = DateFormat('MM/dd HH:mm:ss', 'ja');

  @override
  Widget build(BuildContext context) {
    final ds = context.designSystem;
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: ds.color.surfaceCard,
        borderRadius: BorderRadius.circular(ds.shape.card),
        child: InkWell(
          borderRadius: BorderRadius.circular(ds.shape.card),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                _LevelBadge(level: event.level),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            _timeFormat.format(event.createdAt.toLocal()),
                            style: theme.textTheme.titleSmall?.copyWith(
                              color: ds.textColor.primary,
                              fontFamily: FontFamily.googleSansCode,
                            ),
                          ),
                          if (event.isReplay) ...[
                            const SizedBox(width: 6),
                            _TagChip(
                              label: 'リプレイ',
                              color: ds.color.surfaceEmphasis,
                            ),
                          ],
                          if (event.mergedEewEventId != null) ...[
                            const SizedBox(width: 6),
                            _TagChip(
                              label: 'EEW結合済',
                              color: theme.colorScheme.secondaryContainer,
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${event.pointCount} 点  '
                        '${event.minLat.toStringAsFixed(2)}–${event.maxLat.toStringAsFixed(2)}°N  '
                        '${event.minLng.toStringAsFixed(2)}–${event.maxLng.toStringAsFixed(2)}°E',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: ds.textColor.tertiary,
                          fontFamily: FontFamily.googleSansCode,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right_rounded,
                  color: ds.textColor.tertiary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LevelBadge extends StatelessWidget {
  const _LevelBadge({required this.level});

  final ShakeDetectionLevel level;

  static Color _colorForLevel(ShakeDetectionLevel level) {
    return switch (level) {
      ShakeDetectionLevel.weaker => const Color(0xFF88CCFF),
      ShakeDetectionLevel.weak => const Color(0xFF44AAFF),
      ShakeDetectionLevel.medium => const Color(0xFFFFDD44),
      ShakeDetectionLevel.strong => const Color(0xFFFF8800),
      ShakeDetectionLevel.stronger => const Color(0xFFFF2200),
    };
  }

  static String _labelForLevel(ShakeDetectionLevel level) {
    return switch (level) {
      ShakeDetectionLevel.weaker => '微弱',
      ShakeDetectionLevel.weak => '弱',
      ShakeDetectionLevel.medium => '中',
      ShakeDetectionLevel.strong => '強',
      ShakeDetectionLevel.stronger => '強烈',
    };
  }

  @override
  Widget build(BuildContext context) {
    final color = _colorForLevel(level);
    final isDark = color.computeLuminance() > 0.4;
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      alignment: Alignment.center,
      child: Text(
        _labelForLevel(level),
        style: TextStyle(
          color: isDark ? Colors.black87 : color,
          fontWeight: FontWeight.w700,
          fontSize: 13,
        ),
      ),
    );
  }
}

class _TagChip extends StatelessWidget {
  const _TagChip({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: Theme.of(context).colorScheme.onSecondaryContainer,
        ),
      ),
    );
  }
}
