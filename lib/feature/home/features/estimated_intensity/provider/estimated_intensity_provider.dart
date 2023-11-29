import 'package:eqapi_types/model/telegram_v3.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/feature/earthquake_history/model/state/earthquake_history_item.dart';
import 'package:eqmonitor/feature/home/features/eew/eew_provider.dart';
import 'package:eqmonitor/feature/home/features/estimated_intensity/data/estimated_intensity_data_source.dart';
import 'package:eqmonitor/feature/home/features/kmoni_observation_points/model/kmoni_observation_point.dart';
import 'package:eqmonitor/feature/home/features/kmoni_observation_points/provider/kmoni_observation_points_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'estimated_intensity_provider.g.dart';

@Riverpod(dependencies: [EewTelegram])
class EstimatedIntensity extends _$EstimatedIntensity {
  @override
  List<AnalyzedKmoniObservationPoint> build() {
    _dataSource = ref.watch(estimatedIntensityDataSourceProvider);
    _talker = ref.watch(talkerProvider);
    ref.listen(eewTelegramProvider, (previous, next) {
      state = calc(next);
      _talker.logTyped(
        EstimatedIntensityLog('EstimatedIntensity: ${state.length}'),
      );
    });
    return calc(ref.read(eewTelegramProvider));
  }

  late EstimatedIntensityDataSource _dataSource;
  late Talker _talker;

  List<AnalyzedKmoniObservationPoint> calc(List<EarthquakeHistoryItem> eews) {
    final points = ref.read(kmoniObservationPointsProvider);
    final results = <List<AnalyzedKmoniObservationPoint>>[];
    for (final eew in eews
        .where((e) => e.latestEew != null && e.latestEew is TelegramVxse45Body)
        .map((e) => e.latestEew! as TelegramVxse45Body)) {
      results.add(
        _dataSource.getEstimatedIntensity(
          points: points,
          jmaMagnitude: eew.magnitude ?? 0,
          depth: eew.depth ?? 0,
          hypocenter: eew.hypocenter!.coordinate!,
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
