import 'package:collection/collection.dart';
import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/core/component/error/error_card.dart';
import 'package:eqmonitor/feature/eew/data/eew_by_event_id.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_display_mode.dart';
import 'package:eqmonitor/feature/eew/ui/components/eew_details_map_view.dart';
import 'package:eqmonitor/feature/eew/ui/components/eew_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EewDetailsByEventIdPage extends HookConsumerWidget {
  const EewDetailsByEventIdPage({required this.eventId, super.key});

  final String eventId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eewsAsyncValue = ref.watch(eewsByEventIdProvider(eventId));
    final selectedIndex = useState<int?>(null);
    final displayMode = useState(EewDisplayMode.intensity);

    return Scaffold(
      appBar: AppBar(
        title: const Text('緊急地震速報の履歴'),
        actions: [
          _DisplayModeSelector(
            displayMode: displayMode.value,
            onChanged: (mode) => displayMode.value = mode,
          ),
        ],
      ),
      body: eewsAsyncValue.when(
        data: (eews) {
          if (eews.isEmpty) {
            return const Center(child: Text('データがありません'));
          }
          final sortedEews = eews.sorted(
            (a, b) => a.serialNo.compareTo(b.serialNo),
          );

          final selectedEew = selectedIndex.value != null &&
                  selectedIndex.value! < sortedEews.length
              ? sortedEews[selectedIndex.value!]
              : null;

          return _ResponsiveLayout(
            eews: sortedEews,
            selectedIndex: selectedIndex.value,
            onSelect: (index) => selectedIndex.value = index,
            selectedEew: selectedEew,
            displayMode: displayMode.value,
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => ErrorCard(
          error: error,
          onReload: () async => ref.refresh(eewsByEventIdProvider(eventId)),
        ),
      ),
    );
  }
}

class _DisplayModeSelector extends StatelessWidget {
  const _DisplayModeSelector({
    required this.displayMode,
    required this.onChanged,
  });

  final EewDisplayMode displayMode;
  final void Function(EewDisplayMode) onChanged;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<EewDisplayMode>(
      segments: const [
        ButtonSegment(
          value: EewDisplayMode.intensity,
          icon: Icon(Icons.layers),
          label: Text('震度'),
        ),
        ButtonSegment(
          value: EewDisplayMode.warning,
          icon: Icon(Icons.warning_amber),
          label: Text('警報'),
        ),
      ],
      selected: {displayMode},
      onSelectionChanged: (selected) => onChanged(selected.first),
      showSelectedIcon: false,
    );
  }
}

class _ResponsiveLayout extends StatelessWidget {
  const _ResponsiveLayout({
    required this.eews,
    required this.selectedIndex,
    required this.onSelect,
    required this.selectedEew,
    required this.displayMode,
  });

  final List<EewItemWithRelations> eews;
  final int? selectedIndex;
  final void Function(int) onSelect;
  final EewItemWithRelations? selectedEew;
  final EewDisplayMode displayMode;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isLandscape = constraints.maxWidth > constraints.maxHeight;

        final tableWidget = EewTable(
          eews: eews,
          selectedIndex: selectedIndex,
          onSelect: onSelect,
        );

        final mapWidget = EewDetailsMapView(
          eew: selectedEew,
          displayMode: displayMode,
        );

        if (isLandscape) {
          return Row(
            children: [
              Expanded(child: tableWidget),
              Expanded(child: mapWidget),
            ],
          );
        }

        return Column(
          children: [
            Expanded(child: tableWidget),
            Expanded(child: mapWidget),
          ],
        );
      },
    );
  }
}
