// ignore_for_file: provider_dependencies
import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/feature/home/features/estimated_intensity/data/estimated_intensity_data_source.dart';
import 'package:eqmonitor/feature/home/features/kmoni_observation_points/model/kmoni_observation_point.dart';
import 'package:eqmonitor/feature/home/features/kmoni_observation_points/provider/kyoshin_observation_points_provider.dart';
import 'package:lat_lng/lat_lng.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'estimated_intensity_provider.g.dart';

@Riverpod(keepAlive: true)
class EstimatedIntensity extends _$EstimatedIntensity {
  @override
  List<AnalyzedKmoniObservationPoint> build() {
    /*
    ref.listen(eewAliveTelegramProvider, (previous, next) {
      state = calc(next ?? []);
    });
    return calc(ref.read(eewAliveTelegramProvider) ?? []);*/
    return [];
    // TODO(YumNumm): Implement build
  }

  List<AnalyzedKmoniObservationPoint> calc(List<EewV1> eews) {
    final points = ref.read(kyoshinObservationPointsProvider);
    final results = <List<AnalyzedKmoniObservationPoint>>[];
    for (final eew in eews.where(
      (e) => !e.isCanceled && e.latitude != null && e.longitude != null,
    )) {
      results.add(
        ref.read(estimatedIntensityDataSourceProvider).getEstimatedIntensity(
              points: points.points,
              jmaMagnitude: eew.magnitude ?? 0,
              depth: eew.depth ?? 0,
              hypocenter: LatLng(eew.latitude!, eew.longitude!),
            ),
      );
    }

    final result = _merge(results)
      ..sort((a, b) => b.intensityValue!.compareTo(a.intensityValue!));
    return result;
  }

  /// 同一観測点の結果をマージする
  /// より大きい震度を返す
  List<AnalyzedKmoniObservationPoint> _merge(
    List<List<AnalyzedKmoniObservationPoint>> results,
  ) {
    final merged = <AnalyzedKmoniObservationPoint>[];
    for (final result in results) {
      for (final point in result) {
        final index = merged.indexWhere((e) => e.point == point.point);
        if (index == -1) {
          merged.add(point);
        } else {
          merged[index] = merged[index].intensityValue! > point.intensityValue!
              ? merged[index]
              : point;
        }
      }
    }
    return merged;
  }
}
