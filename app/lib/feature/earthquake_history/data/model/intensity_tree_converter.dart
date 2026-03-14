import 'package:collection/collection.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_tree.dart';
import 'package:eqmonitor_api/export.dart' as api;
import 'package:jma_parameter_types/earthquake_param.pb.dart';

/// APIからの震度データと EarthquateParameter を使ってツリー構造に変換する
Map<JmaIntensity, List<RegionIntensityNode>> convertToIntensityTree({
  required api.Intensity intensity,
  required EarthquakeParameter parameter,
}) {
  final prefectureIntensityMap = {
    for (final p in intensity.prefectures) p.value.code: p,
  };
  final regionIntensityMap = {
    for (final r in intensity.regions) r.value.code: r,
  };

  final regionNodes = <RegionIntensityNode>[];

  for (final region in parameter.regions) {
    final prefectureIntensity = prefectureIntensityMap[region.code];
    if (prefectureIntensity == null) {
      continue;
    }

    final cityNodes = <CityIntensityNode>[];

    for (final city in region.cities) {
      final regionIntensity = regionIntensityMap[city.code];
      if (regionIntensity == null) {
        continue;
      }

      const stationNodes = <StationIntensityNode>[];

      cityNodes.add(
        CityIntensityNode(
          city: city,
          maxIntensity: regionIntensity.maxIntensity?.toJmaIntensity,
          stations: stationNodes,
        ),
      );
    }

    cityNodes.sort((a, b) {
      final aOrder = a.maxIntensity?.orderIndex ?? -1;
      final bOrder = b.maxIntensity?.orderIndex ?? -1;
      return bOrder.compareTo(aOrder);
    });

    regionNodes.add(
      RegionIntensityNode(
        region: region,
        maxIntensity: prefectureIntensity.maxIntensity?.toJmaIntensity,
        cities: cityNodes,
      ),
    );
  }

  regionNodes.sort((a, b) {
    final aOrder = a.maxIntensity?.orderIndex ?? -1;
    final bOrder = b.maxIntensity?.orderIndex ?? -1;
    return bOrder.compareTo(aOrder);
  });

  final groupedByIntensity = regionNodes
      .where((r) => r.maxIntensity != null)
      .groupListsBy((r) => r.maxIntensity!);

  final sortedMap = Map.fromEntries(
    groupedByIntensity.entries.toList()
      ..sort((a, b) => (b.key.orderIndex).compareTo(a.key.orderIndex)),
  );

  return sortedMap;
}
