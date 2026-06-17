// ignore_for_file: provider_dependencies
import 'dart:isolate';
import 'dart:math' as math;

import 'package:eqmonitor/core/provider/estimated_intensity/data/estimated_intensity_data_source.dart';
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
    List<EewTelegramItem> eews,
    EarthquakeParameter parameter,
  ) {
    _cachedPoints ??= _generateCachedPoints(parameter);
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
          cityCode: _cachedPoints![i].cityCode,
          station: _cachedPoints![i].station,
          intensity: intensities[i],
        ),
    ];
  }

  Future<Iterable<EstimatedIntensityPoint>> calcInIsolate(
    List<EewTelegramItem> eews,
    EarthquakeParameter parameter,
  ) async {
    _cachedPoints ??= _generateCachedPoints(parameter);
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
          cityCode: cachedPoints[i].cityCode,
          station: cachedPoints[i].station,
          intensity: intensities[i],
        ),
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

  List<CalculationPoint> _generateCalculationPoints(
    Iterable<_CachedPoint> points,
  ) => [
    for (final p in points)
      if (p.station.arv400 case final arv400?)
        (
          lat: p.station.location.lat,
          lon: p.station.location.lon,
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
