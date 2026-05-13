import 'package:collection/collection.dart';
import 'package:eqmonitor/core/component/error/error_card.dart';
import 'package:eqmonitor/core/component/widget/app_empty_state.dart';
import 'package:eqmonitor/core/extension/let_ex.dart';
import 'package:eqmonitor/feature/eew/data/eew_by_event_id.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_display_mode.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:eqmonitor/feature/eew/ui/components/eew_details_map_view.dart';
import 'package:eqmonitor/feature/eew/ui/components/eew_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';
import 'package:skeletonizer/skeletonizer.dart';

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
            return const AppEmptyState(
              message: 'EEW情報はありません',
              icon: Icons.warning_amber_outlined,
            );
          }
          final sortedEews = eews.sorted(
            (a, b) => a.serialNo.compareTo(b.serialNo),
          );

          final idx = selectedIndex.value;
          final selectedEew =
              (idx != null && idx < sortedEews.length)
              ? sortedEews[idx]
              : null;

          return _ResponsiveLayout(
            eews: sortedEews,
            selectedIndex: selectedIndex.value,
            onSelect: (index) => selectedIndex.value = index,
            selectedEew: selectedEew,
            displayMode: displayMode.value,
            initialCenter:
                eews
                    .map((eew) => eew.hypocenter)
                    .nonNulls
                    .where((h) => h.hasLatLng)
                    .firstOrNull
                    ?.let(
                      (h) => Geographic(
                        lat: h.latitude!,
                        lon: h.longitude!,
                      ),
                    ) ??
                const Geographic(lat: 35.6895, lon: 139.6917),
            initZoom: 5,
          );
        },
        loading: () => const _EewDetailsByEventIdSkeleton(),
        error: (error, stack) => ErrorCard(
          error: error,
          onReload: () async => ref.refresh(eewsByEventIdProvider(eventId)),
        ),
      ),
    );
  }
}

class _EewDetailsByEventIdSkeleton extends StatelessWidget {
  const _EewDetailsByEventIdSkeleton();

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: ListView(
        children: [
          for (final i in List.generate(3, (i) => i))
            ListTile(
              leading: const CircleAvatar(radius: 16),
              title: Text('第${i + 1}報'),
              subtitle: const Text('2026/04/21 12:34:56'),
              trailing: const Text('M5.5'),
            ),
        ],
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
    required this.initialCenter,
    required this.initZoom,
  });

  final List<EewTelegramItem> eews;
  final int? selectedIndex;
  final void Function(int) onSelect;
  final EewTelegramItem? selectedEew;
  final EewDisplayMode displayMode;
  final Geographic initialCenter;
  final double initZoom;

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
          selectedEew: selectedEew,
          displayMode: displayMode,
          initialCenter: initialCenter,
          initZoom: initZoom,
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
