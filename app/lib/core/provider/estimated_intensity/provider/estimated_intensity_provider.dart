// ignore_for_file: provider_dependencies
import 'dart:math' as math;

import 'package:eqmonitor_api/export.dart';
import 'package:eqmonitor/core/provider/estimated_intensity/data/estimated_intensity_data_source.dart';
import 'package:eqmonitor/core/provider/jma_parameter/jma_parameter.dart';
import 'package:eqmonitor/feature/eew/data/eew_alive_telegram.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'estimated_intensity_provider.freezed.dart';
part 'estimated_intensity_provider.g.dart';

typedef _CachedPoint = ({
  String regionCode,
  String cityCode,
  EarthquakeParameterStationItem station,
});

@Riverpod(keepAlive: true)
class EstimatedIntensity extends _$EstimatedIntensity {
  @override
  Future<List<EstimatedIntensityPoint>> build() async {
    ref.listen(eewAliveTelegramProvider, (_, next) async {
      final parameter = await ref.read(jmaParameterProvider.future);
      final result = await calcInIsolate(next ?? [], parameter.earthquake);
      state = AsyncData(result.toList());
    });
    final parameter = await ref.read(jmaParameterProvider.future);

    final result = await calcInIsolate(
      ref.read(eewAliveTelegramProvider) ?? [],
      parameter.earthquake,
    );
    return result.toList();
  }

  List<_CachedPoint>? _cachedPoints;
  List<CalculationPoint>? _calculationPoints;

  List<EstimatedIntensityPoint> calc(
    List<EewItemWithRelations> eews,
    EarthquakeParameter parameter,
  ) {
    // 計算前にPointを用意
    _cachedPoints ??= _generateCachedPoints(parameter);
    _calculationPoints ??= _generateCalculationPoints(_cachedPoints!);

    final calculator = ref.read(estimatedIntensityDataSourceProvider);
    final results = <List<double>>[];

    final targetEews = eews.where((e) {
      if (e.isCanceled) {
        return false;
      }
      final coords = e.hypocenter?.coordinates;
      return coords != null && coords.type == CoordinateType.latLng;
    });
    if (targetEews.isEmpty) {
      return [];
    }

    for (final eew in targetEews) {
      final hypocenter = eew.hypocenter!;
      final coords = hypocenter.coordinates;
      final magnitude = hypocenter.magnitude;
      final depth = hypocenter.depth;
      if (magnitude == null || depth == null) {
        continue;
      }
      final result = calculator
          .getEstimatedIntensity(
            points: _calculationPoints!.toList(),
            jmaMagnitude: magnitude.toDouble(),
            depth: depth.toInt(),
            hypocenter: (lat: coords.latitude!.toDouble(), lon: coords.longitude!.toDouble()),
          )
          .toList();
      results.add(result);
    }

    if (results.isEmpty) {
      return [];
    }

    // resultsのIterableそれぞれは同じ長さであることを確認
    assert(
      results.every((e) => e.length == _calculationPoints!.length),
      'results length must be same as calculationPoints length',
    );

    final result = <EstimatedIntensityPoint>[];
    // それぞれについて最大の値を取る
    for (var index = 0; index < results.first.length; index++) {
      final values = results.map((e) => e[index]);
      final max = values.reduce(math.max);
      result.add(
        EstimatedIntensityPoint(
          regionCode: _cachedPoints![index].regionCode,
          cityCode: _cachedPoints![index].cityCode,
          station: _cachedPoints![index].station,
          intensity: max,
        ),
      );
    }
    return result;
  }

  Future<Iterable<EstimatedIntensityPoint>> calcInIsolate(
    List<EewItemWithRelations> eews,
    EarthquakeParameter parameter,
  ) async =>
      // TODO(YumNumm): 並列計算
      calc(eews, parameter);

  List<_CachedPoint> _generateCachedPoints(EarthquakeParameter earthquake) {
    final result = <_CachedPoint>[];
    for (final region in earthquake.regions) {
      for (final city in region.cities) {
        for (final station in city.stations) {
          result.add((
            regionCode: region.code,
            cityCode: city.code,
            station: station,
          ));
        }
      }
    }
    return result;
  }

  List<CalculationPoint> _generateCalculationPoints(
    Iterable<_CachedPoint> points,
  ) {
    final result = <CalculationPoint>[];
    for (final point in points) {
      result.add((
        lat: point.station.latitude,
        lon: point.station.longitude,
        arv400: point.station.arv400,
      ));
    }
    return result;
  }
}

@Riverpod(keepAlive: true)
Stream<Map<String, double>> estimatedIntensityCity(Ref ref) async* {
  final estimatedIntensity = ref.watch(estimatedIntensityProvider).value;
  if (estimatedIntensity != null) {
    final map = <String, double>{};
    for (final item in estimatedIntensity) {
      final currentValue = map[item.cityCode];
      if (currentValue == null) {
        map[item.cityCode] = item.intensity;
      } else {
        map[item.cityCode] = math.max(currentValue, item.intensity);
      }
    }
    yield map;
  }
}

@Riverpod(keepAlive: true)
Stream<Map<String, double>> estimatedIntensityRegion(Ref ref) async* {
  final estimatedIntensity = ref.watch(estimatedIntensityProvider).value;
  if (estimatedIntensity != null) {
    final map = <String, double>{};
    for (final item in estimatedIntensity) {
      final currentValue = map[item.regionCode];
      if (currentValue == null) {
        map[item.regionCode] = item.intensity;
      } else {
        map[item.regionCode] = math.max(currentValue, item.intensity);
      }
    }
    yield map;
  }
}

@Freezed(toJson: false)
abstract class EstimatedIntensityPoint with _$EstimatedIntensityPoint {
  const factory EstimatedIntensityPoint({
    required String regionCode,
    required String cityCode,
    required EarthquakeParameterStationItem station,
    required double intensity,
  }) = _EstimatedIntensityPoint;
}
