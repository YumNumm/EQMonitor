import 'package:eqmonitor/core/component/error/error_card.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/feature/map/data/model/map_configuration.dart';
import 'package:eqmonitor/feature/map/data/notifier/map_configuration_notifier.dart';
import 'package:eqmonitor/feature/map/ui/map_operation_queue_scope.dart';
import 'package:eqmonitor/feature/seismicity/data/logic/hypocenter_archive_selector.dart';
import 'package:eqmonitor/feature/seismicity/data/logic/seismicity_bounds_filter.dart';
import 'package:eqmonitor/feature/seismicity/data/model/hypocenter_analysis_request.dart';
import 'package:eqmonitor/feature/seismicity/data/model/hypocenter_archive.dart';
import 'package:eqmonitor/feature/seismicity/data/model/hypocenter_archive_id.dart';
import 'package:eqmonitor/feature/seismicity/data/model/hypocenter_manifest.dart';
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_bounds.dart';
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_color_mode.dart';
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_data_mode.dart';
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_dataset.dart';
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_event.dart';
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_span.dart';
import 'package:eqmonitor/feature/seismicity/data/notifier/seismicity_dataset_notifier.dart';
import 'package:eqmonitor/feature/seismicity/data/provider/hypocenter_catalog_provider.dart';
import 'package:eqmonitor/feature/seismicity/ui/components/hypocenter_archive_selector_sheet.dart';
import 'package:eqmonitor/feature/seismicity/ui/components/seismicity_color_mode_selector.dart';
import 'package:eqmonitor/feature/seismicity/ui/components/seismicity_data_mode_selector.dart';
import 'package:eqmonitor/feature/seismicity/ui/components/seismicity_selection_overlay.dart';
import 'package:eqmonitor/feature/seismicity/ui/components/seismicity_span_selector.dart';
import 'package:eqmonitor/feature/seismicity/ui/layer/hypocenter_pmtiles_layer.dart';
import 'package:eqmonitor/feature/seismicity/ui/layer/seismicity_epicenter_layer.dart';
import 'package:eqmonitor/feature/seismicity/ui/panel/seismicity_analysis_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:maplibre/maplibre.dart';

/// 地震活動画面(震央分布 + 矩形選択によるM-T図・積算・深さ断面)。
class SeismicityPage extends HookConsumerWidget {
  const SeismicityPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final span = useState(SeismicitySpan.p1m);
    final mode = useState(SeismicityDataMode.allHypocenters);
    final colorMode = useState(SeismicityColorMode.elapsedTime);
    final isSelecting = useState(false);
    final selectedBounds = useState<SeismicityBounds?>(null);
    final selectedArchiveIds = useState(<HypocenterArchiveId>{});
    final hasSynchronizedManifest = useRef(false);
    final mapConfiguration = ref.watch(mapConfigurationProvider);
    final manifestAsync = ref.watch(hypocenterManifestProvider);
    final datasetAsync = ref.watch(
      seismicityDatasetNotifierProvider(span.value),
    );
    final manifest = switch (manifestAsync) {
      AsyncData(:final value) => value,
      _ => null,
    };
    useEffect(() {
      if (manifest == null) {
        return null;
      }
      const selector = HypocenterArchiveSelector();
      final selected = hasSynchronizedManifest.value
          ? selector.remap(
              selected: selectedArchiveIds.value,
              archives: manifest.archives,
            )
          : selector.initialSelection(archives: manifest.archives);
      selectedArchiveIds.value = selected.map((archive) => archive.id).toSet();
      hasSynchronizedManifest.value = true;
      return null;
    }, [manifest]);
    final selectedArchives =
        manifest?.archives
            .where((archive) => selectedArchiveIds.value.contains(archive.id))
            .toList() ??
        const <HypocenterArchive>[];
    final availableArchives = <HypocenterArchive>[];
    var hasUnavailableArchive = false;
    var isProbingArchives = false;
    for (final archive in selectedArchives) {
      switch (ref.watch(hypocenterArchiveAvailableProvider(archive))) {
        case AsyncData(value: true):
          availableArchives.add(archive);
        case AsyncData(value: false) || AsyncError():
          hasUnavailableArchive = true;
        case AsyncLoading():
          isProbingArchives = true;
      }
    }
    final bounds = selectedBounds.value;
    final analysisAsync =
        mode.value == SeismicityDataMode.allHypocenters && bounds != null
        ? ref.watch(
            hypocenterAnalysisProvider(
              HypocenterAnalysisRequest(
                archives: selectedArchives,
                bounds: bounds,
              ),
            ),
          )
        : null;

