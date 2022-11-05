import 'dart:math';

import 'package:eqmonitor/schema/remote/dmdata/eew-information/earthquake/accuracy/number_of_magnitude_calculation.dart';
import 'package:eqmonitor/schema/remote/dmdata/eew-information/intensity/forecast_max_int.dart';
import 'package:eqmonitor/ui/theme/jma_intensity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong2/latlong.dart';

import '../../../../provider/earthquake/eew_controller.dart';
import '../../../../schema/remote/dmdata/eew-information/earthquake/accuracy.dart';
import '../../../../schema/remote/dmdata/eew-information/earthquake/accuracy/depth_calculation.dart';
import '../../../../schema/remote/dmdata/eew-information/earthquake/accuracy/epicCenterAccuracy.dart';
import '../../../../schema/remote/dmdata/eew-information/earthquake/accuracy/magnitude_calculation.dart';

class EewTestPage extends HookConsumerWidget {
  const EewTestPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final maxIntensityTo = useState<JmaIntensity>(JmaIntensity.Unknown);
    final maxIntensityFrom = useState<JmaIntensity>(JmaIntensity.Unknown);

    final magnitude = useState<double>(8);
    final depth = useState<int>(50);
    final hypo = useState<LatLng>(LatLng(35, 135));
    final accuracy = useState<Accuracy>(
      Accuracy(
        depthCalculation: DepthCalculation.f1,
        epicCenterAccuracy: EpicCenters(
          epicCenterAccuracy: EpicCenterAccuracy.f1,
          hypoCenterAccuracy: HypoCenterAccuracy.f1,
        ),
        magnitudeCalculation: MagnitudeCalculation.f2,
        numberOfMagnitudeCalculation: NumberOfMagnitudeCalculation.f1,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('EEWテスト'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              DropdownButtonFormField<JmaIntensity>(
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  label: const Text('予想最大震度(From)'),
                  filled: true,
                  fillColor: maxIntensityFrom.value.color.withOpacity(0.2),
                ),
                items: JmaIntensity.values
                    .map(
                      (e) => DropdownMenuItem(
                        value: e,
                        child: Text(e.toString()),
                      ),
                    )
                    .toList(),
                onChanged: (e) => maxIntensityFrom.value = e!,
                value: maxIntensityFrom.value,
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<JmaIntensity>(
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  label: const Text('予想最大震度(To)'),
                  filled: true,
                  fillColor: maxIntensityTo.value.color.withOpacity(0.2),
                ),
                items: JmaIntensity.values
                    .map(
                      (e) => DropdownMenuItem(
                        value: e,
                        child: Text(e.toString()),
                      ),
                    )
                    .toList(),
                onChanged: (e) => maxIntensityTo.value = e!,
                value: maxIntensityTo.value,
              ),
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
                                onChanged: (value) => magnitude.value =
                                    double.parse(value.toStringAsFixed(1)),
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
                                onChanged: (value) =>
                                    depth.value = value.toInt(),
                              ),
                            ),
                          ],
                        ),
                        // 経度
                        Row(
                          children: [
                            Text(
                              '経度 ${hypo.value.longitude.toStringAsFixed(1)}',
                            ),
                            Expanded(
                              child: Slider.adaptive(
                                value: hypo.value.longitude,
                                min: 120,
                                max: 150,
                                divisions: 300,
                                label: hypo.value.longitude.toStringAsFixed(1),
                                onChanged: (value) => hypo.value =
                                    LatLng(hypo.value.latitude, value),
                              ),
                            ),
                          ],
                        ),
                        // 緯度
                        Row(
                          children: [
                            Text(
                              '緯度 ${hypo.value.latitude.toStringAsFixed(1)}',
                            ),
                            Expanded(
                              child: Slider.adaptive(
                                value: hypo.value.latitude,
                                min: 25,
                                max: 50,
                                divisions: 250,
                                label: hypo.value.latitude.toStringAsFixed(1),
                                onChanged: (value) => hypo.value =
                                    LatLng(value, hypo.value.longitude),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ), // マッ
              ExpansionTile(
                title: const Text('精度情報'),
                leading: const Icon(Icons.precision_manufacturing),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: DropdownButtonFormField<DepthCalculation>(
                      key: const Key('depthCalculation'),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text('深さの精度値'),
                      ),
                      items: DepthCalculation.values
                          .map(
                            (e) => DropdownMenuItem<DepthCalculation>(
                              value: e,
                              child: Text(e.description),
                            ),
                          )
                          .toList(),
                      onChanged: (e) => accuracy.value = Accuracy(
                        depthCalculation: e!,
                        epicCenterAccuracy: accuracy.value.epicCenterAccuracy,
                        magnitudeCalculation:
                            accuracy.value.magnitudeCalculation,
                        numberOfMagnitudeCalculation:
                            accuracy.value.numberOfMagnitudeCalculation,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: DropdownButtonFormField<EpicCenterAccuracy>(
                      key: const Key('EpicCenterAccuracy'),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text('EpicCenterAccuracy'),
                      ),
                      items: EpicCenterAccuracy.values
                          .map(
                            (e) => DropdownMenuItem<EpicCenterAccuracy>(
                              value: e,
                              child: Text(e.description),
                            ),
                          )
                          .toList(),
                      onChanged: (e) => accuracy.value = Accuracy(
                        depthCalculation: accuracy.value.depthCalculation,
                        epicCenterAccuracy: EpicCenters(
                          epicCenterAccuracy: e!,
                          hypoCenterAccuracy: accuracy
                              .value.epicCenterAccuracy.hypoCenterAccuracy,
                        ),
                        magnitudeCalculation:
                            accuracy.value.magnitudeCalculation,
                        numberOfMagnitudeCalculation:
                            accuracy.value.numberOfMagnitudeCalculation,
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(),
              FloatingActionButton.extended(
                heroTag: 'send',
                onPressed: () {
                  final hash = ref.read(eewHistoryProvider.notifier).addTestEew(
                        maxint: ForecastMaxInt(
                          from: maxIntensityFrom.value,
                          to: maxIntensityTo.value,
                        ),
                        lat: hypo.value.latitude,
                        lon: hypo.value.longitude,
                        depth: depth.value,
                        magnitude: magnitude.value,
                        accuracy: accuracy.value,
                        arrivalTime: DateTime.now(),
                        originTime: DateTime.now(),
                      );
                  GoRouter.of(context).pop();
                  Fluttertoast.showToast(msg: 'テストEEWを追加しました $hash');
                },
                label: const Text('テストEEWを作成'),
                icon: const Icon(Icons.warning),
              ),
              const SizedBox(height: 8),
              FloatingActionButton.extended(
                heroTag: 'newsend',
                onPressed: () {
                  final hash = ref.read(eewHistoryProvider.notifier).addTestEew(
                        maxint: ForecastMaxInt(
                          from: maxIntensityFrom.value,
                          to: maxIntensityTo.value,
                        ),
                        lat: hypo.value.latitude,
                        lon: hypo.value.longitude,
                        depth: depth.value,
                        magnitude: magnitude.value,
                        accuracy: accuracy.value,
                        arrivalTime: DateTime.now(),
                        originTime: DateTime.now(),
                        eventId: Random().nextInt(100000),
                      );
                  GoRouter.of(context).pop();
                  Fluttertoast.showToast(msg: 'テストEEWを追加しました $hash');
                },
                label: const Text('テストEEWを新規作成'),
                icon: const Icon(Icons.warning),
              ),
              const Divider(),
              FloatingActionButton.extended(
                heroTag: 'delete',
                onPressed: () {
                  ref.read(eewHistoryProvider.notifier).clearTelegrams();
                  GoRouter.of(context).pop();
                  Fluttertoast.showToast(msg: 'EEWを全て削除しました');
                },
                label: const Text('EEW全クリア'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
