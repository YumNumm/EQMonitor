import 'package:collection/collection.dart';
import 'package:eqmonitor/core/component/error/error_card.dart';
import 'package:eqmonitor/core/component/widget/app_empty_state.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/provider/estimated_intensity/provider/estimated_intensity_on_eew_replay_allowed_provider.dart';
import 'package:eqmonitor/core/provider/time_ticker.dart';
import 'package:eqmonitor/feature/eew/data/eew_by_event_id.dart';
import 'package:eqmonitor/feature/eew/data/eew_simulation_notifier.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_display_mode.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_estimated_region.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:eqmonitor/feature/eew/ui/components/eew_details_map_view.dart';
import 'package:eqmonitor/feature/eew/ui/components/eew_table.dart';
import 'package:eqmonitor/feature/eew/ui/hook/eew_estimated_regions_stale_cache_hook.dart';
import 'package:eqmonitor/feature/home/ui/component/eew/eew_card.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';
import 'package:material_ui/material_ui.dart';
import 'package:skeletonizer/skeletonizer.dart';

class EewDetailsByEventIdPage extends HookConsumerWidget {
  const new({required this.eventId, super.key});

  final String eventId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eewsAsyncValue = ref.watch(eewsByEventIdProvider(eventId));
    final simulation = ref.watch(eewSimulationProvider);
    final selectedIndex = useState<int?>(null);
    final displayMode = useState(EewDisplayMode.intensity);

    // Auto-select the latest report during simulation
    useEffect(() {
      if (simulation != null && simulation.isPlaying) {
        selectedIndex.value = simulation.currentIndex;
      }
      return null;
    }, [simulation?.currentIndex]);

    return Scaffold(
      appBar: AppBar(
        title: const Text('緊急地震速報の履歴'),
        actions: [
          if (simulation != null) ...[
            IconButton(
              icon: Icon(simulation.isPlaying ? Icons.pause : Icons.play_arrow),
              onPressed: () {
                if (simulation.isPlaying) {
                  ref.read(eewSimulationProvider.notifier).pause();
                } else {
                  ref.read(eewSimulationProvider.notifier).resume();
                }
              },
            ),
            IconButton(
              icon: const Icon(Icons.stop),
              onPressed: () => ref.read(eewSimulationProvider.notifier).stop(),
            ),
          ] else
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

          final displayedEews = simulation != null
              ? sortedEews.take(simulation.currentIndex + 1).toList()
              : sortedEews;

          final idx = selectedIndex.value;
          final selectedEew =
              (idx != null && idx >= 0 && idx < displayedEews.length)
              ? displayedEews[idx]
              : null;

          final initialCenter =
              eews
                  .map((eew) => eew.hypocenter)
                  .nonNulls
                  .map(
                    (h) => switch ((h.latitude, h.longitude)) {
                      (final lat?, final lon?) => Geographic(
                        lat: lat,
                        lon: lon,
                      ),
                      _ => null,
                    },
                  )
                  .nonNulls
                  .firstOrNull ??
              const Geographic(lat: 35.6895, lon: 139.6917);

          if (simulation != null) {
            return _SimulationView(
              selectedEew: selectedEew,
              displayMode: displayMode.value,
              initialCenter: initialCenter,
            );
          }

          return Column(
            children: [
              if (sortedEews.length > 1)
                _SimulationStartBanner(
                  onStart: () => ref
                      .read(eewSimulationProvider.notifier)
                      .start(sortedEews),
                ),
              Expanded(
                child: _ResponsiveLayout(
                  eews: displayedEews,
                  selectedIndex: selectedIndex.value,
                  onSelect: (index) => selectedIndex.value = index,
                  selectedEew: selectedEew,
                  displayMode: displayMode.value,
                  initialCenter: initialCenter,
                  initZoom: 5,
                ),
              ),
            ],
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

class _SimulationView extends HookConsumerWidget {
  const new({
    required this.selectedEew,
    required this.displayMode,
    required this.initialCenter,
  });

  final EewTelegramItem? selectedEew;
  final EewDisplayMode displayMode;
  final Geographic initialCenter;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final simulation = ref.watch(eewSimulationProvider);
    final currentEew = simulation?.currentReport ?? selectedEew;
    final isEstimatedAllowed =
        ref.watch(estimatedIntensityOnEewReplayAllowedProvider).value ?? false;

    // timeTickerProvider を watch して毎秒リビルドさせる
    ref.watch(timeTickerProvider());

    // シミュレーション仮想時刻: P/S波円と同じ計算
    DateTime? virtualNow;
    if (simulation != null) {
      final firstReportTime = simulation.reports.first.reportTime;
      final elapsed = DateTime.now().difference(simulation.startedAt);
      virtualNow = firstReportTime.add(elapsed);
    }

    final estimatedRegions = EewEstimatedRegionsStaleCacheHook.use(
      ref: ref,
      eew: currentEew,
      isEnabled: isEstimatedAllowed,
    );

    final additionalRegions = useMemoized(() {
      if (estimatedRegions == null || currentEew == null) {
        return null;
      }
      return estimatedRegions.additionalForecastRegionsFor(eew: currentEew);
    }, [estimatedRegions, currentEew]);

    return Stack(
      children: [
        Positioned.fill(
          child: EewDetailsMapView(
            selectedEew: currentEew,
            displayMode: displayMode,
            initialCenter: initialCenter,
            initZoom: 5,
            isSimulation: true,
            additionalRegions: additionalRegions,
          ),
        ),
        if (currentEew != null)
          Positioned(
            left: 8,
            right: 8,
            bottom: MediaQuery.of(context).padding.bottom + 8,
            child: EewCard(
              eew: currentEew,
              index: null,
              nowOverride: virtualNow,
              estimatedRegions: isEstimatedAllowed ? estimatedRegions : null,
            ),
          ),
      ],
    );
  }
}

class _EewDetailsByEventIdSkeleton extends StatelessWidget {
  const new();

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
  const new({required this.displayMode, required this.onChanged});

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

class _ResponsiveLayout extends HookConsumerWidget {
  const new({
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
  Widget build(BuildContext context, WidgetRef ref) {
    final isEstimatedAllowed =
        ref.watch(estimatedIntensityOnEewReplayAllowedProvider).value ?? false;

    final estimatedRegions = EewEstimatedRegionsStaleCacheHook.use(
      ref: ref,
      eew: selectedEew,
      isEnabled: isEstimatedAllowed,
    );

    final additionalRegions = useMemoized(() {
      final eew = selectedEew;
      if (estimatedRegions == null || eew == null) {
        return null;
      }
      return estimatedRegions.additionalForecastRegionsFor(eew: eew);
    }, [estimatedRegions, selectedEew]);

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
          additionalRegions: additionalRegions,
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

class _SimulationStartBanner extends StatelessWidget {
  const new({required this.onStart});

  final VoidCallback onStart;

  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;

    return Material(
      color: designSystem.colorTheme.primaryContainer,
      child: InkWell(
        onTap: onStart,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              Icon(
                Icons.play_circle_outline,
                color: designSystem.colorTheme.onPrimaryContainer,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'シミュレーション再生',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: designSystem.colorTheme.onPrimaryContainer,
                  ),
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: designSystem.colorTheme.onPrimaryContainer,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
