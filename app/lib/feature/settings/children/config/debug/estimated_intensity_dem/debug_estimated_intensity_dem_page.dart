import 'dart:io';

import 'package:eqmonitor/core/component/progress/accessible_progress_indicator.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/estimated_intensity_dem_display_mode.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/layer/earthquake_history_details_estimated_intensity_dem_layer.dart';
import 'package:eqmonitor/feature/map/data/model/map_configuration.dart';
import 'package:eqmonitor/feature/map/data/notifier/map_configuration_notifier.dart';
import 'package:eqmonitor/feature/map/ui/map_operation_queue_scope.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';
import 'package:material_ui/material_ui.dart';
import 'package:path_provider/path_provider.dart';

class const DebugEstimatedIntensityDemArchiveLister() {
  static const directoryName = 'estimated_intensity_dem';

  Future<List<File>> list() async {
    final documents = await getApplicationDocumentsDirectory();
    final directory = Directory('${documents.path}/$directoryName');
    if (!directory.existsSync()) {
      return [];
    }
    final files = [
      for (final entity in directory.listSync())
        if (entity is File && entity.path.endsWith('.pmtiles')) entity,
    ];
    return files..sort((a, b) => a.path.compareTo(b.path));
  }
}

class const DebugEstimatedIntensityDemPage({super.key})
    extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapConfiguration = ref.watch(mapConfigurationProvider);
    final archives = useFuture(
      useMemoized(const DebugEstimatedIntensityDemArchiveLister().list),
    );
    final displayMode = useState(
      EstimatedIntensityDemDisplayMode.intensityClass,
    );
    final selectedPath = useState<String?>(null);
    final files = archives.data ?? const <File>[];
    final path = selectedPath.value ?? files.firstOrNull?.path;

    return Scaffold(
      appBar: AppBar(title: const Text('推計震度 DEM')),
      body: switch (mapConfiguration) {
        AsyncData(value: MapConfiguration(styleString: final styleString?)) =>
          Column(
            children: [
              Padding(
                padding: const .symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  spacing: 12,
                  children: [
                    SegmentedButton<EstimatedIntensityDemDisplayMode>(
                      segments: const [
                        ButtonSegment(
                          value: .intensityClass,
                          label: Text('階級'),
                        ),
                        ButtonSegment(value: .tenth, label: Text('0.1')),
                      ],
                      selected: {displayMode.value},
                      onSelectionChanged: (selection) =>
                          displayMode.value = selection.first,
                    ),
                    Expanded(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: path,
                        hint: Text(
                          'Documents/'
                          '${DebugEstimatedIntensityDemArchiveLister.directoryName}'
                          ' に .pmtiles がありません',
                        ),
                        items: [
                          for (final file in files)
                            DropdownMenuItem(
                              value: file.path,
                              child: Text(file.uri.pathSegments.last),
                            ),
                        ],
                        onChanged: (value) => selectedPath.value = value,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: MapOperationQueueScope(
                  child: MapLibreMap(
                    options: MapOptions(
                      style: MapStyle.file(styleString),
                      initCamera: const CameraUpdate.position(
                        center: Geographic(lon: 141.5, lat: 40.5),
                        zoom: 5.5,
                      ),
                    ),
                    children: [
                      if (path != null)
                        EarthquakeHistoryDetailsEstimatedIntensityDemLayer(
                          tileUrl: Uri.file(path).toString(),
                          displayMode: displayMode.value,
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        AsyncError(:final error) => Center(child: Text('$error')),
        _ => const Center(child: AccessibleCircularProgressIndicator()),
      },
    );
  }
}
