import 'package:collection/collection.dart';
import 'package:eqmonitor/provider/setting/intensity_color_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong2/latlong.dart';

import '../../api/int_calc/int_calc.dart';
import '../../const/kmoni/jma_intensity.dart';
import '../../provider/init/map_area_forecast_local_e.dart';
import '../../provider/init/parameter-earthquake.dart';
import '../../widget/intensity/intensity_widget.dart';
import '../../widget/intensity_calc/estimated_shindo_painter.dart';
import '../../widget/intensity_calc/map_eew_hypocenter_painter.dart';
import 'kmoni_map.dart';

class IntensityEstimatePage extends HookConsumerWidget {
  IntensityEstimatePage({super.key});

  final TransformationController transformationController =
      TransformationController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final intensityCalc = IntensityEstimateApi();
    final magnitude = useState<double>(8);
    final depth = useState<int>(50);
    final hypo = useState<LatLng>(LatLng(35, 135));
    final isCollect = useState<bool>(true);
    final intensityCalcResult =
        useState<Map<int, List<EstimatedEarthquakeParameterItem>>>({});

    /// 計算処理にかかった時間
    final calcTime = useState<int?>(null);

    void calc() {
      final stopWatch = Stopwatch()..start();
      final result = intensityCalc.estimateIntensity(
        jmaMagnitude: magnitude.value,
        depth: depth.value.toDouble(),
        hypocenter: hypo.value,
        obsPoints: ref.watch(parameterEarthquakeProvider).items,
      );
      intensityCalcResult.value =
          result.groupListsBy((element) => element.region.code);
      calcTime.value = (stopWatch..stop()).elapsedMicroseconds;
    }

    return Scaffold(
      body: Column(
        children: [
          ExpansionTile(
            title: const Text('震源要素'),
            leading: const Icon(Icons.place),
            subtitle: Text(
              '${hypo.value.longitude.toStringAsFixed(1)}, ${hypo.value.latitude.toStringAsFixed(1)}, 深さ: ${depth.value}km M${magnitude.value}',
            ),
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    // マグニチュードの値を入力するテキストフィールド
                    Row(
                      children: [
                        Text('マグニチュード M ${magnitude.value}'),
                        Expanded(
                          child: Slider.adaptive(
                            value: magnitude.value,
                            max: 10,
                            divisions: 100,
                            label: 'M ${magnitude.value}',
                            onChanged: (value) {
                              magnitude.value =
                                  double.parse(value.toStringAsFixed(1));
                              calc();
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text('深さ ${depth.value}km'),
                        Expanded(
                          child: Slider.adaptive(
                            value: depth.value.toDouble(),
                            max: 200,
                            divisions: 20,
                            label: '${depth.value}km',
                            onChanged: (value) {
                              depth.value = value.toInt();
                              calc();
                            },
                          ),
                        ),
                      ],
                    ),
                    // 経度
                    Row(
                      children: [
                        Text('経度 ${hypo.value.longitude.toStringAsFixed(1)}'),
                        Expanded(
                          child: Slider.adaptive(
                            value: hypo.value.longitude,
                            min: 120,
                            max: 150,
                            divisions: 300,
                            label: hypo.value.longitude.toStringAsFixed(1),
                            onChanged: (value) {
                              hypo.value = LatLng(hypo.value.latitude, value);
                              calc();
                            },
                          ),
                        ),
                      ],
                    ),
                    // 緯度
                    Row(
                      children: [
                        Text('緯度 ${hypo.value.latitude.toStringAsFixed(1)}'),
                        Expanded(
                          child: Slider.adaptive(
                            value: hypo.value.latitude,
                            min: 25,
                            max: 50,
                            divisions: 250,
                            label: hypo.value.latitude.toStringAsFixed(1),
                            onChanged: (value) {
                              hypo.value = LatLng(value, hypo.value.longitude);
                              calc();
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ), // マップ
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Stack(
                children: [
                  InteractiveViewer(
                    transformationController: transformationController,
                    constrained: false,
                    maxScale: 10,
                    child: Stack(
                      children: [
                        // マップベース
                        const BaseMapWidget(),
                        // 推定した観測点震度
                        RepaintBoundary(
                          child: CustomPaint(
                            painter: EstimatedShindoPainter(
                              estimatedShindoPointsGroupBy:
                                  intensityCalcResult.value,
                              colors: ref.watch(jmaIntensityColorProvider),
                              mapPolygons:
                                  ref.watch(mapAreaForecastLocalEProvider),
                            ),
                            size: const Size(476, 927.4),
                          ),
                        ),
                        // EEWの震央位置
                        RepaintBoundary(
                          child: CustomPaint(
                            painter: HypocenterPainterfromLatLng(
                              hypocenter: hypo.value,
                            ),
                            size: const Size(476, 927.4),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // 凡例
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Row(
                      children: [
                        for (final i in JmaIntensity.values)
                          if (i == JmaIntensity.over)
                            const SizedBox.shrink()
                          else
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IntensityWidget(
                                  intensity: i,
                                  size: 25,
                                  opacity: 1,
                                ),
                                const SizedBox(width: 5),
                              ],
                            ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        (calcTime.value == null)
                            ? ''
                            : 'took ${calcTime.value! / 1000}ms',
                        style: const TextStyle(
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
