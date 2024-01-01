import 'package:eqapi_types/model/telegram_v3.dart';
import 'package:eqmonitor/core/component/map/view_model/map_viewmodel.dart';
import 'package:eqmonitor/feature/home/features/eew/provider/eew_alive_telegram.dart';
import 'package:eqmonitor/feature/home/features/estimated_intensity/provider/estimated_intensity_provider.dart';
import 'package:eqmonitor/feature/home/features/kmoni_observation_points/model/kmoni_observation_point.dart';
import 'package:flutter/material.dart';
import 'package:lat_lng/lat_lng.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sheet/sheet.dart';

part 'home_viewmodel.g.dart';

@riverpod
HomeViewModel homeViewModel(HomeViewModelRef ref) => HomeViewModel(ref);

class HomeViewModel {
  HomeViewModel(this.ref) : super() {
    Future<void>.delayed(const Duration(milliseconds: 100), () {
      onEstimatedIntensityChanged(
        ref.read(estimatedIntensityProvider),
      );
    });
    ref.listen(estimatedIntensityProvider, (_, next) {
      onEstimatedIntensityChanged(next);
    });
  }

  final HomeViewModelRef ref;
  final mapKey = const GlobalObjectKey(MapViewModel);

  double height = 0;

  SheetController sheetController = SheetController();

  int _lastEstimatedIntensityChangedEewsLength = -1;

  void onEstimatedIntensityChanged(
    List<AnalyzedKmoniObservationPoint> points,
  ) {
    final filtered = _getTargets(points);
    // EEWの要素数が変化したかチェック
    final length = ref.read(eewAliveTelegramProvider)?.length;
    if (_lastEstimatedIntensityChangedEewsLength != length) {
      _lastEstimatedIntensityChangedEewsLength = length ?? 0;
      ref.read(mapViewModelProvider(mapKey).notifier).resetMarkAsMoved();
    }
    if (filtered == null) {
      ref.read(mapViewModelProvider(mapKey).notifier).onRegisterRenderBox(
            () => ref
                .read(mapViewModelProvider(mapKey).notifier)
                .animatedApplyBoundsIfNeeded(
                  padding: const EdgeInsets.all(8).add(
                    EdgeInsets.only(
                      bottom: switch (sheetController.animation.value) {
                        < 0.3 => height * sheetController.animation.value,
                        _ => height * 0.3,
                      },
                    ),
                  ),
                ),
          );
      return;
    }
    // 表示領域を変える
    ref.read(mapViewModelProvider(mapKey).notifier)
      ..setBounds(
        filtered,
      )
      ..animatedApplyBoundsIfNeeded(
        padding: const EdgeInsets.all(8).add(
          EdgeInsets.only(
            bottom: switch (sheetController.animation.value) {
              < 0.3 => height * sheetController.animation.value,
              _ => height * 0.3,
            },
          ),
        ),
      );
  }

  /// 震度1以上の観測点のうち、震度が最大~最大-1の観測点を含むLatLngの配列を返す
  List<LatLng>? _getTargets(List<AnalyzedKmoniObservationPoint> points) {
    final filtered = points.where((e) => e.intensityValue! > 0).toList();
    if (filtered.isEmpty) {
      return null;
    }
    final max = filtered.first.intensityValue!;
    // しきい値
    final threshold = max - 2;
    final filteredPoints =
        filtered.where((e) => e.intensityValue! >= threshold);
    if (filteredPoints.isEmpty) {
      return null;
    }
    final latLngs = filteredPoints.map((e) => e.point.latLng).toList()
      ..addAll(
        (ref.read(eewAliveTelegramProvider) ?? [])
            .map((element) => element.latestEew)
            .whereType<TelegramVxse45Body>()
            .where((element) => element.hypocenter != null)
            .map((e) => e.hypocenter!.coordinate)
            .whereType<LatLng>(),
      );
    return latLngs;
  }
}
