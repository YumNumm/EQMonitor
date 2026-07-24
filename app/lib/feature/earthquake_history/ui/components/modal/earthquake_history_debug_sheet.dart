import 'dart:math' as math;

import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
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

  Future<void> show({
    required BuildContext context,
    required Earthquake current,
  }) {
    final size = MediaQuery.sizeOf(context);
    if (size.width >= 840) {
      return showDialog<void>(
        context: context,
        builder: (context) => Dialog(
          clipBehavior: Clip.antiAlias,
          child: SizedBox(
            width: math.min(size.width * 0.8, 960),
            height: size.height * 0.9,
            child: EarthquakeHistoryDebugSheet(current: current),
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
        child: EarthquakeHistoryDebugSheet(current: current),
      ),
    );
  }
}

class EarthquakeHistoryDebugSheet extends ConsumerWidget {
  const EarthquakeHistoryDebugSheet({required this.current, super.key});

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
              TextButton(
                key: const Key('earthquake-debug-reset-button'),
                onPressed: () => ref
                    .read(earthquakeVxseDebugActionProvider)
                    .reset(ref: ref, current: current),
                child: const Text('リセット'),
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
              EarthquakeVxseDebugEditor(current: current),
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
