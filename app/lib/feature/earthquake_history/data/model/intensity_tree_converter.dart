import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_tree.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/lpgm_intensity_tree.dart';
import 'package:eqmonitor_api/export.dart' as api;
import 'package:jma_parameter_types/earthquake_param.pb.dart';

/// APIからの震度データと EarthquakeParameter を使って
/// 子要素(region/city)の震度をキーにしたツリー構造に変換する。
///
/// 同じ都道府県が複数の震度グループに出現しうる。
/// 例: 宮城県に震度5強と震度4の地域がある場合、
///   5+: [宮城県(cities:[宮城県北部(5+)])]
///   4:  [宮城県(cities:[宮城県南部(4)])]
Map<JmaIntensity, List<RegionIntensityNode>> convertToIntensityTree({
  required api.Intensity intensity,
  required EarthquakeParameter parameter,
}) {
  final regionIntensityMap = {
    for (final r in intensity.regions) r.value.code: r,
  };

  // cityの震度でグループ化: JmaIntensity -> prefectureCode -> [CityIntensityNode]
  final grouped =
      <JmaIntensity, Map<String, List<CityIntensityNode>>>{};

  for (final region in parameter.regions) {
    for (final city in region.cities) {
      final cityIntensity = regionIntensityMap[city.code];
      if (cityIntensity == null) {
        continue;
      }
      final jma = cityIntensity.maxIntensity?.toJmaIntensity;
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
              stations: const [],
            ),
          );
    }
  }

  final paramRegionMap = {
    for (final r in parameter.regions) r.code: r,
  };

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
          return bOrder.compareTo(aOrder);
        });

      regionNodes.add(
        RegionIntensityNode(
          region: regionItem,
          maxIntensity: intensityKey,
          cities: cities,
        ),
      );
    }

    regionNodes.sort((a, b) {
      final aName = a.region.name;
      final bName = b.region.name;
      return aName.compareTo(bName);
    });

    result[intensityKey] = regionNodes;
  }

  return Map.fromEntries(
    result.entries.toList()
      ..sort((a, b) => b.key.orderIndex.compareTo(a.key.orderIndex)),
  );
}

/// LPGM版ツリー構造への変換。
/// 子要素のlpgmIntensityでグループ化する。
Map<JmaLpgmIntensity, List<RegionLpgmIntensityNode>>
    convertToLpgmIntensityTree({
  required api.Intensity intensity,
  required EarthquakeParameter parameter,
}) {
  final regionIntensityMap = {
    for (final r in intensity.regions) r.value.code: r,
  };

  final grouped =
      <JmaLpgmIntensity, Map<String, List<CityLpgmIntensityNode>>>{};

  for (final region in parameter.regions) {
    for (final city in region.cities) {
      final cityIntensity = regionIntensityMap[city.code];
      if (cityIntensity == null) {
        continue;
      }
      final lpgm = cityIntensity.maxLpgmIntensity?.toJmaLpgmIntensity;
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

  final paramRegionMap = {
    for (final r in parameter.regions) r.code: r,
  };

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
          return bOrder.compareTo(aOrder);
        });

      regionNodes.add(
        RegionLpgmIntensityNode(
          region: regionItem,
          maxLpgmIntensity: lpgmKey,
          cities: cities,
        ),
      );
    }

    regionNodes.sort((a, b) {
      final aName = a.region.name;
      final bName = b.region.name;
      return aName.compareTo(bName);
    });

    result[lpgmKey] = regionNodes;
  }

  return Map.fromEntries(
    result.entries.toList()
      ..sort((a, b) => b.key.orderIndex.compareTo(a.key.orderIndex)),
  );
}