    return Scaffold(
      appBar: AppBar(
        title: const Text('地震活動'),
        actions: [
          IconButton(
            icon: Icon(
              isSelecting.value ? Icons.crop_free : Icons.crop_free_outlined,
            ),
            tooltip: '矩形選択',
            isSelected: isSelecting.value,
            onPressed: () {
              isSelecting.value = !isSelecting.value;
              if (!isSelecting.value) {
                selectedBounds.value = null;
              }
            },
          ),
        ],
      ),
      body: switch (mapConfiguration) {
        AsyncData(value: MapConfiguration(styleString: final styleString?)) =>
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    SeismicityDataModeSelector(
                      value: mode.value,
                      onChanged: (value) {
                        mode.value = value;
                        selectedBounds.value = null;
                      },
                    ),
                    if (mode.value == SeismicityDataMode.feltEarthquakes)
                      SeismicitySpanSelector(
                        value: span.value,
                        onChanged: (value) => span.value = value,
                      )
                    else
                      OutlinedButton.icon(
                        onPressed: manifest == null
                            ? null
                            : () async {
                                await showModalBottomSheet<void>(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (context) => FractionallySizedBox(
                                    heightFactor: 0.75,
                                    child: HypocenterArchiveSelectorSheet(
                                      archives: manifest.archives,
                                      selected: selectedArchiveIds.value,
                                      onApply: (value) {
                                        selectedArchiveIds.value = value;
                                        selectedBounds.value = null;
                                      },
                                    ),
                                  ),
                                );
                              },
                        icon: const Icon(Icons.calendar_month),
                        label: Text('${selectedArchiveIds.value.length}件の期間'),
                      ),
                    SeismicityColorModeSelector(
                      value: colorMode.value,
                      onChanged: (value) => colorMode.value = value,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: _MapBody(
                  styleString: styleString,
                  mode: mode.value,
                  datasetAsync: datasetAsync,
                  manifestAsync: manifestAsync,
                  availableArchives: availableArchives,
                  hasUnavailableArchive: hasUnavailableArchive,
                  isProbingArchives: isProbingArchives,
                  colorMode: colorMode.value,
                  isSelecting: isSelecting.value,
                  onSelectionEnd: (bounds) => selectedBounds.value = bounds,
                ),
              ),
            ],
          ),
        AsyncError(:final error) => Center(child: ErrorCard(error: error)),
        _ => const Center(child: CircularProgressIndicator.adaptive()),
      },
      bottomSheet: bounds == null
          ? null
          : SizedBox(
              height: MediaQuery.of(context).size.height * 0.45,
              child: Material(
                elevation: 8,
                child: switch ((mode.value, analysisAsync)) {
                  (
                    SeismicityDataMode.allHypocenters,
                    AsyncData(:final value),
                  ) =>
                    SeismicityAnalysisPanel(events: value),
                  (
                    SeismicityDataMode.allHypocenters,
                    AsyncError(:final error),
                  ) =>
                    Center(child: ErrorCard(error: error)),
                  (SeismicityDataMode.allHypocenters, _) => const Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
                  _ => SeismicityAnalysisPanel(
                    events: const SeismicityBoundsFilter().filter(
                      events: switch (datasetAsync) {
                        AsyncData(:final SeismicityDataset value) =>
                          value.events,
                        _ => const <SeismicityEvent>[],
                      },
                      minLatitude: bounds.minLatitude,
                      maxLatitude: bounds.maxLatitude,
                      minLongitude: bounds.minLongitude,
                      maxLongitude: bounds.maxLongitude,
                    ),
                  ),
                },
              ),
            ),
    );
  }
}

