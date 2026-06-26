// ignore_for_file: avoid_eqmonitor_api_in_ui
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/feature/tsunami/ui/utils/tsunami_warning_color.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TsunamiWarningHistoryButton extends StatefulWidget {
  const TsunamiWarningHistoryButton({required this.tsunami, super.key});

  final TsunamiState tsunami;

  @override
  State<TsunamiWarningHistoryButton> createState() =>
      _TsunamiWarningHistoryButtonState();
}

class _TsunamiWarningHistoryButtonState
    extends State<TsunamiWarningHistoryButton> {
  final _overlayController = OverlayPortalController();
  final _link = LayerLink();

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _link,
      child: OverlayPortal(
        controller: _overlayController,
        overlayChildBuilder: (context) {
          return _HistoryOverlay(
            link: _link,
            tsunami: widget.tsunami,
            onDismiss: _overlayController.hide,
          );
        },
        child: IconButton(
          icon: const Icon(Icons.history),
          color: Colors.white,
          onPressed: () {
            if (_overlayController.isShowing) {
              _overlayController.hide();
            } else {
              _overlayController.show();
            }
          },
        ),
      ),
    );
  }
}

class _HistoryOverlay extends StatelessWidget {
  const _HistoryOverlay({
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
    final color = designSystem.color;

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
                side: BorderSide(color: color.outlineSoft),
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
          ..sort((a, b) => a.pressedAt.compareTo(b.pressedAt));

    if (vtse41Telegrams.isEmpty) {
      return [];
    }

    final entries = <_WarningTimelineEntry>[];

    for (final telegram in vtse41Telegrams) {
      final pressAt = telegram.pressedAt;
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
  const _WarningTimelineEntry({
    required this.time,
    required this.description,
    required this.isLast,
  });

  final DateTime time;
  final String description;
  final bool isLast;
}

class _TimelineEntry extends StatelessWidget {
  const _TimelineEntry({required this.entry});

  final _WarningTimelineEntry entry;

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final colorScheme = Theme.of(context).colorScheme;
    final timeStr = DateFormat('yyyy/MM/dd HH:mm').format(
      entry.time.toLocal(),
    );

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
                        ? designSystem.textColor.tertiary
                        : colorScheme.primary,
                    border: Border.all(
                      color: entry.isLast
                          ? designSystem.textColor.tertiary
                          : colorScheme.primary,
                      width: 2,
                    ),
                  ),
                ),
                if (!entry.isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      color: designSystem.textColor.tertiary.withValues(
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
                      color: designSystem.textColor.secondary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    entry.description,
                    style: const TextStyle(fontSize: 14),
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
