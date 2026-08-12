import 'package:eqmonitor/core/provider/jma_parameter/jma_earthquake_nearest_observation_point.dart';
import 'package:eqmonitor/core/provider/jma_parameter/jma_parameter.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/core/provider/map/jma_map_provider.dart';
import 'package:eqmonitor/feature/location/data/location.dart';
import 'package:eqmonitor/feature/location/data/model/map_data_item.dart';
import 'package:eqmonitor/feature/location/data/nearest_jma_feature.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lat_lng/lat_lng.dart';

class DebugJmaMapPage extends HookConsumerWidget {
  const DebugJmaMapPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jmaMap = ref.watch(jmaMapProvider);

    final currentPosition = ref.watch(locationStreamProvider);

    // 手動入力用の緯度経度コントローラー
    final latController = useTextEditingController();
    final lngController = useTextEditingController();

    // 選択されたJMAマップの種類
    final selectedMapType = useState(JmaMapType.areaForecastLocalEew);

    // 検索結果
    final searchResult = useState<MapDataItem?>(null);
    final observationPointResult = useState<EarthquakeParameterStationItem?>(
      null,
    );
    final distance = useState<double?>(null);
    final isLoading = useState(false);

    // 現在位置を使用
    Future<void> useCurrentLocation() async {
      if (currentPosition case AsyncData(:final value)) {
        latController.text = value.latitude.toString();
        lngController.text = value.longitude.toString();
      }
    }

    // 検索実行
    Future<void> search() async {
      try {
        final lat = double.parse(latController.text);
        final lng = double.parse(lngController.text);
        final latLng = LatLng(lat, lng);

        isLoading.value = true;
        searchResult.value = null;
        observationPointResult.value = null;

        final stopWatch = Stopwatch()..start();

        if (selectedMapType.value == JmaMapType.observationPoint) {
          final point = await ref.read(
            jmaEarthquakeNearestObservationPointProvider(latLng).future,
          );
          observationPointResult.value = point?.$1;
          distance.value = point?.$2;
        } else {
          MapDataItem? result;

          switch (selectedMapType.value) {
            case JmaMapType.areaForecastLocalEew:
              result = await ref.read(
                jmaMapAreaForecastLocalEewInsideProvider(latLng).future,
              );
            case JmaMapType.areaForecastLocalE:
              result = await ref.read(
                jmaMapAreaForecastLocalEInsideProvider(latLng).future,
              );
            case JmaMapType.areaInformationCity:
              result = await ref.read(
                jmaMapAreaInformationCityInsideProvider(latLng).future,
              );
            case JmaMapType.areaTsunami:
              result = await ref.read(
                jmaMapAreaTsunamiNearestProvider(latLng).future,
              );
            case JmaMapType.observationPoint:
              // 処理は上記で実行済み
              break;
          }

          searchResult.value = result;
        }

        stopWatch.stop();
        talker.debug(
          '${selectedMapType.value} time: ${stopWatch.elapsedMicroseconds / 1000}ms',
        );

        final noResults =
            searchResult.value == null && observationPointResult.value == null;
        if (noResults && context.mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('検索結果がありません')));
        }
      } on Exception catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('エラー: $e')));
        }
      } finally {
        isLoading.value = false;
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('JmaMap Debug')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                jmaMap.value
                        ?.map((k, v) => MapEntry(k, v.data.length))
                        .toString() ??
                    'null',
              ),
              // 位置情報セクション
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '位置情報',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: latController,
                              decoration: const InputDecoration(
                                labelText: '緯度',
                                border: OutlineInputBorder(),
                              ),
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                    decimal: true,
                                  ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              controller: lngController,
                              decoration: const InputDecoration(
                                labelText: '経度',
                                border: OutlineInputBorder(),
                              ),
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                    decimal: true,
                                  ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          ElevatedButton.icon(
                            onPressed: useCurrentLocation,
                            icon: const Icon(Icons.my_location),
                            label: const Text('現在位置を使用'),
                          ),
                          const SizedBox(width: 8),
                          switch (currentPosition) {
                            AsyncData() => const Icon(
                              Icons.check_circle,
                              color: Colors.green,
                            ),
                            AsyncError() => const Icon(
                              Icons.error,
                              color: Colors.red,
                            ),
                            AsyncLoading() => const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          },
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // JMAマップ種類選択
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'JMAマップ種類',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<JmaMapType>(
                        initialValue: selectedMapType.value,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        items: JmaMapType.values.map((type) {
                          return DropdownMenuItem(
                            value: type,
                            child: Text(
                              switch (type) {
                                JmaMapType.areaForecastLocalEew =>
                                  '地震情報／緊急地震速報',
                                JmaMapType.areaForecastLocalE => '地震情報',
                                JmaMapType.areaInformationCity => '市区町村等',
                                JmaMapType.areaTsunami => '津波予報区',
                                JmaMapType.observationPoint => '地震観測点',
                              },
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value != null) {
                            searchResult.value = null;
                            selectedMapType.value = value;
                          }
                        },
                      ),
                      const SizedBox(height: 16),
                      TextButton(onPressed: search, child: const Text('検索')),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // 検索結果
              if (searchResult.value != null) ...[
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '検索結果',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _ResultInfo(item: searchResult.value!),
                      ],
                    ),
                  ),
                ),
              ],

              // 地震観測点の検索結果
              if (observationPointResult.value != null) ...[
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '最寄り地震観測点',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _ObservationPointInfo(
                          item: observationPointResult.value!,
                        ),
                        if (distance.value != null)
                          _InfoRow(
                            label: '距離',
                            value: '${distance.value!.toStringAsFixed(2)} km',
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _ResultInfo extends StatelessWidget {
  const _ResultInfo({required this.item});

  final MapDataItem item;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (item.property != null) ...[
          if (item.property!.code.isNotEmpty)
            _InfoRow(label: 'コード', value: item.property!.code),
          if (item.property!.name.isNotEmpty)
            _InfoRow(label: '名前', value: item.property!.name),
          if (item.property!.nameKana.isNotEmpty)
            _InfoRow(label: '名前（カナ）', value: item.property!.nameKana),
        ],
        if (item.polylabel != null) ...[
          _InfoRow(label: '緯度', value: item.polylabel!.lat.toString()),
          _InfoRow(label: '経度', value: item.polylabel!.lng.toString()),
        ],
        if (item.bounds != null) ...[
          _InfoRow(label: '南西緯度', value: item.bounds!.southWest.lat.toString()),
          _InfoRow(label: '南西経度', value: item.bounds!.southWest.lng.toString()),
          _InfoRow(label: '北東緯度', value: item.bounds!.northEast.lat.toString()),
          _InfoRow(label: '北東経度', value: item.bounds!.northEast.lng.toString()),
        ],
        if (item.distanceToCoastlineKm != null)
          _InfoRow(
            label: '海岸線までの距離',
            value: '${item.distanceToCoastlineKm!.toStringAsFixed(1)} km',
          ),
      ],
    );
  }
}

class _ObservationPointInfo extends StatelessWidget {
  const _ObservationPointInfo({required this.item});

  final EarthquakeParameterStationItem item;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _InfoRow(label: 'コード', value: item.code),
        _InfoRow(label: '名前', value: item.name.ja),
        _InfoRow(label: '緯度', value: item.location.lat.toString()),
        _InfoRow(label: '経度', value: item.location.lon.toString()),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}

enum JmaMapType {
  areaForecastLocalEew,
  areaForecastLocalE,
  areaInformationCity,
  areaTsunami,
  observationPoint,
}
