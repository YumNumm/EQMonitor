import 'dart:async';

import 'package:eqmonitor/feature/location/data/jma_map_isolate.dart';
import 'package:eqmonitor/feature/map/data/notifier/map_configuration_notifier.dart';
import 'package:eqmonitor/feature/map/ui/map_operation_queue_scope.dart';
import 'package:eqmonitor/feature/map/utils/map_zoom_calculator.dart';
import 'package:eqmonitor/feature/region_selection/data/model/region_option.dart';
import 'package:eqmonitor/feature/region_selection/data/provider/region_map_metadata_provider.dart';
import 'package:eqmonitor/feature/region_selection/ui/action/region_selection_map_action.dart';
import 'package:eqmonitor/feature/region_selection/ui/component/region_selection_map_layer.dart';
import 'package:eqmonitor/feature/region_selection/data/logic/latest_map_operation_guard.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';
import 'package:material_ui/material_ui.dart';

class RegionSelectionMap extends HookConsumerWidget {
  const new({
    required this.kind,
    required this.catalog,
    required this.selected,
    required this.onSelected,
    this.parent,
    super.key,
  });

  final RegionKind kind;
  final List<RegionOption> catalog;
  final List<RegionOption> selected;
  final RegionOption? parent;
  final ValueChanged<RegionOption> onSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final configuration = ref.watch(mapConfigurationProvider);
    final metadata = ref.watch(regionMapMetadataProvider);
    final worker = kind == .epicenter || kind == .station
        ? null
        : ref.watch(jmaMapIsolateProvider);
    final controller = useRef<MapController?>(null);
    final styleLoaded = useState(false);
    final ready = useState(false);
    final resolving = useState(false);
    final layerError = useState(false);
    final retry = useState(0);
    final message = useState<String?>(null);
    final candidates = useState<List<RegionOption>>(const []);
    final guard = useMemoized(LatestMapOperationGuard.new);
    useEffect(() => guard.dispose, [guard]);
    final style = configuration.value?.styleString;
    useEffect(
      () {
        guard.invalidate();
        resolving.value = false;
        candidates.value = const [];
        message.value = null;
        return null;
      },
      [
        guard,
        kind,
        parent,
        catalog,
        selected,
        style,
        metadata.value,
        retry.value,
      ],
    );
    if (configuration.isLoading ||
        metadata.isLoading ||
        (worker?.isLoading ?? false)) {
      return const Center(child: CircularProgressIndicator.adaptive());
    }
    if (configuration.hasError ||
        metadata.hasError ||
        (worker?.hasError ?? false)) {
      return Center(
        child: Column(
          mainAxisSize: .min,
          children: [
            const Text('地図を読み込めませんでした。一覧からも選択できます。'),
            TextButton(
              onPressed: () {
                ref.invalidate(mapConfigurationProvider);
                ref.invalidate(regionMapMetadataProvider);
                if (worker?.hasError ?? false) {
                  ref.invalidate(jmaMapIsolateProvider);
                }
              },
              child: const Text('再試行'),
            ),
          ],
        ),
      );
    }
    if (style == null ||
        metadata.value == null ||
        (worker?.isLoading ?? false)) {
      return const Center(child: CircularProgressIndicator.adaptive());
    }
    final hasEpicenter = metadata.requireValue.layers.any(
      (layer) => layer.id == 'areaEpicenter',
    );
    if (kind == .epicenter && !hasEpicenter) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text(
            '震央地名を地図から選ぶにはAsset Packを更新してください。一覧からは引き続き選択できます。',
          ),
        ),
      );
    }
    if (kind == .station) {
      return const Center(child: Text('観測点は一覧から選択してください'));
    }
    final action = ref.watch(regionSelectionMapActionProvider);
    return Stack(
      children: [
        MapOperationQueueScope(
          child: MapLibreMap(
            key: ValueKey((style, retry.value)),
            options: const MapZoomCalculator().japanViewMapOptions(
              context: context,
              styleString: style,
            ),
            onMapCreated: (value) {
              controller.value = value;
              ready.value = false;
              styleLoaded.value = false;
              layerError.value = false;
            },
            onStyleLoaded: (_) {
              styleLoaded.value = true;
            },
            onEvent: (event) {
              if (event is! MapEventClick || !ready.value) {
                return;
              }
              final map = controller.value;
              if (map == null) {
                return;
              }
              final generation = guard.begin();
              resolving.value = true;
              candidates.value = const [];
              message.value = null;
              unawaited(() async {
                try {
                  final result = await action.resolve(
                    ref: ref,
                    controller: map,
                    point: event.point,
                    kind: kind,
                    catalog: catalog,
                    parent: parent,
                  );
                  if (!guard.isCurrent(generation) || !context.mounted) {
                    return;
                  }
                  if (result.length == 1) {
                    onSelected(result.first);
                  } else if (result.isEmpty) {
                    message.value = 'この場所に選択できる${kind.label}がありません';
                  } else {
                    candidates.value = result;
                  }
                } on Exception {
                  if (guard.isCurrent(generation) && context.mounted) {
                    message.value = '地域を取得できませんでした。もう一度タップしてください。';
                  }
                } finally {
                  if (guard.isCurrent(generation) && context.mounted) {
                    resolving.value = false;
                  }
                }
              }());
            },
            children: [
              if (styleLoaded.value)
                RegionSelectionMapLayer(
                  selected: selected,
                  catalog: catalog,
                  kind: kind,
                  hasEpicenter: hasEpicenter,
                  onReady: () {
                    ready.value = true;
                  },
                  onError: () {
                    ready.value = false;
                    layerError.value = true;
                  },
                ),
            ],
          ),
        ),
        if (resolving.value || (!ready.value && !layerError.value))
          const Align(
            alignment: Alignment.topCenter,
            child: LinearProgressIndicator(),
          ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisSize: .min,
                  children: [
                    if (layerError.value) ...[
                      const Text('地図を読み込めませんでした。一覧からも選択できます。'),
                      TextButton(
                        onPressed: () => retry.value++,
                        child: const Text('再試行'),
                      ),
                    ] else
                      Text(message.value ?? '地図をタップして${kind.label}を選択'),
                    if (kind == .epicenter)
                      const Text('地図に範囲のない震央地名は一覧から選択できます'),
                    for (final candidate in candidates.value)
                      TextButton(
                        onPressed: () {
                          onSelected(candidate);
                          candidates.value = const [];
                        },
                        child: Text(
                          '${candidate.name}（${candidate.parentName ?? candidate.kind.label}）',
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
