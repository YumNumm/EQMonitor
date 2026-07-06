import 'dart:math' as math;

import 'package:collection/collection.dart';
import 'package:eqmonitor/core/extension/double_to_jma_forecast_intensity.dart';
import 'package:eqmonitor/core/provider/estimated_intensity/data/estimated_intensity_data_source.dart';
import 'package:eqmonitor/core/provider/estimated_intensity/provider/estimated_intensity_isolate_provider.dart';
import 'package:eqmonitor/core/provider/travel_time/model/travel_time_table.dart';
import 'package:eqmonitor/core/provider/travel_time/provider/travel_time_provider.dart';
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
  final depth = hypocenter?.depth;
  if (hypocenter == null ||
      hypocenter.latitude == null ||
      hypocenter.longitude == null ||
      hypocenter.magnitude == null ||
      hypocenter.depth == null ||
      eew.isPlum ||
      accuracy == null ||
      accuracy.epicenter == 1 ||
      depth == null ||
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

  final intensities = await isolate.computeSingle(
    jmaMagnitude: hypocenter.magnitude!,
    depth: hypocenter.depth!,
    lat: hypocenter.latitude!,
    lon: hypocenter.longitude!,
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
          latlong2.LatLng(hypocenter.latitude!, hypocenter.longitude!),
        );
        final hypoDistanceKm = math.sqrt(
          math.pow(depth, 2) + math.pow(epicenterDistanceKm, 2),
        );

        // 走時テーブルからS波到達時間(秒)を逆引き
        final sTimeSec = _lookupSWaveTravelTime(
          travelTimeTables,
          depth,
          hypoDistanceKm,
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

/// 走時テーブルからS波到達時間(秒)を距離(km)から逆引き
double? _lookupSWaveTravelTime(
  TravelTimeTables tables,
  int depth,
  double distanceKm,
) {
  final depthTables = tables.table.where((t) => t.depth == depth).toList()
    ..sort((a, b) => a.distance.compareTo(b.distance));

  if (depthTables.isEmpty) {
    return null;
  }

  final d1 = depthTables.lastWhereOrNull(
    (t) => t.distance <= distanceKm,
  );
  final d2 = depthTables.firstWhereOrNull(
    (t) => t.distance >= distanceKm,
  );

  if (d1 == null || d2 == null) {
    return null;
  }

  if (d1.distance == d2.distance) {
    return d1.s;
  }

  // 線形補間
  final ratio = (distanceKm - d1.distance) / (d2.distance - d1.distance);
  return d1.s + ratio * (d2.s - d1.s);
}
