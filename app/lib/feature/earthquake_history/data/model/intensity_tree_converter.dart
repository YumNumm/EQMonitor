import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_station.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_tree.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/lpgm_intensity_tree.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:jma_parameter_types/earthquake_param.pb.dart';

Map<String, EarthquakeParameterCityItem> _cityParamMap(
  EarthquakeParameter parameter,
) {
  final map = <String, EarthquakeParameterCityItem>{};
  for (final r in parameter.regions) {
    for (final c in r.cities) {
      map[c.code] = c;
    }
  }
  return map;
}

Map<String, EarthquakeParameterStationItem> _stationParamMap(
  EarthquakeParameter parameter,
) {
  final map = <String, EarthquakeParameterStationItem>{};
  for (final r in parameter.regions) {
    for (final c in r.cities) {
      for (final s in c.stations) {
        map[s.code] = s;
      }
    }
  }
  return map;
}

String? _prefectureRegionCode(
  EarthquakeParameter parameter,
  EarthquakeParameterCityItem city,
) {
  for (final r in parameter.regions) {
    for (final c in r.cities) {
      if (c.code == city.code) {
        return r.code;
      }
    }
  }
  return null;
}

Map<String, List<api.IntensityStationItem>> _stationsByCityPrefix(
  List<api.IntensityStationItem> stations,
) {
  final map = <String, List<api.IntensityStationItem>>{};
  for (final s in stations) {
    final code = s.value.code;
    if (code.length < 5) {
      continue;
    }
    final prefix = code.substring(0, 5);
    map.putIfAbsent(prefix, () => []).add(s);
  }
  return map;
}

Map<JmaIntensity, List<RegionIntensityNode>> convertToIntensityTree({
  required api.Intensity intensity,
  required EarthquakeParameter parameter,
  List<api.IntensityItem>? cities,
  List<api.IntensityStationItem>? stations,
}) {
  final citiesList = cities ?? intensity.cities;
  final stationsList = stations ?? intensity.stations;
  if (citiesList != null && citiesList.isNotEmpty) {
    return _intensityTreeFromCities(
      intensity,
      parameter,
      citiesList,
      stations: stationsList,
    );
  }
  if (intensity.regions.isNotEmpty) {
    return _intensityTreeFromRegions(intensity, parameter);
  }
  return _intensityTreeFromPrefecturesOnly(intensity, parameter);
}

Map<JmaIntensity, List<RegionIntensityNode>> _intensityTreeFromCities(
  api.Intensity intensity,
  EarthquakeParameter parameter,
  List<api.IntensityItem> apiCities, {
  List<api.IntensityStationItem>? stations,
}) {
  final cityParam = _cityParamMap(parameter);
  final stationParam = _stationParamMap(parameter);
  final stationsList = stations ?? const <api.IntensityStationItem>[];
  final byPrefix = _stationsByCityPrefix(stationsList);

  final grouped = <JmaIntensity, Map<String, List<CityIntensityNode>>>{};

  for (final apiCity in apiCities) {
    final jma = apiCity.maxIntensity?.toJmaIntensity;
    if (jma == null) {
      continue;
    }

    final cityItem = cityParam[apiCity.value.code];
    if (cityItem == null) {
      continue;
    }

    final code = apiCity.value.code;
    if (code.length < 5) {
      continue;
    }
    final prefCode = _prefectureRegionCode(parameter, cityItem);
    if (prefCode == null) {
      continue;
    }
    final cityPrefix = code.substring(0, 5);

    final matchedApiStations = (byPrefix[cityPrefix] ?? const [])
        .where((s) => s.maxIntensity == apiCity.maxIntensity)
        .toList();

    final stationNodes = <StationIntensityNode>[];
    for (final st in matchedApiStations) {
      final paramSt = stationParam[st.value.code];
      if (paramSt == null) {
        continue;
      }
      stationNodes.add(
        StationIntensityNode(
          station: paramSt,
          intensity: st.toIntensityStation,
        ),
      );
    }
    stationNodes.sort((a, b) => a.station.name.compareTo(b.station.name));

    final lpgm = apiCity.maxLpgmIntensity?.toJmaLpgmIntensity;

    final cityNode = CityIntensityNode(
      city: cityItem,
      maxIntensity: jma,
      maxLpgmIntensity: lpgm,
      stations: stationNodes,
    );

    grouped
        .putIfAbsent(jma, () => {})
        .putIfAbsent(prefCode, () => [])
        .add(cityNode);
  }

  return _finalizeIntensityTree(grouped, parameter);
}

