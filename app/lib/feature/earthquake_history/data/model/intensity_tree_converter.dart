import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/core/provider/jma_parameter/jma_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_station.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_tree.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/lpgm_intensity_tree.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'intensity_tree_converter.g.dart';

@Riverpod(keepAlive: true)
Future<IntensityTreeConverter> intensityTreeConverter(Ref ref) async {
  final jmaParam = await ref.watch(
    jmaParameterProvider.future,
  );
  return IntensityTreeConverter(
    parameter: jmaParam.earthquake,
  );
}

class IntensityTreeConverter {
  const IntensityTreeConverter({required this.parameter});

  final EarthquakeParameter parameter;

  Iterable<EarthquakeParameterPrefectureItem> get _allPrefectures =>
      parameter.prefectures;

  Iterable<EarthquakeParameterRegionItem> get _allRegions =>
      parameter.prefectures.expand((p) => p.regions);

  Map<String, EarthquakeParameterStationItem> _stationParamMap() => {
    for (final region in _allRegions)
      for (final city in region.cities)
        for (final station in city.stations) station.code: station,
  };

  Map<String, String> _stationCityCodeMap() => {
    for (final region in _allRegions)
      for (final city in region.cities)
        for (final station in city.stations) station.code: city.code,
  };

  Map<String, EarthquakeParameterPrefectureItem> _cityPrefectureMap() => {
    for (final prefecture in _allPrefectures)
      for (final region in prefecture.regions)
        for (final city in region.cities) city.code: prefecture,
  };

  /// 市区町村コードの先頭 N 文字でキー付けしたコード → city マップ。
  Map<String, EarthquakeParameterCityItem> _cityIdentificationPrefixMap() {
    const prefixLength = 5;
    final result = <String, EarthquakeParameterCityItem>{};
    for (final region in _allRegions) {
      for (final city in region.cities) {
        final key = city.code.length >= prefixLength
            ? city.code.substring(0, prefixLength)
            : city.code;
        result.putIfAbsent(key, () => city);
      }
    }
    return result;
  }

  Map<JmaIntensity, List<PrefectureIntensityNode>> convertToIntensityTree({
    required api.Intensity intensity,
  }) {
    final stationParam = _stationParamMap();
    final stationCityCode = _stationCityCodeMap();
    final cityPrefecture = _cityPrefectureMap();

    final stationIntensityMap = <String, IntensityStation>{};
    for (final entry in intensity.intensityTree) {
      final ji = entry.intensity.toJmaIntensity;
      for (final stationCode in entry.stations ?? <String>[]) {
        stationIntensityMap[stationCode] = IntensityStation(
          code: stationCode,
          name: stationCode,
          sva: null,
          prePeriods: null,
          maxIntensity: ji,
          maxLpgmIntensity: null,
        );
      }
    }

    final cityCodeToCity = <String, EarthquakeParameterCityItem>{};
    for (final region in _allRegions) {
      for (final city in region.cities) {
        cityCodeToCity[city.code] = city;
      }
    }

    final resultMap = <JmaIntensity, Map<String, _MutablePrefectureNode>>{};

    for (final stationCode in stationIntensityMap.keys) {
      final stationItem = stationParam[stationCode];
      if (stationItem == null) {
        continue;
      }
      final cityCode = stationCityCode[stationCode];
      if (cityCode == null) {
        continue;
      }

      final intensityEntry = stationIntensityMap[stationCode]!;
      final ji = intensityEntry.maxIntensity!;

      final foundCity = cityCodeToCity[cityCode];
      final foundPrefecture = cityPrefecture[cityCode];
      if (foundCity == null || foundPrefecture == null) {
        continue;
      }

      final prefectureNodes = resultMap.putIfAbsent(ji, () => {});
      final prefNode = prefectureNodes.putIfAbsent(
        foundPrefecture.code,
        () => _MutablePrefectureNode(prefecture: foundPrefecture),
      );
      prefNode.addStation(foundCity, stationItem, intensityEntry);
    }

    final built = <JmaIntensity, List<PrefectureIntensityNode>>{
      for (final entry in resultMap.entries)
        entry.key: [
          for (final prefNode in entry.value.values) prefNode.build(entry.key),
        ],
    };
    return Map.fromEntries(
      built.entries.toList()
        ..sort((a, b) => b.key.orderIndex.compareTo(a.key.orderIndex)),
    );
  }

