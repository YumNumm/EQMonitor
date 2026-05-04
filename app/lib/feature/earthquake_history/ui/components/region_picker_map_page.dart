import 'dart:async';

import 'package:collection/collection.dart';
import 'package:eqmonitor/core/provider/jma_code_table_provider.dart';
import 'package:eqmonitor/feature/location/data/nearest_jma_feature.dart';
import 'package:eqmonitor/feature/map/data/notifier/map_configuration_notifier.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lat_lng/lat_lng.dart';
import 'package:maplibre/maplibre.dart';

typedef RegionPickerResult = ({String code, String name});

/// 地図をタップして都道府県・市区町村を選択するページ。
class RegionPickerMapPage extends ConsumerStatefulWidget {
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
  ConsumerState<RegionPickerMapPage> createState() => _RegionPickerMapPageState();
}

class _RegionPickerMapPageState extends ConsumerState<RegionPickerMapPage> {
  String? _resolvedCode;
  String? _resolvedName;
  var _isResolving = false;

  Future<void> _resolveLocation(double lat, double lon) async {
    setState(() {
      _isResolving = true;
      _resolvedCode = null;
      _resolvedName = null;
    });
    try {
      final latLng = LatLng(lat, lon);
      if (widget.selectedType == 'city') {
        final city = await ref.read(
          jmaMapAreaInformationCityInsideProvider(latLng).future,
        );
        if (city?.property != null) {
          setState(() {
            _resolvedCode = city!.property!.code;
            _resolvedName = city.property!.name;
          });
        }
      } else {
        final city = await ref.read(
          jmaMapAreaInformationCityInsideProvider(latLng).future,
        );
        if (city?.property != null) {
          final cityCode = city!.property!.code;
          final prefix =
              cityCode.length >= 2 ? cityCode.substring(0, 2) : cityCode;
          final jmaCodeTable = ref.read(jmaCodeTableProvider).value;
          final prefecture = jmaCodeTable
              ?.codeTables
              .areaInformationPrefectureEarthquake
              .firstWhereOrNull(
                (p) => p.code.startsWith(prefix),
              );
          if (prefecture != null) {
            setState(() {
              _resolvedCode = prefecture.code;
              _resolvedName = prefecture.name.ja;
            });
          }
        }
      }
    } finally {
      if (mounted) {
        setState(() => _isResolving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final mapConfigAsync = ref.watch(mapConfigurationProvider);
    final styleString = mapConfigAsync.value?.styleString;
    final title =
        widget.selectedType == 'prefecture' ? '都道府県を地図から選択' : '市区町村を地図から選択';
    final hint =
        widget.selectedType == 'prefecture' ? '地図をタップして都道府県を選択' : '地図をタップして市区町村を選択';

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
          if (_resolvedCode != null)
            TextButton(
              onPressed: () => Navigator.of(context).pop((
                code: _resolvedCode!,
                name: _resolvedName!,
              )),
              child: const Text('決定'),
            ),
        ],
      ),
      body: Stack(
        children: [
          MapLibreMap(
            options: MapOptions(initStyle: styleString),
            onEvent: (event) {
              if (event is MapEventClick && !_isResolving) {
                _resolveLocation(event.point.lat, event.point.lon).ignore();
              }
            },
          ),
          if (_isResolving)
            const Center(child: CircularProgressIndicator.adaptive()),
          if (_resolvedCode == null && !_isResolving)
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
          if (_resolvedName != null && !_isResolving)
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
                          _resolvedName!,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop((
                          code: _resolvedCode!,
                          name: _resolvedName!,
                        )),
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
