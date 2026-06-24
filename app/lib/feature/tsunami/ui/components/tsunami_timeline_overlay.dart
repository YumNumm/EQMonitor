// ignore_for_file: avoid_eqmonitor_api_in_ui
import 'dart:async';

import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/feature/tsunami/data/notifier/tsunami_playback_selection_notifier.dart';
import 'package:eqmonitor/feature/tsunami/data/notifier/tsunami_telegrams_provider.dart';
import 'package:eqmonitor/feature/tsunami/ui/components/tsunami_warning_legend.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class TsunamiTimelineOverlay extends ConsumerWidget {
  const TsunamiTimelineOverlay({required this.tsunamiId, super.key});

  final String tsunamiId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final telegramsAsync = ref.watch(tsunamiTelegramsProvider(tsunamiId));

    return switch (telegramsAsync) {
      AsyncLoading() => const SizedBox.shrink(),
      AsyncError(:final error) => _buildErrorIndicator(context, error),
      AsyncData(value: final telegrams) when telegrams.isEmpty =>
        const SizedBox.shrink(),
      AsyncData(value: final telegrams) => _buildOverlay(
          context,
          ref,
          telegrams,
        ),
    };
  }

  Widget _buildErrorIndicator(BuildContext context, Object error) {
    final designSystem = context.designSystem;
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: designSystem.color.surfaceCard.withValues(alpha: 0.95),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: designSystem.color.outlineSoft),
          ),
          child: Text(
            'Timeline: $error',
            style: TextStyle(
              fontSize: 10,
              color: designSystem.textColor.secondary,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }

  Widget _buildOverlay(
    BuildContext context,
    WidgetRef ref,
    List<TsunamiTelegramWithState> telegrams,
  ) {
    final selection = ref.watch(tsunamiPlaybackSelectionProvider);

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) => SizeTransition(
            sizeFactor: animation,
            alignment: Alignment.bottomCenter,
            child: FadeTransition(opacity: animation, child: child),
          ),
          child: selection.isExpanded
              ? _ExpandedOverlay(
                  key: const ValueKey('expanded'),
                  tsunamiId: tsunamiId,
                  telegrams: telegrams,
                  selection: selection,
                  ref: ref,
                )
              : _CollapsedOverlay(
                  key: const ValueKey('collapsed'),
                  telegrams: telegrams,
                  selection: selection,
                  ref: ref,
                ),
        ),
      ),
    );
  }
}

class _ExpandedOverlay extends StatelessWidget {
  const _ExpandedOverlay({
    required this.tsunamiId,
    required this.telegrams,
    required this.selection,
    required this.ref,
    super.key,
  });

  final String tsunamiId;
  final List<TsunamiTelegramWithState> telegrams;
  final TsunamiPlaybackSelectionState selection;
  final WidgetRef ref;

  int get _effectiveIndex => selection.selectedIndex ?? telegrams.length - 1;

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final color = designSystem.color;

    final currentTelegram = telegrams[_effectiveIndex].telegram;
    final maxIndex = telegrams.length - 1;
    final isAtStart = _effectiveIndex <= 0;
    final isAtEnd = selection.selectedIndex == null;

    return Container(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
      decoration: BoxDecoration(
        color: color.surfaceCard.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.outlineSoft),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const TsunamiWarningLegend(),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      currentTelegram.title,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: designSystem.textColor.primary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      DateFormat('MM/dd HH:mm').format(
                        currentTelegram.pressedAt.toLocal(),
                      ),
                      style: TextStyle(
                        fontSize: 11,
                        color: designSystem.textColor.secondary,
                      ),
                    ),
                    if (selection.selectedIndex != null)
                      Text(
                        '${_effectiveIndex + 1} / ${telegrams.length}',
                        style: TextStyle(
                          fontSize: 10,
                          color: designSystem.textColor.secondary,
                        ),
                      )
                    else
                      Text(
                        '最新 (${telegrams.length}件)',
                        style: TextStyle(
                          fontSize: 10,
                          color: designSystem.textColor.secondary,
                        ),
                      ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.keyboard_arrow_down, size: 20),
                onPressed: () {
                  unawaited(HapticFeedback.selectionClick());
                  ref
                      .read(tsunamiPlaybackSelectionProvider.notifier)
                      .toggleExpanded();
                },
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(
                  minWidth: 32,
                  minHeight: 32,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.skip_previous_rounded, size: 24),
                onPressed: isAtStart
                    ? null
                    : () {
                        unawaited(HapticFeedback.selectionClick());
                        ref
                            .read(tsunamiPlaybackSelectionProvider.notifier)
                            .stepBackward(maxIndex);
                      },
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(
                  minWidth: 36,
                  minHeight: 36,
                ),
              ),
              Expanded(
                child: _TimeProportionalSlider(
                  telegrams: telegrams,
                  effectiveIndex: _effectiveIndex,
                  isLatest: selection.selectedIndex == null,
                  onChanged: (index) {
                    unawaited(HapticFeedback.selectionClick());
                    ref
                        .read(tsunamiPlaybackSelectionProvider.notifier)
                        .selectIndex(
                          index >= maxIndex ? null : index,
                        );
                  },
                ),
              ),
              IconButton(
                icon: const Icon(Icons.skip_next_rounded, size: 24),
                onPressed: isAtEnd
                    ? null
                    : () {
                        unawaited(HapticFeedback.selectionClick());
                        ref
                            .read(tsunamiPlaybackSelectionProvider.notifier)
                            .stepForward(maxIndex);
                      },
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(
                  minWidth: 36,
                  minHeight: 36,
                ),
              ),
            ],
          ),
          _TimeMarkers(telegrams: telegrams),
        ],
      ),
    );
  }
}

