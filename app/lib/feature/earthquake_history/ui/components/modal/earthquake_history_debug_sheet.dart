import 'dart:math' as math;

import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_details_notifier.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/action/earthquake_vxse_debug_action.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/modal/earthquake_history_debug_modal.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/modal/earthquake_vxse_debug_editor.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final earthquakeHistoryDebugSheetActionProvider = Provider(
  (ref) => const EarthquakeHistoryDebugSheetAction(),
);

class EarthquakeHistoryDebugSheetAction {
  const EarthquakeHistoryDebugSheetAction();

  Future<void> show({required BuildContext context, required String eventId}) {
    final size = MediaQuery.sizeOf(context);
    if (size.width >= 840) {
      return showDialog<void>(
        context: context,
        builder: (context) => Dialog(
          clipBehavior: Clip.antiAlias,
          child: SizedBox(
            width: math.min(size.width * 0.8, 960),
            height: size.height * 0.9,
            child: EarthquakeHistoryDebugSheet(eventId: eventId),
          ),
        ),
      );
    }
    return showModalBottomSheet<void>(
      context: context,
      clipBehavior: Clip.antiAlias,
      isScrollControlled: true,
      builder: (context) => FractionallySizedBox(
        heightFactor: 0.9,
        child: EarthquakeHistoryDebugSheet(eventId: eventId),
      ),
    );
  }
}

class EarthquakeHistoryDebugSheet extends ConsumerWidget {
  const EarthquakeHistoryDebugSheet({required this.eventId, super.key});

  final String eventId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final details = ref.watch(earthquakeHistoryDetailsProvider(eventId));
    return switch (details) {
      AsyncValue(:final value?) => _EarthquakeHistoryDebugSheetContent(
        current: value,
      ),
      AsyncError() => const Center(child: Text('地震情報を読み込めませんでした')),
      _ => const Center(child: CircularProgressIndicator.adaptive()),
    };
  }
}

class _EarthquakeHistoryDebugSheetContent extends ConsumerWidget {
  const _EarthquakeHistoryDebugSheetContent({required this.current});

  final Earthquake current;

  @override
  Widget build(BuildContext context, WidgetRef ref) => DefaultTabController(
    length: 2,
    child: Column(
      children: [
        const _SheetHandle(),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 4, 8, 4),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  '地震詳細 Debug',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        const TabBar(
          tabs: [
            Tab(text: '地震情報'),
            Tab(text: 'マップレイヤー'),
          ],
        ),
        Expanded(
          child: TabBarView(
            children: [
              Column(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: TextButton(
                        key: const Key('earthquake-debug-reset-button'),
                        onPressed: () => ref
                            .read(earthquakeVxseDebugActionProvider)
                            .reset(ref: ref, current: current),
                        child: const Text('地震情報をリセット'),
                      ),
                    ),
                  ),
                  Expanded(child: EarthquakeVxseDebugEditor(current: current)),
                ],
              ),
              const EarthquakeHistoryDebugModal(),
            ],
          ),
        ),
      ],
    ),
  );
}

class _SheetHandle extends StatelessWidget {
  const _SheetHandle();

  @override
  Widget build(BuildContext context) => Center(
    child: Container(
      margin: const EdgeInsets.only(top: 8, bottom: 4),
      width: 36,
      height: 4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        color: context.designSystem.colorTheme.onSurface.withValues(alpha: 0.3),
      ),
    ),
  );
}
