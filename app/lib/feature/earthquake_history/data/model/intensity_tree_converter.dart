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
  const IntensityTreeConverter({
    required this.parameter,
  });

  final EarthquakeParameter parameter;

  Map<JmaIntensity, List<PrefectureIntensityNode>> convertToIntensityTree({
    required api.Intensity intensity,
  }) {
    final trees = intensity.intensityTree;
    if (trees.isEmpty) {
      return {};
    }

    final cityPrefixToCityCode = _cityIdentificationPrefixMap();
    final stationParam = _stationParamMap();
    final stationCityCode = _stationCityCodeMap();

    final result = <JmaIntensity, List<PrefectureIntensityNode>>{};

    for (final tree in trees) {
      final jma = tree.intensity.toJmaIntensity;
      final prefecturesByCode = _buildJmaPrefectureCityStations(
        tree: tree,
        cityPrefixToCityCode: cityPrefixToCityCode,
        stationCityCode: stationCityCode,
      );
      if (prefecturesByCode.isEmpty) {
        continue;
      }

      final nodes = _toPrefectureIntensityNodes(
        prefecturesByCode: prefecturesByCode,
        treeIntensity: tree.intensity,
        stationParam: stationParam,
        levelJma: jma,
      );
      final existing = result[jma];
      result[jma] = existing == null
          ? nodes
          : _mergePrefectureIntensityNodeLists(existing, nodes);
    }

    return Map.fromEntries(
      result.entries.toList()
        ..sort((a, b) => b.key.orderIndex.compareTo(a.key.orderIndex)),
    );
  }

  Map<JmaLpgmIntensity, List<PrefectureLpgmIntensityNode>> convertToLpgmIntensityTree({
    required api.Intensity intensity,
  }) {
    final trees = intensity.lpgmIntensityTree;
    if (trees == null || trees.isEmpty) {
      return {};
    }

    final cityPrefixToCityCode = _cityIdentificationPrefixMap();
    final stationParam = _stationParamMap();
    final stationCityCode = _stationCityCodeMap();

    final result = <JmaLpgmIntensity, List<PrefectureLpgmIntensityNode>>{};

    for (final tree in trees) {
      final lpgm = tree.lpgmIntensity.toJmaLpgmIntensity;
      final prefecturesByCode = _buildLpgmPrefectureCityStations(
        tree: tree,
        cityPrefixToCityCode: cityPrefixToCityCode,
        stationCityCode: stationCityCode,
      );
      if (prefecturesByCode.isEmpty) {
        continue;
      }

      final nodes = _toPrefectureLpgmIntensityNodes(
        prefecturesByCode: prefecturesByCode,
        tree: tree,
        stationParam: stationParam,
        levelLpgm: lpgm,
      );
      final existing = result[lpgm];
      result[lpgm] = existing == null
          ? nodes
          : _mergePrefectureLpgmIntensityNodeLists(existing, nodes);
    }

    return Map.fromEntries(
      result.entries.toList()
        ..sort((a, b) => b.key.orderIndex.compareTo(a.key.orderIndex)),
    );
  }

  /// 市区町村コードの先頭5桁 → 市区町村コード（パラメータ由来、ソート済みで後勝ち）
  Map<String, String> _cityIdentificationPrefixMap() {
    final cityCodes = parameter.regions
        .expand((r) => r.cities)
        .map((c) => c.code)
        .toList()
      ..sort();
    return Map.fromEntries(
      cityCodes.map((cityCode) {
        final prefix = cityCode.length >= 5
            ? cityCode.substring(0, 5)
            : cityCode;
        return MapEntry(prefix, cityCode);
      }),
    );
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

  Map<String, EarthquakeParameterCityItem> _cityParamMap() {
    final map = <String, EarthquakeParameterCityItem>{};
    for (final region in parameter.regions) {
      for (final city in region.cities) {
        map[city.code] = city;
      }
    }
    return map;
  }

  Map<String, EarthquakeParameterRegionItem> _regionParamMap() {
    return {for (final r in parameter.regions) r.code: r};
  }

  String _prefectureCodeForCity(String cityCode) {
    for (final region in parameter.regions) {
      for (final city in region.cities) {
        if (city.code == cityCode) {
          return region.code;
        }
      }
    }
    return cityCode.length >= 2 ? cityCode.substring(0, 2) : cityCode;
  }

  /// 震度ツリー1要素分: 都道府県コード → 市区町村コード → 観測点コード集合
  Map<String, Map<String, Set<String>>> _buildJmaPrefectureCityStations({
    required api.IntensityTree tree,
    required Map<String, String> cityPrefixToCityCode,
    required Map<String, String> stationCityCode,
  }) {
    final prefecturesByCode = <String, Map<String, Set<String>>>{};
    final cityParam = _cityParamMap();
    final paramRegionMap = _regionParamMap();

    for (final regionId in tree.regions) {
      if (paramRegionMap.containsKey(regionId)) {
        _ensurePrefecture(prefecturesByCode, regionId);
      }
    }

    for (final regionId in tree.regions) {
      if (regionId.length >= 5) {
        final cityItem = cityParam[regionId];
        if (cityItem != null) {
          _ensureCity(prefecturesByCode, regionId);
        }
      }
    }

    for (final stationCode in tree.stations ?? const <String>[]) {
      final prefix = stationCode.length >= 5
          ? stationCode.substring(0, 5)
          : stationCode;
      final cityCode =
          cityPrefixToCityCode[prefix] ?? stationCityCode[stationCode];
      if (cityCode == null) {
        continue;
      }
      _ensureCity(prefecturesByCode, cityCode).add(stationCode);
    }

    return prefecturesByCode;
  }

  Map<String, Map<String, Set<String>>> _buildLpgmPrefectureCityStations({
    required api.LpgmIntensityTree tree,
    required Map<String, String> cityPrefixToCityCode,
    required Map<String, String> stationCityCode,
  }) {
    final prefecturesByCode = <String, Map<String, Set<String>>>{};
    final cityParam = _cityParamMap();
    final paramRegionMap = _regionParamMap();

    for (final regionId in tree.regions) {
      if (paramRegionMap.containsKey(regionId)) {
        _ensurePrefecture(prefecturesByCode, regionId);
      }
    }

    for (final regionId in tree.regions) {
      if (regionId.length >= 5) {
        final cityItem = cityParam[regionId];
        if (cityItem != null) {
          _ensureCity(prefecturesByCode, regionId);
        }
      }
    }

    for (final station in tree.stations) {
      final prefix = station.code.length >= 5
          ? station.code.substring(0, 5)
          : station.code;
      final cityCode =
          cityPrefixToCityCode[prefix] ?? stationCityCode[station.code];
      if (cityCode == null) {
        continue;
      }
      _ensureCity(prefecturesByCode, cityCode).add(station.code);
    }

    return prefecturesByCode;
  }

  Map<String, Set<String>> _ensurePrefecture(
    Map<String, Map<String, Set<String>>> prefecturesByCode,
    String prefectureCode,
  ) {
    final current = prefecturesByCode[prefectureCode];
    if (current != null) {
      return current;
    }
    final citiesByCode = <String, Set<String>>{};
    prefecturesByCode[prefectureCode] = citiesByCode;
    return citiesByCode;
  }

  Set<String> _ensureCity(
    Map<String, Map<String, Set<String>>> prefecturesByCode,
    String cityCode,
  ) {
    final prefCode = _prefectureCodeForCity(cityCode);
    final citiesByCode = _ensurePrefecture(prefecturesByCode, prefCode);
    final current = citiesByCode[cityCode];
    if (current != null) {
      return current;
    }
    final stationCodes = <String>{};
    citiesByCode[cityCode] = stationCodes;
    return stationCodes;
  }

  List<PrefectureIntensityNode> _toPrefectureIntensityNodes({
    required Map<String, Map<String, Set<String>>> prefecturesByCode,
    required api.JmaIntensity treeIntensity,
    required Map<String, EarthquakeParameterStationItem> stationParam,
    required JmaIntensity levelJma,
  }) {
    final paramRegionMap = _regionParamMap();
    final cityParam = _cityParamMap();
    final regionNodes = <PrefectureIntensityNode>[];

    for (final prefEntry in prefecturesByCode.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key))) {
      final prefCode = prefEntry.key;
      final citiesByCode = prefEntry.value;
      final regionItem = paramRegionMap[prefCode];
      if (regionItem == null) {
        continue;
      }

      final cities = <CityIntensityNode>[];
      for (final cityEntry in citiesByCode.entries.toList()
        ..sort((a, b) => a.key.compareTo(b.key))) {
        final cityCode = cityEntry.key;
        final stationCodes = cityEntry.value.toList()..sort();
        final cityItem = cityParam[cityCode];
        if (cityItem == null) {
          continue;
        }

        final stationNodes = <StationIntensityNode>[];
        for (final code in stationCodes) {
          final paramSt = stationParam[code];
          if (paramSt == null) {
            continue;
          }
          stationNodes.add(
            StationIntensityNode(
              station: paramSt,
              intensity: IntensityStation(
                code: code,
                name: paramSt.name,
                sva: null,
                prePeriods: const [],
                maxIntensity: treeIntensity.toJmaIntensity,
                maxLpgmIntensity: null,
              ),
            ),
          );
        }

        cities.add(
          CityIntensityNode(
            city: cityItem,
            maxIntensity: levelJma,
            stations: stationNodes,
          ),
        );
      }

      regionNodes.add(
        PrefectureIntensityNode(
          region: IntensityRegion(
            region: regionItem,
            maxIntensity: levelJma,
          ),
          cities: cities,
        ),
      );
    }

    regionNodes.sort(
      (a, b) => a.region.region.name.compareTo(b.region.region.name),
    );
    return regionNodes;
  }

  List<PrefectureLpgmIntensityNode> _toPrefectureLpgmIntensityNodes({
    required Map<String, Map<String, Set<String>>> prefecturesByCode,
    required api.LpgmIntensityTree tree,
    required Map<String, EarthquakeParameterStationItem> stationParam,
    required JmaLpgmIntensity levelLpgm,
  }) {
    final paramRegionMap = _regionParamMap();
    final cityParam = _cityParamMap();
    final apiStationByCode = {
      for (final s in tree.stations) s.code: s,
    };

    final regionNodes = <PrefectureLpgmIntensityNode>[];

    for (final prefEntry in prefecturesByCode.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key))) {
      final prefCode = prefEntry.key;
      final citiesByCode = prefEntry.value;
      final regionItem = paramRegionMap[prefCode];
      if (regionItem == null) {
        continue;
      }

      final cities = <CityLpgmIntensityNode>[];
      for (final cityEntry in citiesByCode.entries.toList()
        ..sort((a, b) => a.key.compareTo(b.key))) {
        final cityCode = cityEntry.key;
        final stationCodes = cityEntry.value.toList()..sort();
        final cityItem = cityParam[cityCode];
        if (cityItem == null) {
          continue;
        }

        final stationNodes = <StationLpgmIntensityNode>[];
        for (final code in stationCodes) {
          final parameterStation = stationParam[code];
          if (parameterStation == null) {
            continue;
          }
          final apiStation = apiStationByCode[code];
          if (apiStation == null) {
            continue;
          }
          stationNodes.add(
            StationLpgmIntensityNode(
              station: parameterStation,
              intensity: IntensityStation(
                code: apiStation.code,
                name: parameterStation.name,
                sva: apiStation.sva?.toDouble(),
                prePeriods: apiStation.prePeriods
                        ?.map((e) => e.toPrePeriod)
                        .toList() ??
                    const [],
                maxIntensity: null,
                maxLpgmIntensity: tree.lpgmIntensity.toJmaLpgmIntensity,
              ),
            ),
          );
        }

        cities.add(
          CityLpgmIntensityNode(
            city: cityItem,
            maxLpgmIntensity: levelLpgm,
            stations: stationNodes,
          ),
        );
      }

      regionNodes.add(
        PrefectureLpgmIntensityNode(
          region: regionItem,
          maxLpgmIntensity: levelLpgm,
          cities: cities,
        ),
      );
    }

    regionNodes.sort((a, b) => a.region.name.compareTo(b.region.name));
    return regionNodes;
  }

  List<PrefectureIntensityNode> _mergePrefectureIntensityNodeLists(
    List<PrefectureIntensityNode> a,
    List<PrefectureIntensityNode> b,
  ) {
    final byPref = <String, PrefectureIntensityNode>{};
    for (final n in a) {
      byPref[n.region.region.code] = n;
    }
    for (final n in b) {
      final code = n.region.region.code;
      final existing = byPref[code];
      byPref[code] = existing == null
          ? n
          : _mergeSinglePrefectureIntensity(existing, n);
    }
    final merged = byPref.values.toList()
      ..sort((x, y) => x.region.region.name.compareTo(y.region.region.name));
    return merged;
  }

  PrefectureIntensityNode _mergeSinglePrefectureIntensity(
    PrefectureIntensityNode a,
    PrefectureIntensityNode b,
  ) {
    final byCity = <String, CityIntensityNode>{};
    for (final c in a.cities) {
      byCity[c.city.code] = c;
    }
    for (final c in b.cities) {
      final existing = byCity[c.city.code];
      byCity[c.city.code] = existing == null
          ? c
          : CityIntensityNode(
              city: existing.city,
              maxIntensity: existing.maxIntensity ?? c.maxIntensity,
              maxLpgmIntensity: existing.maxLpgmIntensity ?? c.maxLpgmIntensity,
              stations: _mergeStationIntensityNodes(existing.stations, c.stations),
            );
    }
    final cities = byCity.values.toList()
      ..sort((x, y) => x.city.name.compareTo(y.city.name));
    return PrefectureIntensityNode(
      region: IntensityRegion(
        region: a.region.region,
        maxIntensity: a.region.maxIntensity ?? b.region.maxIntensity,
      ),
      cities: cities,
    );
  }

  List<StationIntensityNode> _mergeStationIntensityNodes(
    List<StationIntensityNode> a,
    List<StationIntensityNode> b,
  ) {
    final byCode = <String, StationIntensityNode>{};
    for (final n in a) {
      byCode[n.station.code] = n;
    }
    for (final n in b) {
      byCode[n.station.code] = n;
    }
    final merged = byCode.values.toList()
      ..sort((x, y) => x.station.name.compareTo(y.station.name));
    return merged;
  }

  List<PrefectureLpgmIntensityNode> _mergePrefectureLpgmIntensityNodeLists(
    List<PrefectureLpgmIntensityNode> a,
    List<PrefectureLpgmIntensityNode> b,
  ) {
    final byPref = <String, PrefectureLpgmIntensityNode>{};
    for (final n in a) {
      byPref[n.region.code] = n;
    }
    for (final n in b) {
      final code = n.region.code;
      final existing = byPref[code];
      byPref[code] = existing == null
          ? n
          : _mergeSinglePrefectureLpgm(existing, n);
    }
    final merged = byPref.values.toList()
      ..sort((x, y) => x.region.name.compareTo(y.region.name));
    return merged;
  }

  PrefectureLpgmIntensityNode _mergeSinglePrefectureLpgm(
    PrefectureLpgmIntensityNode a,
    PrefectureLpgmIntensityNode b,
  ) {
    final byCity = <String, CityLpgmIntensityNode>{};
    for (final c in a.cities) {
      byCity[c.city.code] = c;
    }
    for (final c in b.cities) {
      final existing = byCity[c.city.code];
      byCity[c.city.code] = existing == null
          ? c
          : CityLpgmIntensityNode(
              city: existing.city,
              maxLpgmIntensity:
                  existing.maxLpgmIntensity ?? c.maxLpgmIntensity,
              stations: _mergeStationLpgmNodes(existing.stations, c.stations),
            );
    }
    final cities = byCity.values.toList()
      ..sort((x, y) => x.city.name.compareTo(y.city.name));
    return PrefectureLpgmIntensityNode(
      region: a.region,
      maxLpgmIntensity: a.maxLpgmIntensity ?? b.maxLpgmIntensity,
      cities: cities,
    );
  }

  List<StationLpgmIntensityNode> _mergeStationLpgmNodes(
    List<StationLpgmIntensityNode> a,
    List<StationLpgmIntensityNode> b,
  ) {
    final byCode = <String, StationLpgmIntensityNode>{};
    for (final n in a) {
      byCode[n.station.code] = n;
    }
    for (final n in b) {
      byCode[n.station.code] = n;
    }
    final merged = byCode.values.toList()
      ..sort((x, y) => x.station.name.compareTo(y.station.name));
    return merged;
  }
}

@Riverpod(keepAlive: true)
Future<IntensityTreeConverter> intensityTreeConverter(Ref ref) async {
  final jmaParam = await ref.watch(jmaParameterProvider.future);
  return IntensityTreeConverter(parameter: jmaParam.earthquake);
}
