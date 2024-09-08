// ignore_for_file: provider_dependencies
import 'dart:developer';
import 'dart:math' as math;

import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/core/provider/eew/eew_alive_telegram.dart';
import 'package:eqmonitor/core/provider/estimated_intensity/data/estimated_intensity_data_source.dart';
import 'package:eqmonitor/core/provider/jma_parameter/jma_parameter.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jma_parameter_api_client/jma_parameter_api_client.dart';
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
      final result = await calcInIsolate(
        next ?? [],
        parameter.earthquake,
      );
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
    List<EewV1> eews,
    EarthquakeParameter parameter,
  ) {
    // 計算前にPointを用意
    _cachedPoints ??= _generateCachedPoints(parameter);
    _calculationPoints ??= _generateCalculationPoints(_cachedPoints!);

    final calculator = ref.read(estimatedIntensityDataSourceProvider);
    final results = <List<double>>[];

    final targetEews = eews.where(
      (e) => !e.isCanceled && e.latitude != null && e.longitude != null,
    );
    if (targetEews.isEmpty) {
      return [];
    }

    for (final eew in targetEews) {
      final result = calculator.getEstimatedIntensity(
        points: _calculationPoints!.toList(),
        jmaMagnitude: eew.magnitude!,
        depth: eew.depth!,
        hypocenter: (lat: eew.latitude!, lon: eew.longitude!),
      ).toList();
      results.add(result);
    }

    // resultsのIterableそれぞれは同じ長さであることを確認
    assert(results.every((e) => e.length == _calculationPoints!.length));

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
    List<EewV1> eews,
    EarthquakeParameter parameter,
  ) async =>
      // TODO(YumNumm): 並列計算
      calc(eews, parameter);

  List<_CachedPoint> _generateCachedPoints(
    EarthquakeParameter earthquake,
  ) {
    final result = <_CachedPoint>[];
    for (final region in earthquake.regions) {
      for (final city in region.cities) {
        for (final station in city.stations) {
          result.add(
            (
              regionCode: region.code,
              cityCode: city.code,
              station: station,
            ),
          );
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
      result.add(
        (
          lat: point.station.latitude,
          lon: point.station.longitude,
          arv400: point.station.arv400,
        ),
      );
    }
    return result;
  }
}

@Riverpod(keepAlive: true)
Stream<Map<String, double>> estimatedIntensityCity(
  EstimatedIntensityCityRef ref,
) async* {
  final estimatedIntensity = ref.watch(estimatedIntensityProvider).valueOrNull;
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
Stream<Map<String, double>> estimatedIntensityRegion(
  EstimatedIntensityRegionRef ref,
) async* {
  final estimatedIntensity = ref.watch(estimatedIntensityProvider).valueOrNull;
  log(
    'estimatedIntensityRegion: ${estimatedIntensity.runtimeType}, ${estimatedIntensity?.length}',
    name: 'estimatedIntensityRegion',
  );
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
    log('estimatedIntensityRegion: ${map.entries.length}');
    yield map;
  }
}

@Freezed(toJson: false)
class EstimatedIntensityPoint with _$EstimatedIntensityPoint {
  const factory EstimatedIntensityPoint({
    required String regionCode,
    required String cityCode,
    required EarthquakeParameterStationItem station,
    required double intensity,
  }) = _EstimatedIntensityPoint;
}
