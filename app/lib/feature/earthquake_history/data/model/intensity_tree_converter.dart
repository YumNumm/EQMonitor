import 'package:collection/collection.dart';
import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_tree.dart';
import 'package:jma_parameter_types/earthquake_param.pb.dart';

/// APIからの震度データとEarthquakeParameterを使ってツリー構造に変換する
IntensityTree convertToIntensityTree({
  required Intensity intensity,
  required EarthquakeParameter parameter,
}) {
  // APIデータをコード→情報のMapに変換（O(1)検索用）
  final prefectureIntensityMap = {
    for (final p in intensity.prefectures) p.value.code: p,
  };
  final cityIntensityMap = {
    for (final c in intensity.cities ?? <IntensityItem>[]) c.value.code: c,
  };
  final stationIntensityMap = {
    for (final s in intensity.stations ?? <IntensityStationItem>[])
      s.value.code: s,
  };

  // EarthquakeParameterの階層を走査してツリーを構築
  final regionNodes = <RegionIntensityNode>[];

  for (final region in parameter.regions) {
    final prefectureIntensity = prefectureIntensityMap[region.code];
    if (prefectureIntensity == null) {
      continue;
    }

    final cityNodes = <CityIntensityNode>[];

    for (final city in region.cities) {
      final cityIntensity = cityIntensityMap[city.code];
      if (cityIntensity == null) {
        continue;
      }

      final stationNodes = <StationIntensityNode>[];

      for (final station in city.stations) {
        final stationIntensity = stationIntensityMap[station.code];
        if (stationIntensity == null) {
          continue;
        }
        stationNodes.add(
          StationIntensityNode(
            station: station,
            intensity: stationIntensity,
          ),
        );
      }

      // 観測点を震度降順でソート
      stationNodes.sort((a, b) {
        final aIntensity = a.intensity?.maxIntensity?.index ?? -1;
        final bIntensity = b.intensity?.maxIntensity?.index ?? -1;
        return bIntensity.compareTo(aIntensity);
      });

      cityNodes.add(
        CityIntensityNode(
          city: city,
          maxIntensity: cityIntensity.maxIntensity,
          stations: stationNodes,
        ),
      );
    }

    // 市区町村を震度降順でソート
    cityNodes.sort((a, b) {
      final aIntensity = a.maxIntensity?.index ?? -1;
      final bIntensity = b.maxIntensity?.index ?? -1;
      return bIntensity.compareTo(aIntensity);
    });

    regionNodes.add(
      RegionIntensityNode(
        region: region,
        maxIntensity: prefectureIntensity.maxIntensity,
        cities: cityNodes,
      ),
    );
  }

  // 都道府県の最大震度でグループ化
  final groupedByIntensity = regionNodes
      .where((r) => r.maxIntensity != null)
      .groupListsBy((r) => r.maxIntensity);

  // 震度降順でソート
  final sortedMap = Map.fromEntries(
    groupedByIntensity.entries.toList()
      ..sort((a, b) => b.key.index.compareTo(a.key.index)),
  );

  return IntensityTree(byIntensity: sortedMap);
}
