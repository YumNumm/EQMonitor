import 'package:collection/collection.dart';
import 'package:eqmonitor/api/int_calc/int_calc.dart';
import 'package:eqmonitor/const/kmoni/jma_intensity.dart';
import 'package:eqmonitor/page/main/kmoni_map.dart';
import 'package:eqmonitor/state/all_state.dart';
import 'package:eqmonitor/widget/intensity/intensity_widget.dart';
import 'package:eqmonitor/widget/intensity_calc/estimated_shindo_painter.dart';
import 'package:eqmonitor/widget/intensity_calc/map_eew_hypocenter_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong2/latlong.dart';

class IntensityEstimatePage extends HookConsumerWidget {
  const IntensityEstimatePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final intensityCalc = IntensityEstimateApi();
    final magnitude = useState<double>(8);
    final depth = useState<int>(50);
    final isCollect = useState<bool>(true);
    final intensityCalcResult =
        useState<Map<int, List<EstimatedEarthquakeParameterItem>>>({});
    final parameterProvider = ref.watch(parameterEarthquakeProvider);

    /// 計算処理にかかった時間
    final calcTime = useState<int?>(null);

    if (!parameterProvider.isMapLoaded) {
      return const Center(child: CircularProgressIndicator.adaptive());
    }
    print(intensityCalcResult.value.length);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final stopWatch = Stopwatch()..start();
          final result = intensityCalc.estimateIntensity(
            jmaMagnitude: magnitude.value,
            depth: depth.value.toDouble(),
            hypocenter: LatLng(35, 135),
            obsPoints: ref
                    .read(parameterEarthquakeProvider)
                    .parameterEarthquake
                    ?.items ??
                [],
          );
          intensityCalcResult.value =
              result.groupListsBy((element) => element.region.code);
          calcTime.value = (stopWatch..stop()).elapsedMicroseconds;
        },
        child: const Icon(Icons.calculate),
      ),
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
                                  ref.watch(kmoniMapProvider).mapPolygons,
                            ),
                          ),
                          // EEWの震央位置
                          CustomPaint(
                            painter: HypocenterPainterfromLatLng(
                              hypocenter: LatLng(35, 135),
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
