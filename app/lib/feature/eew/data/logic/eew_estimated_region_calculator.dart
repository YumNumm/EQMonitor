import 'dart:math' as math;

import 'package:eqmonitor/core/extension/double_to_jma_forecast_intensity.dart';
import 'package:eqmonitor/core/provider/estimated_intensity/data/estimated_intensity_station_index.dart';
import 'package:eqmonitor/core/provider/travel_time/model/travel_time_table.dart';
import 'package:eqmonitor/feature/eew/data/logic/s_wave_travel_time_lookup.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_estimated_region.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong2/latlong.dart' as latlong2;

final eewEstimatedRegionCalculatorProvider = Provider(
  (ref) => EewEstimatedRegionCalculator(
    sWaveTravelTimeLookup: ref.watch(sWaveTravelTimeLookupProvider),
  ),
);

typedef _RegionCalculation = ({
  String name,
  double maxIntensity,
  double? earliestSWaveTravelTime,
});

class EewEstimatedRegionCalculator {
  const new({
    required this.sWaveTravelTimeLookup,
  });

  final SWaveTravelTimeLookup sWaveTravelTimeLookup;

  List<EewEstimatedRegion> calculate({
    required List<EstimatedIntensityRegionStation> stations,
    required List<double> intensities,
    required TravelTimeTables tables,
    required int depth,
    required double latitude,
    required double longitude,
    required DateTime? originTime,
  }) {
    if (stations.length != intensities.length) {
      return [];
    }

    const distanceCalculator = latlong2.Distance();
    final regionMap = <String, _RegionCalculation>{};
    for (var i = 0; i < stations.length; i++) {
      final station = stations[i];
      final intensity = intensities[i];
      final sWaveTravelTime = switch (originTime) {
        null => null,
        _ => sWaveTravelTimeLookup.lookup(
          tables: tables,
          depth: depth,
          distanceKm: distanceCalculator.as(
            .Kilometer,
            latlong2.LatLng(station.point.lat, station.point.lon),
            latlong2.LatLng(latitude, longitude),
          ),
        ),
      };
      final current = regionMap[station.regionCode];
      regionMap[station.regionCode] = (
        name: station.regionName,
        maxIntensity: current == null
            ? intensity
            : math.max(current.maxIntensity, intensity),
        earliestSWaveTravelTime: switch ((
          current?.earliestSWaveTravelTime,
          sWaveTravelTime,
        )) {
          (null, final next) => next,
          (final current?, null) => current,
          (final current?, final next?) => math.min(current, next),
        },
      );
    }

    return [
      for (final entry in regionMap.entries)
        EewEstimatedRegion(
          regionCode: entry.key,
          regionName: entry.value.name,
          intensity: entry.value.maxIntensity,
          jmaIntensity: entry.value.maxIntensity.toJmaIntensity,
          sWaveArrivalTime: switch ((
            originTime,
            entry.value.earliestSWaveTravelTime,
          )) {
            (final originTime?, final travelTime?) => originTime.add(
              Duration(milliseconds: (travelTime * 1000).round()),
            ),
            _ => null,
          },
        ),
    ];
  }
}
