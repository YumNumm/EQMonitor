import 'package:eqmonitor/core/component/error/error_card.dart';
import 'package:eqmonitor/feature/map/data/notifier/map_configuration_notifier.dart';
import 'package:eqmonitor/feature/seismicity/data/logic/seismicity_bounds_filter.dart';
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_bounds.dart';
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_color_mode.dart';
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_dataset.dart';
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_event.dart';
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_span.dart';
import 'package:eqmonitor/feature/seismicity/data/notifier/seismicity_dataset_notifier.dart';
import 'package:eqmonitor/feature/seismicity/ui/components/seismicity_color_mode_selector.dart';
import 'package:eqmonitor/feature/seismicity/ui/components/seismicity_selection_overlay.dart';
import 'package:eqmonitor/feature/seismicity/ui/components/seismicity_span_selector.dart';
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
    final colorMode = useState(SeismicityColorMode.elapsedTime);
    final isSelecting = useState(false);
    final selectedBounds = useState<SeismicityBounds?>(null);
    final mapConfiguration = ref.watch(mapConfigurationProvider);
    final datasetAsync = ref.watch(
      seismicityDatasetNotifierProvider(span.value),
    );

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
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: Row(
              children: [
                SeismicitySpanSelector(
                  value: span.value,
                  onChanged: (value) => span.value = value,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: SeismicityColorModeSelector(
                    value: colorMode.value,
                    onChanged: (value) => colorMode.value = value,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: switch (mapConfiguration) {
        AsyncData(:final value) when value.styleString != null => _MapBody(
          styleString: value.styleString!,
          datasetAsync: datasetAsync,
          colorMode: colorMode.value,
          isSelecting: isSelecting.value,
          onSelectionEnd: (bounds) => selectedBounds.value = bounds,
        ),
        AsyncError(:final error) => Center(child: ErrorCard(error: error)),
        _ => const Center(child: CircularProgressIndicator.adaptive()),
      },
      bottomSheet: selectedBounds.value == null
          ? null
          : SizedBox(
              height: MediaQuery.of(context).size.height * 0.45,
              child: Material(
                elevation: 8,
                child: SeismicityAnalysisPanel(
                  events: const SeismicityBoundsFilter().filter(
                    events: switch (datasetAsync) {
                      AsyncData(:final SeismicityDataset value) => value.events,
                      _ => const <SeismicityEvent>[],
                    },
                    minLatitude: selectedBounds.value!.minLatitude,
                    maxLatitude: selectedBounds.value!.maxLatitude,
                    minLongitude: selectedBounds.value!.minLongitude,
                    maxLongitude: selectedBounds.value!.maxLongitude,
                  ),
                ),
              ),
            ),
    );
  }
}

class _MapBody extends StatelessWidget {
  const _MapBody({
    required this.styleString,
    required this.datasetAsync,
    required this.colorMode,
    required this.isSelecting,
    required this.onSelectionEnd,
  });

  final String styleString;
  final AsyncValue<SeismicityDataset> datasetAsync;
  final SeismicityColorMode colorMode;
  final bool isSelecting;
  final void Function(SeismicityBounds bounds) onSelectionEnd;

  @override
  Widget build(BuildContext context) {
    final events = switch (datasetAsync) {
      AsyncData(:final value) => value.events,
      _ => const <SeismicityEvent>[],
    };

    return Stack(
      children: [
        MapLibreMap(
          options: MapOptions(
            initStyle: styleString,
            initCenter: const Geographic(lon: 137.0, lat: 36.5),
            initZoom: 4.5,
          ),
          children: [
            SeismicityEpicenterLayer(events: events, colorMode: colorMode),
          ],
        ),
        SeismicitySelectionOverlay(
          enabled: isSelecting,
          onSelectionEnd: onSelectionEnd,
        ),
        if (datasetAsync case AsyncLoading())
          const Positioned(
            top: 8,
            right: 8,
            child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
        if (datasetAsync case AsyncData(:final value))
          Positioned(
            top: 8,
            left: 8,
            child: value.isFromCache
                ? Card(
                    color: Theme.of(context).colorScheme.errorContainer,
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
                    color: Theme.of(
                      context,
                    ).colorScheme.surface.withValues(alpha: 0.8),
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