class _CollapsedOverlay extends StatelessWidget {
  const _CollapsedOverlay({
    required this.telegrams,
    required this.selection,
    required this.ref,
    super.key,
  });

  final List<TsunamiTelegramWithState> telegrams;
  final TsunamiPlaybackSelectionState selection;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final color = designSystem.color;

    final label = selection.selectedIndex != null
        ? '${selection.selectedIndex! + 1} / ${telegrams.length}'
        : '最新 (${telegrams.length}件)';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.surfaceCard.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.outlineSoft),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.timeline,
            size: 16,
            color: designSystem.textColor.secondary,
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: designSystem.textColor.primary,
            ),
          ),
          const SizedBox(width: 4),
          IconButton(
            icon: const Icon(Icons.keyboard_arrow_up, size: 20),
            onPressed: () {
              unawaited(HapticFeedback.selectionClick());
              ref
                  .read(tsunamiPlaybackSelectionProvider.notifier)
                  .toggleExpanded();
            },
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(
              minWidth: 28,
              minHeight: 28,
            ),
          ),
        ],
      ),
    );
  }
}

class _TimeProportionalSlider extends StatelessWidget {
  const _TimeProportionalSlider({
    required this.telegrams,
    required this.effectiveIndex,
    required this.isLatest,
    required this.onChanged,
  });

  final List<TsunamiTelegramWithState> telegrams;
  final int effectiveIndex;
  final bool isLatest;
  final ValueChanged<int> onChanged;

  double _indexToValue(int index) {
    if (telegrams.length <= 1) {
      return 0;
    }
    final first = telegrams.first.telegram.pressedAt;
    final last = telegrams.last.telegram.pressedAt;
    final totalMs = last.difference(first).inMilliseconds;
    if (totalMs == 0) {
      return index / (telegrams.length - 1);
    }
    final currentMs =
        telegrams[index].telegram.pressedAt.difference(first).inMilliseconds;
    return currentMs / totalMs;
  }

  int _valueToIndex(double value) {
    if (telegrams.length <= 1) {
      return 0;
    }
    final first = telegrams.first.telegram.pressedAt;
    final last = telegrams.last.telegram.pressedAt;
    final totalMs = last.difference(first).inMilliseconds;
    if (totalMs == 0) {
      return (value * (telegrams.length - 1)).round();
    }
    final targetMs = (value * totalMs).round();
    var closestIndex = 0;
    var closestDiff = double.infinity;
    for (var i = 0; i < telegrams.length; i++) {
      final diff = (telegrams[i]
                  .telegram
                  .pressedAt
                  .difference(first)
                  .inMilliseconds -
              targetMs)
          .abs()
          .toDouble();
      if (diff < closestDiff) {
        closestDiff = diff;
        closestIndex = i;
      }
    }
    return closestIndex;
  }

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        trackHeight: 4,
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
        overlayShape: const RoundSliderOverlayShape(overlayRadius: 16),
      ),
      child: Slider(
        value: _indexToValue(effectiveIndex),
        onChanged: (value) {
          final index = _valueToIndex(value);
          if (index != effectiveIndex) {
            onChanged(index);
          }
        },
      ),
    );
  }
}

class _TimeMarkers extends StatelessWidget {
  const _TimeMarkers({required this.telegrams});

  final List<TsunamiTelegramWithState> telegrams;

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final format = DateFormat('HH:mm');

    if (telegrams.length <= 1) {
      return const SizedBox.shrink();
    }

    final firstTime =
        format.format(telegrams.first.telegram.pressedAt.toLocal());
    final lastTime =
        format.format(telegrams.last.telegram.pressedAt.toLocal());

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            firstTime,
            style: TextStyle(
              fontSize: 9,
              color: designSystem.textColor.secondary,
            ),
          ),
          Text(
            '$lastTime (最新)',
            style: TextStyle(
              fontSize: 9,
              color: designSystem.textColor.secondary,
            ),
          ),
        ],
      ),
    );
  }
}
