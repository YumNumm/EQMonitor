import 'package:eqapi_schema/model/lat_lng.dart';
import 'package:eqapi_schema/model/telegram_v3.dart';
import 'package:eqmonitor/common/component/map/view_model/map_viewmodel.dart';
import 'package:eqmonitor/feature/home/features/eew/eew_provider.dart';
import 'package:eqmonitor/feature/home/features/estimated_intensity/provider/estimated_intensity_provider.dart';
import 'package:eqmonitor/feature/home/features/kmoni_observation_points/model/kmoni_observation_point.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sheet/sheet.dart';

part 'home_viewmodel.g.dart';

@riverpod
HomeViewModel homeViewModel(HomeViewModelRef ref) => HomeViewModel(ref);

class HomeViewModel {
  HomeViewModel(this.ref) : super() {
    ref.listen(estimatedIntensityProvider, (_, next) {
      onEstimatedIntensityChanged(next);
    });
  }

  final HomeViewModelRef ref;
  final mapKey = GlobalKey(debugLabel: 'HomeView');

  double height = 0;

  SheetController sheetController = SheetController();

  void onEstimatedIntensityChanged(
    List<AnalyzedKmoniObservationPoint> points,
  ) {
    final filtered = _getTargets(points);
    if (filtered == null) {
      _resetPoC();
      ref.read(MapViewModelProvider(mapKey).notifier).animatedApplyBounds(
            padding: const EdgeInsets.all(8).add(
              EdgeInsets.only(
                bottom: height * sheetController.animation.value,
              ),
            ),
          );
      return;
    }
    // 表示領域を変える
    ref.read(MapViewModelProvider(mapKey).notifier)
      ..setBounds(
        filtered,
      )
      ..animatedApplyBounds(
        padding: const EdgeInsets.all(8).add(
          EdgeInsets.only(
            bottom: height * sheetController.animation.value,
          ),
        ),
      );
  }

  void _resetPoC() {
    ref.read(MapViewModelProvider(mapKey).notifier).reset();
  }

  /// 震度1以上の観測点のうち、震度が最大~最大-1の観測点を含むLatLngの配列を返す
  List<LatLng>? _getTargets(List<AnalyzedKmoniObservationPoint> points) {
    final filtered = points.where((e) => e.intensityValue! > 0).toList();
    if (filtered.isEmpty) {
      return null;
    }
    final max = filtered.first.intensityValue!;
    // しきい値
    final threshold = max - 3;
    final filteredPoints =
        filtered.where((e) => e.intensityValue! >= threshold);
    if (filteredPoints.isEmpty) {
      return null;
    }
    final latLngs = filteredPoints.map((e) => e.point.latLng).toList()
      ..addAll(
        ref
            .read(eewTelegramProvider)
            .where(
              (e) => e.latestEew is TelegramVxse45Body,
            )
            .map((e) => e.latestEew)
            .cast<TelegramVxse45Body>()
            .map((e) => e.hypocenter!.coordinate!),
      );
    return latLngs;
  }
}
