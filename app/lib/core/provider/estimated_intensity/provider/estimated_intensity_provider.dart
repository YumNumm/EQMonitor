// ignore_for_file: provider_dependencies
import 'dart:math' as math;

import 'package:eqmonitor/core/provider/estimated_intensity/data/estimated_intensity_data_source.dart';
import 'package:eqmonitor/core/provider/estimated_intensity/provider/estimated_intensity_isolate_provider.dart';
import 'package:eqmonitor/core/provider/estimated_intensity/worker/estimated_intensity_isolate.dart';
import 'package:eqmonitor/core/provider/jma_parameter/jma_parameter.dart';
import 'package:eqmonitor/feature/eew/data/eew_alive_telegram.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
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

  List<EstimatedIntensityPoint> calc(
    List<EewTelegramItem> eews,
    EarthquakeParameter parameter,
  ) {
    _cachedPoints ??= _generateCachedPoints(parameter);

    final targetEews = _targetHypocenters(eews);
    if (targetEews.isEmpty) {
      return [];
    }

    final intensities = _computeMaxIntensitiesOnMain(
      eews: targetEews,
      calculationPoints: _calculationPointsFromCached(_cachedPoints!),
    );

    return _buildPoints(_cachedPoints!, intensities);
  }

  Future<Iterable<EstimatedIntensityPoint>> calcInIsolate(
    List<EewTelegramItem> eews,
    EarthquakeParameter parameter,
  ) async {
    _cachedPoints ??= _generateCachedPoints(parameter);

    final targetEews = _targetHypocenters(eews);
    if (targetEews.isEmpty) {
      return [];
    }

    final cachedPoints = _cachedPoints!;
    final isolate = await ref.read(estimatedIntensityIsolateProvider.future);
    final intensities = await isolate.computeMax(eews: targetEews);

    return _buildPoints(cachedPoints, intensities);
  }

  List<EstimatedIntensityHypocenterInput> _targetHypocenters(
    List<EewTelegramItem> eews,
  ) => eews
      .where(
        (e) =>
            !e.isCanceled &&
            (e.hypocenter?.latitude != null && e.hypocenter?.longitude != null),
      )
      .where((e) {
        final hypocenter = e.hypocenter!;
        return hypocenter.magnitude != null && hypocenter.depth != null;
      })
      .map((e) {
        final hypocenter = e.hypocenter!;
        return (
          jmaMagnitude: hypocenter.magnitude!,
          depth: hypocenter.depth!,
          lat: hypocenter.latitude!,
          lon: hypocenter.longitude!,
        );
      })
      .toList();

  List<EstimatedIntensityPoint> _buildPoints(
    List<_CachedPoint> cachedPoints,
    List<double> intensities,
  ) {
    final calculationPoints = _calculationPointsFromCached(cachedPoints);
    if (calculationPoints.length != intensities.length) {
      return [];
    }

    var intensityIndex = 0;
    final points = <EstimatedIntensityPoint>[];
    for (final cachedPoint in cachedPoints) {
      if (cachedPoint.station.arv400 == null) {
        continue;
      }
      points.add(
        EstimatedIntensityPoint(
          regionCode: cachedPoint.regionCode,
          cityCode: cachedPoint.cityCode,
          station: cachedPoint.station,
          intensity: intensities[intensityIndex++],
        ),
      );
    }
    return points;
  }

  List<double> _computeMaxIntensitiesOnMain({
    required List<EstimatedIntensityHypocenterInput> eews,
    required List<CalculationPoint> calculationPoints,
  }) {
    final calculator = EstimatedIntensityDataSource();
    final results = <List<double>>[];

    for (final eew in eews) {
      final result = calculator
          .getEstimatedIntensity(
            points: calculationPoints,
            jmaMagnitude: eew.jmaMagnitude,
            depth: eew.depth,
            hypocenter: (lat: eew.lat, lon: eew.lon),
          )
          .toList();
      results.add(result);
    }

    if (results.isEmpty) {
      return [];
    }

    return [
      for (var i = 0; i < results.first.length; i++)
        results.map((result) => result[i]).reduce(math.max),
    ];
  }

  List<_CachedPoint> _generateCachedPoints(EarthquakeParameter earthquake) {
    final result = <_CachedPoint>[];
    for (final prefecture in earthquake.prefectures) {
      for (final region in prefecture.regions) {
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
    }
    return result;
  }

  List<CalculationPoint> _calculationPointsFromCached(
    Iterable<_CachedPoint> points,
  ) => [
    for (final point in points)
      if (point.station.arv400 case final arv400?)
        (
          lat: point.station.location.lat,
          lon: point.station.location.lon,
          arv400: arv400,
        ),
  ];
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