  Map<JmaIntensity, List<IntensityRegion>> convertToRegionIntensityTree({
    required api.Intensity intensity,
  }) {
    final regionCodeToRegion = <String, EarthquakeParameterRegionItem>{
      for (final region in _allRegions) region.code: region,
    };
    final result = <JmaIntensity, List<IntensityRegion>>{};
    for (final entry in intensity.intensityTree) {
      final ji = entry.intensity.toJmaIntensity;
      for (final code in entry.regions) {
        final region = regionCodeToRegion[code];
        if (region == null) {
          continue;
        }
        result
            .putIfAbsent(ji, () => [])
            .add(
              IntensityRegion(region: region, maxIntensity: ji),
            );
      }
    }

    return Map.fromEntries(
      result.entries.toList()
        ..sort((a, b) => b.key.orderIndex.compareTo(a.key.orderIndex)),
    );
  }

  Map<JmaLpgmIntensity, List<PrefectureLpgmIntensityNode>>
  convertToLpgmIntensityTree({required api.Intensity intensity}) {
    final trees = intensity.lpgmIntensityTree;
    if (trees == null || trees.isEmpty) {
      return {};
    }

    final stationParam = _stationParamMap();
    final stationCityCode = _stationCityCodeMap();
    final cityPrefixToCityCode = _cityIdentificationPrefixMap();

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

  Map<String, _LpgmPrefectureData> _buildLpgmPrefectureCityStations({
    required api.LpgmIntensityTree tree,
    required Map<String, EarthquakeParameterCityItem> cityPrefixToCityCode,
    required Map<String, String> stationCityCode,
  }) {
    final result = <String, _LpgmPrefectureData>{};

    // Build lookup maps for city/region code resolution
    final cityCodeToCity = <String, EarthquakeParameterCityItem>{};
    final cityCodeToRegion = <String, EarthquakeParameterRegionItem>{};
    for (final region in _allRegions) {
      for (final city in region.cities) {
        cityCodeToCity[city.code] = city;
        cityCodeToRegion[city.code] = region;
      }
    }

    // Process city-level region codes
    for (final code in tree.regions) {
      final city = cityCodeToCity[code];
      final region = cityCodeToRegion[code];
      if (city == null || region == null) {
        continue;
      }
      result
          .putIfAbsent(region.code, () => _LpgmPrefectureData(region: region))
          .addCity(city);
    }

    // Process station-level data
    for (final stationItem in tree.stations) {
      final stationCode = stationItem.code;
      final cityCode = stationCityCode[stationCode];
      if (cityCode == null) {
        continue;
      }

      EarthquakeParameterRegionItem? foundRegion;
      EarthquakeParameterCityItem? foundCity;
      outer:
      for (final region in _allRegions) {
        for (final city in region.cities) {
          if (city.code == cityCode) {
            foundRegion = region;
            foundCity = city;
            break outer;
          }
        }
      }
      if (foundRegion == null || foundCity == null) {
        continue;
      }

      final prefData = result.putIfAbsent(
        foundRegion.code,
        () => _LpgmPrefectureData(region: foundRegion!),
      );
      prefData.addStation(foundCity, stationItem);
    }

    return result;
  }

  List<PrefectureLpgmIntensityNode> _toPrefectureLpgmIntensityNodes({
    required Map<String, _LpgmPrefectureData> prefecturesByCode,
    required Map<String, EarthquakeParameterStationItem> stationParam,
    required JmaLpgmIntensity levelLpgm,
  }) {
    final nodes = <PrefectureLpgmIntensityNode>[];
    for (final prefData in prefecturesByCode.values) {
      final cities = <CityLpgmIntensityNode>[];
      for (final entry in prefData.cityStations.entries) {
        final city = entry.key;
        final stationItems = entry.value;
        final stationNodes = stationItems
            .map((stationItem) {
              final stItem = stationParam[stationItem.code];
              if (stItem == null) {
                return null;
              }
              return StationLpgmIntensityNode(
                station: stItem,
                intensity: stationItem.toIntensityStation.copyWith(
                  maxIntensity: null,
                  maxLpgmIntensity: levelLpgm,
                ),
              );
            })
            .nonNulls
            .toList();

        cities.add(
          CityLpgmIntensityNode(
            city: city,
            maxLpgmIntensity: levelLpgm,
            stations: stationNodes,
          ),
        );
      }

      nodes.add(
        PrefectureLpgmIntensityNode(
          region: prefData.region,
          maxLpgmIntensity: levelLpgm,
          cities: cities,
        ),
      );
    }
    return nodes;
  }

  List<PrefectureLpgmIntensityNode> _mergePrefectureLpgmIntensityNodeLists(
    List<PrefectureLpgmIntensityNode> a,
    List<PrefectureLpgmIntensityNode> b,
  ) {
    final merged = <String, PrefectureLpgmIntensityNode>{};
    for (final node in [...a, ...b]) {
      final key = node.region.code;
      final existing = merged[key];
      if (existing == null) {
        merged[key] = node;
      } else {
        merged[key] = PrefectureLpgmIntensityNode(
          region: existing.region,
          maxLpgmIntensity: existing.maxLpgmIntensity,
          cities: [...existing.cities, ...node.cities],
        );
      }
    }
    return merged.values.toList();
  }
}

// ---------------------------------------------------------------------------
// Private helpers
// ---------------------------------------------------------------------------

class _MutablePrefectureNode {
  _MutablePrefectureNode({required this.prefecture});

