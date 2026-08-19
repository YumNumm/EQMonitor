import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/model/telegram/telegram_type.dart';
import 'package:eqmonitor/feature/tsunami/data/model/tsunami_state.dart';
import 'package:eqmonitor/feature/tsunami/ui/utils/tsunami_warning_color.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:intl/intl.dart';

class TsunamiWarningHistoryButton extends HookWidget {
  const new({required this.tsunami, super.key});

  final TsunamiState tsunami;

  @override
  Widget build(BuildContext context) {
    final overlayController = useMemoized(OverlayPortalController.new);
    final link = useMemoized(LayerLink.new);

    return CompositedTransformTarget(
      link: link,
      child: OverlayPortal(
        controller: overlayController,
        overlayChildBuilder: (context) {
          return _HistoryOverlay(
            link: link,
            tsunami: tsunami,
            onDismiss: overlayController.hide,
          );
        },
        child: IconButton(
          icon: const Icon(Icons.history),
          color: Colors.white,
          onPressed: () {
            if (overlayController.isShowing) {
              overlayController.hide();
            } else {
              overlayController.show();
            }
          },
        ),
      ),
    );
  }
}

class _HistoryOverlay extends StatelessWidget {
  const new({
    required this.link,
    required this.tsunami,
    required this.onDismiss,
  });

  final LayerLink link;
  final TsunamiState tsunami;
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final colorTheme = designSystem.colorTheme;

    final entries = _buildTimelineEntries(tsunami);
    final maxKind = TsunamiWarningColor.resolveMaxKind(tsunami.regions);
    final title = tsunami.isCanceled
        ? '${TsunamiWarningColor.displayName(maxKind)} 解除済み'
        : '${TsunamiWarningColor.displayName(maxKind)} が発表中';

    return Stack(
      children: [
        Positioned.fill(
          child: GestureDetector(
            onTap: onDismiss,
            behavior: HitTestBehavior.opaque,
            child: const ColoredBox(color: Colors.transparent),
          ),
        ),
        CompositedTransformFollower(
          link: link,
          targetAnchor: Alignment.bottomRight,
          followerAnchor: Alignment.topRight,
          offset: const Offset(0, 8),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 320),
            child: Card(
              elevation: 8,
              shape: RoundedSuperellipseBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: colorTheme.outlineVariant),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    for (final entry in entries) _TimelineEntry(entry: entry),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  static List<_WarningTimelineEntry> _buildTimelineEntries(
    TsunamiState tsunami,
  ) {
    final vtse41Telegrams =
        tsunami.latestTelegrams
            .where((t) => t.type == TelegramType.vtse41)
            .toList()
          ..sort((a, b) => a.publishedAt.compareTo(b.publishedAt));

    if (vtse41Telegrams.isEmpty) {
      return [];
    }

    final entries = <_WarningTimelineEntry>[];

    for (final telegram in vtse41Telegrams) {
      final pressAt = telegram.publishedAt;
      final description = telegram.headline ?? telegram.title;

      entries.add(
        _WarningTimelineEntry(
          time: pressAt,
          description: description,
          isLast: false,
        ),
      );
    }

    if (entries.isNotEmpty) {
      entries.last = _WarningTimelineEntry(
        time: entries.last.time,
        description: entries.last.description,
        isLast: true,
      );
    }

    return entries;
  }
}

class _WarningTimelineEntry {
  const new({
    required this.time,
    required this.description,
    required this.isLast,
  });

  final DateTime time;
  final String description;
  final bool isLast;
}

class _TimelineEntry extends StatelessWidget {
  const new({required this.entry});

  final _WarningTimelineEntry entry;

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final colorTheme = context.designSystem.colorTheme;
    final timeStr = DateFormat('yyyy/MM/dd HH:mm').format(entry.time.toLocal());

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 20,
            child: Column(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  margin: const EdgeInsets.only(top: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: entry.isLast
                        ? designSystem.colorTheme.outline
                        : colorTheme.primary,
                    border: Border.all(
                      color: entry.isLast
                          ? designSystem.colorTheme.outline
                          : colorTheme.primary,
                      width: 2,
                    ),
                  ),
                ),
                if (!entry.isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      color: designSystem.colorTheme.outline.withValues(
                        alpha: 0.3,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$timeStrごろ',
                    style: TextStyle(
                      fontSize: 12,
                      color: designSystem.colorTheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(entry.description, style: const TextStyle(fontSize: 14)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