class _MapBody extends HookWidget {
  const _MapBody({
    required this.styleString,
    required this.mode,
    required this.datasetAsync,
    required this.manifestAsync,
    required this.availableArchives,
    required this.hasUnavailableArchive,
    required this.isProbingArchives,
    required this.colorMode,
    required this.isSelecting,
    required this.onSelectionEnd,
  });

  final String styleString;
  final SeismicityDataMode mode;
  final AsyncValue<SeismicityDataset> datasetAsync;
  final AsyncValue<HypocenterManifest> manifestAsync;
  final List<HypocenterArchive> availableArchives;
  final bool hasUnavailableArchive;
  final bool isProbingArchives;
  final SeismicityColorMode colorMode;
  final bool isSelecting;
  final void Function(SeismicityBounds bounds) onSelectionEnd;

  @override
  Widget build(BuildContext context) {
    final events = switch ((mode, datasetAsync)) {
      (SeismicityDataMode.feltEarthquakes, AsyncData(:final value)) =>
        value.events,
      _ => const <SeismicityEvent>[],
    };
    final mapController = useState<MapController?>(null);

    return Stack(
      children: [
        MapOperationQueueScope(
          child: MapLibreMap(
            options: MapOptions(
              initStyle: styleString,
              initCenter: const Geographic(lon: 137, lat: 36.5),
              initZoom: 4.5,
            ),
            onMapCreated: (controller) {
              mapController.value = controller;
            },
            children: [
              if (mode == SeismicityDataMode.allHypocenters)
                HypocenterPmTilesLayer(
                  archives: availableArchives,
                  colorMode: colorMode,
                )
              else
                SeismicityEpicenterLayer(events: events, colorMode: colorMode),
            ],
          ),
        ),
        SeismicitySelectionOverlay(
          enabled: isSelecting,
          mapController: mapController.value,
          onSelectionEnd: onSelectionEnd,
        ),
        if ((mode == SeismicityDataMode.feltEarthquakes &&
                datasetAsync is AsyncLoading) ||
            (mode == SeismicityDataMode.allHypocenters &&
                (manifestAsync is AsyncLoading || isProbingArchives)))
          const Positioned(
            top: 8,
            right: 8,
            child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
        if (mode == SeismicityDataMode.allHypocenters && hasUnavailableArchive)
          const Positioned(
            top: 8,
            left: 8,
            child: Card(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Text('一部の期間を表示できません'),
              ),
            ),
          ),
        if (manifestAsync case AsyncError(:final error))
          if (mode == SeismicityDataMode.allHypocenters)
            Positioned(top: 8, left: 8, child: ErrorCard(error: error)),
        if (datasetAsync case AsyncData(:final value))
          if (mode == SeismicityDataMode.feltEarthquakes)
            Positioned(
              top: 8,
              left: 8,
              child: value.isFromCache
                  ? Card(
                      color: context.designSystem.colorTheme.errorContainer,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text('取得失敗のため前回データを表示中'),
                            Text(
                              _generatedAtLabel(value.generatedAt),
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    )
                  : Card(
                      color: context.designSystem.colorTheme.surface.withValues(
                        alpha: 0.8,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        child: Text(
                          _generatedAtLabel(value.generatedAt),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ),
            ),
      ],
    );
  }

  static final _generatedAtFormat = DateFormat('yyyy/MM/dd HH:mm');

  static String _generatedAtLabel(DateTime generatedAt) =>
      '${_generatedAtFormat.format(generatedAt.toLocal())} 時点のデータ';
}
