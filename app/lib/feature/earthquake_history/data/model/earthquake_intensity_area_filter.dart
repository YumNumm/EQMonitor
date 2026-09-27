import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/shindo_db_intensity_tree.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

final earthquakeIntensityAreaFilterProvider = Provider(
  (ref) => const EarthquakeIntensityAreaFilter(),
);

/// 地図と同じ地域コードで各地の震度を絞り込む。
class EarthquakeIntensityAreaFilter {
  const new();

  Earthquake filterEarthquake({
    required Earthquake earthquake,
    required String code,
    required bool isCity,
  }) {
    final intensity = earthquake.intensity;
    if (intensity == null) return earthquake;
    final tree = intensity.intensityTree.map((level, prefectures) {
      final filtered = prefectures
          .map((pref) {
            final cityCodes = pref.prefecture.prefecture.regions
                .where((region) => region.code == code)
                .expand((region) => region.cities)
                .map((city) => city.code)
                .toSet();
            return pref.copyWith(
              cities: pref.cities
                  .where(
                    (city) => isCity
                        ? city.city.code == code
                        : pref.prefecture.prefecture.code == code ||
                              cityCodes.contains(city.city.code),
                  )
                  .toList(),
            );
          })
          .where((pref) => pref.cities.isNotEmpty)
          .toList();
      return MapEntry(level, filtered);
    })..removeWhere((_, prefectures) => prefectures.isEmpty);
    final regions = intensity.regions.map(
      (level, regions) => MapEntry(
        level,
        regions
            .where(
              (region) =>
                  !isCity &&
                  (region.region.code == code ||
                      intensity.intensityTree.values
                          .expand((prefs) => prefs)
                          .any(
                            (pref) =>
                                pref.prefecture.prefecture.code == code &&
                                pref.prefecture.prefecture.regions.contains(
                                  region.region,
                                ),
                          )),
            )
            .toList(),
      ),
    )..removeWhere((_, regions) => regions.isEmpty);
    return earthquake.copyWith(
      intensity: intensity.copyWith(
        intensityTree: tree,
        regions: regions,
      ),
    );
  }

  ShindoDbIntensityTree filterDatabase({
    required ShindoDbIntensityTree tree,
    required String code,
    required bool isCity,
  }) {
    final filtered = tree.tree.map(
      (level, prefectures) => MapEntry(
        level,
        prefectures
            .map(
              (pref) => pref.copyWith(
                cities: pref.cities
                    .where(
                      (city) => isCity
                          ? city.city.code == code
                          : pref.prefecture.code == code ||
                                city.region.code == code,
                    )
                    .toList(),
              ),
            )
            .where((pref) => pref.cities.isNotEmpty)
            .toList(),
      ),
    )..removeWhere((_, prefectures) => prefectures.isEmpty);
    return tree.copyWith(
      tree: filtered,
      unresolvedStations: {},
      totalStationCount: filtered.values
          .expand((prefs) => prefs)
          .expand((pref) => pref.cities)
          .fold(0, (count, city) => count + city.stations.length),
    );
  }
}
