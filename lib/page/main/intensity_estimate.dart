import 'package:collection/collection.dart';
import '../../utils/map/map_global_offset.dart';
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
    final lat = useState<double>(35);
    final lon = useState<double>(135);
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
        hypocenter: LatLng(lat.value, lon.value),
        obsPoints: ref.watch(parameterEarthquakeProvider).items,
      );
      intensityCalcResult.value =
          result.groupListsBy((element) => element.region.code);
      calcTime.value = (stopWatch..stop()).elapsedMicroseconds;
    }

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                // マグニチュードの値を入力するテキストフィールド
                Row(
                  children: [
                    const Text('マグニチュード'),
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
                    const Text('深さ'),
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
                TextFormField(
                  autovalidateMode: AutovalidateMode.always,
                  initialValue: lat.value.toString(),
                  decoration: const InputDecoration(
                    labelText: '緯度',
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    lat.value = double.tryParse(value) ?? 35;
                    calc();
                  },
                  validator: (value) {
                    try {
                      LatLng(lat.value, lon.value);
                    } on Exception {
                      isCollect.value = false;
                      return '正しいの値を入力してください';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  initialValue: lon.value.toString(),
                  decoration: const InputDecoration(
                    labelText: '経度',
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    lon.value = double.tryParse(value) ?? 35;
                    calc();
                  },
                  validator: (value) {
                    try {
                      LatLng(lat.value, lon.value);
                    } on Exception {
                      isCollect.value = false;
                      return '正しいの値を入力してください';
                    }
                    return null;
                  },
                )
              ],
            ),
          ), // マップ
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Stack(
                children: [
                  GestureDetector(
                    onTapDown: (details) {
                      final position = MapGlobalOffset.globalPointToLatLng(
                        transformationController.toScene(details.localPosition),
                      );
                      lat.value = position.latitude;
                      lon.value = position.longitude;
                      calc();
                    },
                    child: InteractiveViewer(
                      transformationController: transformationController,
                      constrained: false,
                      maxScale: 10,
                      child: Stack(
                        children: [
                          // マップベース
                          const BaseMapWidget(),
                          // 推定した観測点震度
                          CustomPaint(
                            painter: EstimatedShindoPainter(
                              estimatedShindoPointsGroupBy:
                                  intensityCalcResult.value,
                              mapPolygons:
                                  ref.watch(mapAreaForecastLocalEProvider),
                            ),
                            size: const Size(476, 927.4),
                          ),
                          // EEWの震央位置
                          CustomPaint(
                            painter: HypocenterPainterfromLatLng(
                              hypocenter: LatLng(lat.value, lon.value),
                            ),
                            size: const Size(476, 927.4),
                          ),
                        ],
                      ),
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
