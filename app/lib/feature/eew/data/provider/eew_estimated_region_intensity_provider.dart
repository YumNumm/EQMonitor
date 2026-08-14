import 'dart:math' as math;

import 'package:eqmonitor/core/extension/double_to_jma_forecast_intensity.dart';
import 'package:eqmonitor/core/provider/estimated_intensity/data/estimated_intensity_data_source.dart';
import 'package:eqmonitor/core/provider/estimated_intensity/provider/estimated_intensity_isolate_provider.dart';
import 'package:eqmonitor/core/provider/travel_time/provider/travel_time_provider.dart';
import 'package:eqmonitor/feature/eew/data/logic/s_wave_travel_time_lookup.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_estimated_region.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:latlong2/latlong.dart' as latlong2;
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
  final sWaveTravelTimeLookup = ref.watch(sWaveTravelTimeLookupProvider);

  final intensities = await isolate.computeSingle(
    jmaMagnitude: magnitude,
    depth: depth,
    lat: latitude,
    lon: longitude,
  );

  final stations = stationIndex.regionStations;

  // regionCode単位で最大震度を集約
  final regionMap = <String, (String name, double maxIntensity)>{};
  for (var i = 0; i < stations.length; i++) {
    final station = stations[i];
    final current = regionMap[station.regionCode];
    if (current == null || intensities[i] > current.$2) {
      regionMap[station.regionCode] = (station.regionName, intensities[i]);
    }
  }

  // 各regionの代表点(最大震度stationの位置)の震源距離からS波到達時刻を算出
  final regionStationMap = <String, CalculationPoint>{};
  for (var i = 0; i < stations.length; i++) {
    final station = stations[i];
    final current = regionMap[station.regionCode];
    if (current != null && intensities[i] == current.$2) {
      regionStationMap[station.regionCode] = station.point;
    }
  }

  final originTime = eew.originTime;
  const distanceCalc = latlong2.Distance();

  return regionMap.entries.map((entry) {
    final regionCode = entry.key;
    final (name, maxIntensity) = entry.value;
    final jmaIntensity = maxIntensity.toJmaIntensity;

    DateTime? sWaveArrivalTime;
    if (originTime != null) {
      final point = regionStationMap[regionCode];
      if (point != null) {
        final epicenterDistanceKm = distanceCalc.as(
          latlong2.LengthUnit.Kilometer,
          latlong2.LatLng(point.lat, point.lon),
          latlong2.LatLng(latitude, longitude),
        );
        final hypoDistanceKm = math.sqrt(
          math.pow(depth, 2) + math.pow(epicenterDistanceKm, 2),
        );

        // 走時テーブルからS波到達時間(秒)を逆引き
        final sTimeSec = sWaveTravelTimeLookup.lookup(
          tables: travelTimeTables,
          depth: depth,
          distanceKm: hypoDistanceKm,
        );
        if (sTimeSec != null) {
          sWaveArrivalTime = originTime.add(
            Duration(milliseconds: (sTimeSec * 1000).round()),
          );
        }
      }
    }

    return EewEstimatedRegion(
      regionCode: regionCode,
      regionName: name,
      intensity: maxIntensity,
      jmaIntensity: jmaIntensity,
      sWaveArrivalTime: sWaveArrivalTime,
    );
  }).toList();
}