Map<JmaIntensity, List<RegionIntensityNode>> _intensityTreeFromPrefecturesOnly(
  api.Intensity intensity,
  EarthquakeParameter parameter,
) {
  final paramRegionMap = {for (final r in parameter.regions) r.code: r};
  final grouped = <JmaIntensity, List<RegionIntensityNode>>{};

  for (final pref in intensity.prefectures) {
    final regionItem = paramRegionMap[pref.value.code];
    if (regionItem == null) {
      continue;
    }
    final jma = pref.maxIntensity?.toJmaIntensity;
    if (jma == null) {
      continue;
    }

    grouped
        .putIfAbsent(jma, () => [])
        .add(
          RegionIntensityNode(
            region: regionItem,
            maxIntensity: jma,
            cities: const [],
          ),
        );
  }

  for (final entry in grouped.entries) {
    entry.value.sort((a, b) => a.region.name.compareTo(b.region.name));
  }

  return Map.fromEntries(
    grouped.entries.toList()
      ..sort((a, b) => b.key.orderIndex.compareTo(a.key.orderIndex)),
  );
}

Map<JmaIntensity, List<RegionIntensityNode>> _intensityTreeFromRegions(
  api.Intensity intensity,
  EarthquakeParameter parameter,
) {
  final regionIntensityMap = {
    for (final r in intensity.regions) r.value.code: r,
  };

  final grouped = <JmaIntensity, Map<String, List<CityIntensityNode>>>{};

  for (final region in parameter.regions) {
    for (final city in region.cities) {
      final item = regionIntensityMap[city.code];
      if (item == null) {
        continue;
      }
      final jma = item.maxIntensity?.toJmaIntensity;
      if (jma == null) {
        continue;
      }

      grouped
          .putIfAbsent(jma, () => {})
          .putIfAbsent(region.code, () => [])
          .add(
            CityIntensityNode(
              city: city,
              maxIntensity: jma,
              maxLpgmIntensity: item.maxLpgmIntensity?.toJmaLpgmIntensity,
              stations: const [],
            ),
          );
    }
  }

  return _finalizeIntensityTree(grouped, parameter);
}

Map<JmaIntensity, List<RegionIntensityNode>> _finalizeIntensityTree(
  Map<JmaIntensity, Map<String, List<CityIntensityNode>>> grouped,
  EarthquakeParameter parameter,
) {
  final paramRegionMap = {for (final r in parameter.regions) r.code: r};

  final result = <JmaIntensity, List<RegionIntensityNode>>{};

  for (final entry in grouped.entries) {
    final intensityKey = entry.key;
    final prefectureCities = entry.value;

    final regionNodes = <RegionIntensityNode>[];
    for (final prefEntry in prefectureCities.entries) {
      final regionItem = paramRegionMap[prefEntry.key];
      if (regionItem == null) {
        continue;
      }

      final cities = prefEntry.value
        ..sort((a, b) {
          final aOrder = a.maxIntensity?.orderIndex ?? -1;
          final bOrder = b.maxIntensity?.orderIndex ?? -1;
          if (aOrder != bOrder) {
            return bOrder.compareTo(aOrder);
          }
          return a.city.name.compareTo(b.city.name);
        });

      regionNodes.add(
        RegionIntensityNode(
          region: regionItem,
          maxIntensity: intensityKey,
          cities: cities,
        ),
      );
    }

    regionNodes.sort((a, b) => a.region.name.compareTo(b.region.name));

    result[intensityKey] = regionNodes;
  }

  return Map.fromEntries(
    result.entries.toList()
      ..sort((a, b) => b.key.orderIndex.compareTo(a.key.orderIndex)),
  );
}

Map<JmaLpgmIntensity, List<RegionLpgmIntensityNode>>
convertToLpgmIntensityTree({
  required api.Intensity intensity,
  required EarthquakeParameter parameter,
  List<api.IntensityItem>? cities,
  List<api.IntensityStationItem>? stations,
}) {
  final citiesList = cities ?? intensity.cities;
  final stationsList = stations ?? intensity.stations;
  if (citiesList != null && citiesList.isNotEmpty) {
    return _lpgmTreeFromCities(
      intensity,
      parameter,
      citiesList,
      stations: stationsList,
    );
  }
  if (intensity.regions.isNotEmpty) {
    return _lpgmTreeFromRegions(intensity, parameter);
  }
  return _lpgmTreeFromPrefecturesOnly(intensity, parameter);
}

