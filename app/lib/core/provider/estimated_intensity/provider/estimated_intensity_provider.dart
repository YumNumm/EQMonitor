// ignore_for_file: provider_dependencies
import 'dart:isolate';
import 'dart:math' as math;

import 'package:eqmonitor/core/provider/estimated_intensity/data/estimated_intensity_data_source.dart';
import 'package:eqmonitor/core/provider/kmoni_observation_points/provider/kyoshin_observation_points_provider.dart';
import 'package:eqmonitor/feature/eew/data/eew_alive_telegram.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:eqmonitor/feature/parameter/data/model/kyoshin/kyoshin_observation_points_parameter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'estimated_intensity_provider.freezed.dart';
part 'estimated_intensity_provider.g.dart';

typedef _CachedPoint = ({
  String regionCode,
  double lat,
  double lon,
  double arv400,
});

typedef _EewHypocenterInput = ({
  double jmaMagnitude,
  int depth,
  double lat,
  double lon,
});

typedef _IntensityComputeArgs = ({
  List<_EewHypocenterInput> eews,
  List<CalculationPoint> calculationPoints,
});

List<double> _computeMaxIntensities(_IntensityComputeArgs args) {
  final calculator = EstimatedIntensityDataSource();
  final results = <List<double>>[];

  for (final eew in args.eews) {
    final result = calculator
        .getEstimatedIntensity(
          points: args.calculationPoints,
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
      results.map((r) => r[i]).reduce(math.max),
  ];
}

@Riverpod(keepAlive: true)
class EstimatedIntensity extends _$EstimatedIntensity {
  @override
  Future<List<EstimatedIntensityPoint>> build() async {
    ref.listen(eewAliveTelegramProvider, (_, next) async {
      final kyoshinParam =
          await ref.read(kyoshinObservationPointsProvider.future);
      final result = await calcInIsolate(next ?? [], kyoshinParam);
      state = AsyncData(result.toList());
    });
    final kyoshinParam =
        await ref.read(kyoshinObservationPointsProvider.future);

    final result = await calcInIsolate(
      ref.read(eewAliveTelegramProvider) ?? [],
      kyoshinParam,
    );
    return result.toList();
  }

  List<_CachedPoint>? _cachedPoints;
  List<CalculationPoint>? _calculationPoints;

  List<EstimatedIntensityPoint> calc(
    List<EewTelegramItem> eews,
    KyoshinObservationPointsParameter kyoshinParam,
  ) {
    _cachedPoints ??= _generateCachedPoints(kyoshinParam);
    _calculationPoints ??= _generateCalculationPoints(_cachedPoints!);

    final targetEews = eews
        .where((e) => !e.isCanceled && (e.hypocenter?.hasLatLng ?? false))
        .where((e) {
          final h = e.hypocenter!;
          return h.magnitude != null && h.depth != null;
        })
        .map((e) {
          final h = e.hypocenter!;
          return (
            jmaMagnitude: h.magnitude!,
            depth: h.depth!,
            lat: h.latitude!,
            lon: h.longitude!,
          );
        })
        .toList();

    if (targetEews.isEmpty) {
      return [];
    }

    final intensities = _computeMaxIntensities((
      eews: targetEews,
      calculationPoints: _calculationPoints!,
    ));

    return [
      for (var i = 0; i < intensities.length; i++)
        EstimatedIntensityPoint(
          regionCode: _cachedPoints![i].regionCode,
          intensity: intensities[i],
        ),
    ];
  }

  Future<Iterable<EstimatedIntensityPoint>> calcInIsolate(
    List<EewTelegramItem> eews,
    KyoshinObservationPointsParameter kyoshinParam,
  ) async {
    _cachedPoints ??= _generateCachedPoints(kyoshinParam);
    _calculationPoints ??= _generateCalculationPoints(_cachedPoints!);

    final targetEews = eews
        .where((e) => !e.isCanceled && (e.hypocenter?.hasLatLng ?? false))
        .where((e) {
          final h = e.hypocenter!;
          return h.magnitude != null && h.depth != null;
        })
        .map((e) {
          final h = e.hypocenter!;
          return (
            jmaMagnitude: h.magnitude!,
            depth: h.depth!,
            lat: h.latitude!,
            lon: h.longitude!,
          );
        })
        .toList();

    if (targetEews.isEmpty) {
      return [];
    }

    final cachedPoints = _cachedPoints!;
    final calculationPoints = _calculationPoints!;

    final intensities = await Isolate.run(
      () => _computeMaxIntensities((
        eews: targetEews,
        calculationPoints: calculationPoints,
      )),
    );

    return [
      for (var i = 0; i < intensities.length; i++)
        EstimatedIntensityPoint(
          regionCode: cachedPoints[i].regionCode,
          intensity: intensities[i],
        ),
    ];
  }

  List<_CachedPoint> _generateCachedPoints(
    KyoshinObservationPointsParameter kyoshinParam,
  ) {
    final result = <_CachedPoint>[];
    for (final point in kyoshinParam.points) {
      if (point.regionCode == null ||
          point.arv400 == null ||
          point.isSuspended) {
        continue;
      }
      result.add((
        regionCode: point.regionCode!,
        lat: point.location.lat,
        lon: point.location.lon,
        arv400: point.arv400!,
      ));
    }
    return result;
  }

  List<CalculationPoint> _generateCalculationPoints(
    Iterable<_CachedPoint> points,
  ) => [
    for (final p in points)
      (lat: p.lat, lon: p.lon, arv400: p.arv400),
  ];
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
    required double intensity,
  }) = _EstimatedIntensityPoint;
}
