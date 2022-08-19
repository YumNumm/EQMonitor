import 'package:collection/collection.dart';
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
  const IntensityEstimatePage({super.key});

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
                TextFormField(
                  autovalidateMode: AutovalidateMode.always,
                  initialValue: magnitude.value.toString(),
                  decoration: const InputDecoration(
                    labelText: 'マグニチュード',
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    magnitude.value = double.tryParse(value) ?? 8;
                    calc();
                  },
                  validator: (value) {
                    if (double.tryParse(value ?? 'a') == null) {
                      isCollect.value = false;

                      return 'マグニチュードの値を入力してください';
                    }
                    isCollect.value = isCollect.value && true;
                    return null;
                  },
                ),
                // 深さの値を入力するテキストフィールド
                TextFormField(
                  autovalidateMode: AutovalidateMode.always,
                  initialValue: depth.value.toString(),
                  decoration: const InputDecoration(
                    labelText: '深さ',
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    depth.value = int.tryParse(value) ?? 50;
                    calc();
                  },
                  validator: (value) {
                    if (double.tryParse(value ?? 'a') == null) {
                      isCollect.value = false;
                      return '深さの値を入力してください';
                    }
                    isCollect.value = isCollect.value && true;
                    return null;
                  },
                )
                // 深さの値を入力するテキストフィールド
                ,
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
                      // TODO(YumNumm): onTapした場所の検知 -> LatLngへの変換
                    },
                    child: InteractiveViewer(
                      maxScale: 100,
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
                          ),
                          // EEWの震央位置
                          CustomPaint(
                            painter: HypocenterPainterfromLatLng(
                              hypocenter: LatLng(lat.value, lon.value),
                            ),
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
