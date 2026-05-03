import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/core/provider/jma_parameter/jma_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_station.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_tree.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/lpgm_intensity_tree.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'intensity_tree_converter.g.dart';

class IntensityTreeConverter {
  const IntensityTreeConverter({required this.parameter});

  final EarthquakeParameter parameter;

  Map<JmaIntensity, List<PrefectureIntensityNode>> convertToIntensityTree({
    required api.Intensity intensity,
  }) {
    final citiesList = intensity.cities ?? [];
    final stationsList = intensity.stations ?? [];
    if (citiesList.isNotEmpty) {
      return _fromCities(citiesList, stationsList);
    }
    if (intensity.regions.isNotEmpty) {
      return _fromRegions(intensity.regions);
    }
    if (intensity.prefectures.isNotEmpty) {
      return _fromPrefecturesOnly(intensity.prefectures);
    }
    return {};
  }

  Map<JmaLpgmIntensity, List<PrefectureLpgmIntensityNode>>
  convertToLpgmIntensityTree({
    required api.Intensity intensity,
  }) {
    final cities = intensity.cities ?? [];
    final stations = intensity.stations ?? [];
    if (cities.isNotEmpty) {
      return _lpgmFromCities(cities, stations);
    }
    if (intensity.regions.isNotEmpty) {
      return _lpgmFromRegions(intensity.regions);
    }
    if (intensity.prefectures.isNotEmpty) {
      return _lpgmFromPrefecturesOnly(intensity.prefectures);
    }
    return {};
  }

  Map<String, EarthquakeParameterCityItem> _cityParamMap() {
    final map = <String, EarthquakeParameterCityItem>{};
    for (final region in parameter.regions) {
      for (final city in region.cities) {
        map[city.code] = city;
      }
    }
    return map;
  }

  Map<String, EarthquakeParameterStationItem> _stationParamMap() {
    final map = <String, EarthquakeParameterStationItem>{};
    for (final region in parameter.regions) {
      for (final city in region.cities) {
        for (final station in city.stations) {
          map[station.code] = station;
        }
      }
    }
    return map;
  }

  Map<String, String> _stationCityCodeMap() {
    final map = <String, String>{};
    for (final region in parameter.regions) {
      for (final city in region.cities) {
        for (final station in city.stations) {
          map[station.code] = city.code;
        }
      }
    }
    return map;
  }

  String? _prefectureCode(EarthquakeParameterCityItem city) {
    for (final region in parameter.regions) {
      for (final parameterCity in region.cities) {
        if (parameterCity.code == city.code) {
          return region.code;
        }
      }
    }
    return null;
  }

  Map<JmaIntensity, List<PrefectureIntensityNode>> _fromCities(
    List<api.IntensityItem> apiCities,
    List<api.IntensityStationItem> apiStations,
  ) {
    final cityParam = _cityParamMap();
    final stationParam = _stationParamMap();
    final byCityCode = _stationsByCityCode(
      stations: apiStations,
      stationCityCode: _stationCityCodeMap(),
    );
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

      final prefCode = _prefectureCode(cityItem);
      if (prefCode == null) {
        continue;
      }

      final stationNodes = <StationIntensityNode>[];
      for (final st in byCityCode[code] ?? const <api.IntensityStationItem>[]) {
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

      grouped
          .putIfAbsent(jma, () => {})
          .putIfAbsent(prefCode, () => [])
          .add(
            CityIntensityNode(
              city: cityItem,
              maxIntensity: jma,
              maxLpgmIntensity: apiCity.maxLpgmIntensity?.toJmaLpgmIntensity,
              stations: stationNodes,
            ),
          );
    }

    return _finalize(grouped);
  }

  Map<JmaIntensity, List<PrefectureIntensityNode>> _fromRegions(
    List<api.IntensityItem> regions,
  ) {
    final regionIntensityMap = {for (final r in regions) r.value.code: r};
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

    return _finalize(grouped);
  }

  Map<JmaIntensity, List<PrefectureIntensityNode>> _fromPrefecturesOnly(
    List<api.IntensityItem> prefectures,
  ) {
    final paramRegionMap = {for (final r in parameter.regions) r.code: r};
    final grouped = <JmaIntensity, List<PrefectureIntensityNode>>{};

    for (final pref in prefectures) {
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
            PrefectureIntensityNode(
              region: IntensityRegion(region: regionItem, maxIntensity: jma),
              cities: const [],
            ),
          );
    }

    for (final entry in grouped.entries) {
      entry.value.sort(
        (a, b) => a.region.region.name.compareTo(b.region.region.name),
      );
    }