Map<JmaLpgmIntensity, List<RegionLpgmIntensityNode>> _lpgmTreeFromCities(
  api.Intensity intensity,
  EarthquakeParameter parameter,
  List<api.IntensityItem> apiCities, {
  List<api.IntensityStationItem>? stations,
}) {
  final cityParam = _cityParamMap(parameter);
  final stationParam = _stationParamMap(parameter);
  final stationsList = stations ?? const <api.IntensityStationItem>[];
  final byPrefix = _stationsByCityPrefix(stationsList);

  final grouped =
      <JmaLpgmIntensity, Map<String, List<CityLpgmIntensityNode>>>{};

  for (final apiCity in apiCities) {
    final lpgm = apiCity.maxLpgmIntensity?.toJmaLpgmIntensity;
    if (lpgm == null) {
      continue;
    }

    final cityItem = cityParam[apiCity.value.code];
    if (cityItem == null) {
      continue;
    }

    final code = apiCity.value.code;
    if (code.length < 5) {
      continue;
    }
    final prefCode = _prefectureRegionCode(parameter, cityItem);
    if (prefCode == null) {
      continue;
    }
    final cityPrefix = code.substring(0, 5);

    final matchedApiStations = (byPrefix[cityPrefix] ?? const [])
        .where((s) => s.maxLpgmIntensity == apiCity.maxLpgmIntensity)
        .toList();

    final stationNodes = <StationLpgmIntensityNode>[];
    for (final st in matchedApiStations) {
      final paramSt = stationParam[st.value.code];
      if (paramSt == null) {
        continue;
      }
      stationNodes.add(
        StationLpgmIntensityNode(
          station: paramSt,
          intensity: st.toIntensityStation,
        ),
      );
    }
    stationNodes.sort((a, b) => a.station.name.compareTo(b.station.name));

    final cityNode = CityLpgmIntensityNode(
      city: cityItem,
      maxLpgmIntensity: lpgm,
      stations: stationNodes,
    );

    grouped
        .putIfAbsent(lpgm, () => {})
        .putIfAbsent(prefCode, () => [])
        .add(cityNode);
  }

  return _finalizeLpgmTree(grouped, parameter);
}

Map<JmaLpgmIntensity, List<RegionLpgmIntensityNode>>
_lpgmTreeFromPrefecturesOnly(
  api.Intensity intensity,
  EarthquakeParameter parameter,
) {
  final paramRegionMap = {for (final r in parameter.regions) r.code: r};
  final grouped = <JmaLpgmIntensity, List<RegionLpgmIntensityNode>>{};

  for (final pref in intensity.prefectures) {
    final regionItem = paramRegionMap[pref.value.code];
    if (regionItem == null) {
      continue;
    }
    final lpgm = pref.maxLpgmIntensity?.toJmaLpgmIntensity;
    if (lpgm == null) {
      continue;
    }

    grouped
        .putIfAbsent(lpgm, () => [])
        .add(
          RegionLpgmIntensityNode(
            region: regionItem,
            maxLpgmIntensity: lpgm,
            cities: const [],
          ),
        );
  }

  for (final entry in grouped.entries) {
    entry.value.sort((a, b) => a.region.name.compareTo(b.region.name));
  }

  return Map.fromEntries(
    grouped.entries.toList()
      ..sort((a, b) => b.key.orderIndex.compareTo(a.key.orderIndex)),
  );
}

Map<JmaLpgmIntensity, List<RegionLpgmIntensityNode>> _lpgmTreeFromRegions(
  api.Intensity intensity,
  EarthquakeParameter parameter,
) {
  final regionIntensityMap = {
    for (final r in intensity.regions) r.value.code: r,
  };

  final grouped =
      <JmaLpgmIntensity, Map<String, List<CityLpgmIntensityNode>>>{};

  for (final region in parameter.regions) {
    for (final city in region.cities) {
      final item = regionIntensityMap[city.code];
      if (item == null) {
        continue;
      }
      final lpgm = item.maxLpgmIntensity?.toJmaLpgmIntensity;
      if (lpgm == null) {
        continue;
      }

      grouped
          .putIfAbsent(lpgm, () => {})
          .putIfAbsent(region.code, () => [])
          .add(
            CityLpgmIntensityNode(
              city: city,
              maxLpgmIntensity: lpgm,
              stations: const [],
            ),
          );
    }
  }

  return _finalizeLpgmTree(grouped, parameter);
}

Map<JmaLpgmIntensity, List<RegionLpgmIntensityNode>> _finalizeLpgmTree(
  Map<JmaLpgmIntensity, Map<String, List<CityLpgmIntensityNode>>> grouped,
  EarthquakeParameter parameter,
) {
  final paramRegionMap = {for (final r in parameter.regions) r.code: r};

  final result = <JmaLpgmIntensity, List<RegionLpgmIntensityNode>>{};

  for (final entry in grouped.entries) {
    final lpgmKey = entry.key;
    final prefectureCities = entry.value;

    final regionNodes = <RegionLpgmIntensityNode>[];
    for (final prefEntry in prefectureCities.entries) {
      final regionItem = paramRegionMap[prefEntry.key];
      if (regionItem == null) {
        continue;
      }

      final cities = prefEntry.value
        ..sort((a, b) {
          final aOrder = a.maxLpgmIntensity?.orderIndex ?? -1;
          final bOrder = b.maxLpgmIntensity?.orderIndex ?? -1;
          if (aOrder != bOrder) {
            return bOrder.compareTo(aOrder);
          }
          return a.city.name.compareTo(b.city.name);
        });

      regionNodes.add(
        RegionLpgmIntensityNode(
          region: regionItem,
          maxLpgmIntensity: lpgmKey,
          cities: cities,
        ),
      );
    }

    regionNodes.sort((a, b) => a.region.name.compareTo(b.region.name));

    result[lpgmKey] = regionNodes;
  }

  return Map.fromEntries(
    result.entries.toList()
      ..sort((a, b) => b.key.orderIndex.compareTo(a.key.orderIndex)),
  );
}
