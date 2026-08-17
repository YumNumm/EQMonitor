import 'package:eqmonitor/core/provider/estimated_intensity/provider/estimated_intensity_isolate_provider.dart';
import 'package:eqmonitor/core/provider/travel_time/provider/travel_time_provider.dart';
import 'package:eqmonitor/feature/eew/data/logic/eew_estimated_region_calculator.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_estimated_region.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'eew_estimated_region_intensity_provider.g.dart';

@riverpod
Future<List<EewEstimatedRegion>> eewEstimatedRegionIntensity(
  Ref ref,
  EewTelegramItem eew,
) async {
  final hypocenter = eew.hypocenter;
  final accuracy = eew.accuracy;
  if (hypocenter == null || accuracy == null) {
    return [];
  }
  final latitude = hypocenter.latitude;
  final longitude = hypocenter.longitude;
  final magnitude = hypocenter.magnitude;
  final depth = hypocenter.depth;
  if (latitude == null ||
      longitude == null ||
      magnitude == null ||
      depth == null ||
      eew.isPlum ||
      accuracy.epicenter == 1 ||
      depth >= 150) {
    return [];
  }

  final stationIndex = await ref.watch(
    estimatedIntensityStationIndexProvider.future,
  );
  if (stationIndex.regionStations.isEmpty) {
    return [];
  }

  final isolate = await ref.watch(estimatedIntensityIsolateProvider.future);
  final travelTimeTables = await ref.watch(travelTimeInternalProvider.future);
  final calculator = ref.watch(eewEstimatedRegionCalculatorProvider);

  final intensities = await isolate.computeSingle(
    jmaMagnitude: magnitude,
    depth: depth,
    lat: latitude,
    lon: longitude,
  );

  return calculator.calculate(
    stations: stationIndex.regionStations,
    intensities: intensities,
    tables: travelTimeTables,
    depth: depth,
    latitude: latitude,
    longitude: longitude,
    originTime: eew.originTime,
  );
}
