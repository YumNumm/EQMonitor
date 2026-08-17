import 'dart:async';

import 'package:collection/collection.dart';
import 'package:eqmonitor/core/provider/jma_code_table_provider.dart';
import 'package:eqmonitor/feature/location/data/nearest_jma_feature.dart';
import 'package:eqmonitor/feature/map/data/notifier/map_configuration_notifier.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lat_lng/lat_lng.dart';
import 'package:maplibre/maplibre.dart';

typedef RegionPickerResult = ({String code, String name});

/// 地図をタップして都道府県・市区町村を選択するページ。
class RegionPickerMapPage extends HookConsumerWidget {
  const RegionPickerMapPage({required this.selectedType, super.key});

  final String selectedType;

  static Future<RegionPickerResult?> show(
    BuildContext context, {
    required String selectedType,
  }) => Navigator.of(context).push<RegionPickerResult>(
    MaterialPageRoute(
      fullscreenDialog: true,
      builder: (_) => RegionPickerMapPage(selectedType: selectedType),
    ),
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resolved = useState<RegionPickerResult?>(null);
    final isResolving = useState(false);

    Future<void> resolveLocation(double lat, double lon) async {
      isResolving.value = true;
      resolved.value = null;
      try {
        final latLng = LatLng(lat, lon);
        if (selectedType == 'city') {
          final city = await ref.read(
            jmaMapAreaInformationCityInsideProvider(latLng).future,
          );
          final property = city?.property;
          if (property != null) {
            resolved.value = (code: property.code, name: property.name);
          }
        } else {
          final city = await ref.read(
            jmaMapAreaInformationCityInsideProvider(latLng).future,
          );
          final property = city?.property;
          if (property != null) {
            final cityCode = property.code;
            final prefix = cityCode.length >= 2
                ? cityCode.substring(0, 2)
                : cityCode;
            final jmaCodeTable = ref.read(jmaCodeTableProvider).value;
            final prefecture = jmaCodeTable
                ?.codeTables
                .areaInformationPrefectureEarthquake
                .firstWhereOrNull((p) => p.code.startsWith(prefix));
            if (prefecture != null) {
              resolved.value = (
                code: prefecture.code,
                name: prefecture.name.ja,
              );
            }
          }
        }
      } finally {
        isResolving.value = false;
      }
    }

    final mapConfigAsync = ref.watch(mapConfigurationProvider);
    final styleString = mapConfigAsync.value?.styleString;
    final title = selectedType == 'prefecture' ? '都道府県を地図から選択' : '市区町村を地図から選択';
    final hint = selectedType == 'prefecture'
        ? '地図をタップして都道府県を選択'
        : '地図をタップして市区町村を選択';
    final resolvedValue = resolved.value;

    if (styleString == null) {
      return Scaffold(
        appBar: AppBar(title: Text(title)),
        body: const Center(child: CircularProgressIndicator.adaptive()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          if (resolvedValue != null)
            TextButton(
              onPressed: () => Navigator.of(context).pop(resolvedValue),
              child: const Text('決定'),
            ),
        ],
      ),
      body: Stack(
        children: [
          MapLibreMap(
            options: MapOptions(initStyle: styleString),
            onEvent: (event) {
              if (event is MapEventClick && !isResolving.value) {
                resolveLocation(event.point.lat, event.point.lon).ignore();
              }
            },
          ),
          if (isResolving.value)
            const Center(child: CircularProgressIndicator.adaptive()),
          if (resolvedValue == null && !isResolving.value)
            Positioned(
              bottom: 32,
              left: 16,
              right: 16,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    hint,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),
            ),
          if (resolvedValue != null && !isResolving.value)
            Positioned(
              bottom: 32,
              left: 16,
              right: 16,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.location_on),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          resolvedValue.name,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      TextButton(
                        onPressed: () =>
                            Navigator.of(context).pop(resolvedValue),
                        child: const Text('決定'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