    return Map.fromEntries(
      grouped.entries.toList()
        ..sort((a, b) => b.key.orderIndex.compareTo(a.key.orderIndex)),
    );
  }

  Map<JmaIntensity, List<PrefectureIntensityNode>> _finalize(
    Map<JmaIntensity, Map<String, List<CityIntensityNode>>> grouped,
  ) {
    final paramRegionMap = {for (final r in parameter.regions) r.code: r};
    final result = <JmaIntensity, List<PrefectureIntensityNode>>{};

    for (final entry in grouped.entries) {
      final intensityKey = entry.key;
      final regionNodes = <PrefectureIntensityNode>[];

      for (final prefEntry in entry.value.entries) {
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
          PrefectureIntensityNode(
            region: IntensityRegion(
              region: regionItem,
              maxIntensity: intensityKey,
            ),
            cities: cities,
          ),
        );
      }

      regionNodes.sort(
        (a, b) => a.region.region.name.compareTo(b.region.region.name),
      );
      result[intensityKey] = regionNodes;
    }

    return Map.fromEntries(
      result.entries.toList()
        ..sort((a, b) => b.key.orderIndex.compareTo(a.key.orderIndex)),
    );
  }

  Map<JmaLpgmIntensity, List<PrefectureLpgmIntensityNode>> _lpgmFromCities(
    List<api.IntensityItem> apiCities,
    List<api.IntensityStationItem> apiStations,
  ) {
    final cityParam = _cityParamMap();
    final stationParam = _stationParamMap();
    final byCityCode = _stationsByCityCode(
      stations: apiStations,
      stationCityCode: _stationCityCodeMap(),
    );
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

      final prefCode = _prefectureCode(cityItem);
      if (prefCode == null) {
        continue;
      }

      final stationNodes = <StationLpgmIntensityNode>[];
      for (final station
          in byCityCode[apiCity.value.code] ??
              const <api.IntensityStationItem>[]) {
        final parameterStation = stationParam[station.value.code];
        if (parameterStation == null) {
          continue;
        }
        stationNodes.add(
          StationLpgmIntensityNode(
            station: parameterStation,
            intensity: station.toIntensityStation,
          ),
        );
      }
      stationNodes.sort((a, b) => a.station.name.compareTo(b.station.name));

      grouped
          .putIfAbsent(lpgm, () => {})
          .putIfAbsent(prefCode, () => [])
          .add(
            CityLpgmIntensityNode(
              city: cityItem,
              maxLpgmIntensity: lpgm,
              stations: stationNodes,
            ),
          );
    }

    return _finalizeLpgm(grouped);
  }

  Map<JmaLpgmIntensity, List<PrefectureLpgmIntensityNode>> _lpgmFromRegions(
    List<api.IntensityItem> regions,
  ) {
    final regionIntensityMap = {for (final r in regions) r.value.code: r};
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

    return _finalizeLpgm(grouped);
  }

  Map<JmaLpgmIntensity, List<PrefectureLpgmIntensityNode>>
  _lpgmFromPrefecturesOnly(List<api.IntensityItem> prefectures) {
    final paramRegionMap = {for (final r in parameter.regions) r.code: r};
    final grouped = <JmaLpgmIntensity, List<PrefectureLpgmIntensityNode>>{};

    for (final pref in prefectures) {
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
            PrefectureLpgmIntensityNode(
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

  Map<JmaLpgmIntensity, List<PrefectureLpgmIntensityNode>> _finalizeLpgm(
    Map<JmaLpgmIntensity, Map<String, List<CityLpgmIntensityNode>>> grouped,
  ) {
    final paramRegionMap = {for (final r in parameter.regions) r.code: r};
    final result = <JmaLpgmIntensity, List<PrefectureLpgmIntensityNode>>{};

    for (final entry in grouped.entries) {
      final lpgmKey = entry.key;
      final regionNodes = <PrefectureLpgmIntensityNode>[];

      for (final prefEntry in entry.value.entries) {
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
          PrefectureLpgmIntensityNode(
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
}

Map<String, List<api.IntensityStationItem>> _stationsByCityCode({
  required List<api.IntensityStationItem> stations,
  required Map<String, String> stationCityCode,
}) {
  final map = <String, List<api.IntensityStationItem>>{};
  for (final s in stations) {
    final cityCode = stationCityCode[s.value.code];
    if (cityCode == null) {
      continue;
    }
    map.putIfAbsent(cityCode, () => []).add(s);
  }
  return map;
}

@Riverpod(keepAlive: true)
Future<IntensityTreeConverter> intensityTreeConverter(Ref ref) async {
  final jmaParam = await ref.watch(jmaParameterProvider.future);
  return IntensityTreeConverter(parameter: jmaParam.earthquake);
}