  final EarthquakeParameterPrefectureItem prefecture;
  final Map<String, _MutableCityNode> _cities = {};

  void addStation(
    EarthquakeParameterCityItem city,
    EarthquakeParameterStationItem station,
    IntensityStation intensityStation,
  ) {
    _cities
        .putIfAbsent(city.code, () => _MutableCityNode(city: city))
        .addStation(station, intensityStation);
  }

  PrefectureIntensityNode build(JmaIntensity prefectureIntensity) {
    final cities = _cities.values.map((c) => c.build()).toList();
    final maxIntensity = cities
        .map((c) => c.maxIntensity)
        .whereType<JmaIntensity>()
        .fold<JmaIntensity?>(
          null,
          (prev, i) =>
              prev == null || i.orderIndex > prev.orderIndex ? i : prev,
        );

    return PrefectureIntensityNode(
      prefecture: IntensityPrefecture(
        prefecture: prefecture,
        maxIntensity: maxIntensity ?? prefectureIntensity,
      ),
      cities: cities,
    );
  }
}

class _MutableCityNode {
  _MutableCityNode({required this.city});

  final EarthquakeParameterCityItem city;
  final List<StationIntensityNode> stations = [];

  void addStation(
    EarthquakeParameterStationItem station,
    IntensityStation intensityStation,
  ) {
    stations.add(
      StationIntensityNode(station: station, intensity: intensityStation),
    );
  }

  CityIntensityNode build() {
    final stationMaxIntensity = stations
        .map((s) => s.intensity?.maxIntensity)
        .whereType<JmaIntensity>()
        .fold<JmaIntensity?>(
          null,
          (prev, i) =>
              prev == null || i.orderIndex > prev.orderIndex ? i : prev,
        );
    return CityIntensityNode(
      city: city,
      maxIntensity: stationMaxIntensity,
      stations: stations,
    );
  }
}

class _LpgmPrefectureData {
  _LpgmPrefectureData({required this.region});

  final EarthquakeParameterRegionItem region;
  final Map<EarthquakeParameterCityItem, List<api.IntensityStationItem>>
  cityStations = {};

  void addCity(EarthquakeParameterCityItem city) {
    cityStations.putIfAbsent(city, () => []);
  }

  void addStation(
    EarthquakeParameterCityItem city,
    api.IntensityStationItem stationItem,
  ) {
    cityStations.putIfAbsent(city, () => []).add(stationItem);
  }
}
