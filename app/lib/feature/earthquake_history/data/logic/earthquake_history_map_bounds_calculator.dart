import 'package:eqmonitor/feature/earthquake_history/data/model/coordinate.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/shindo_db_intensity_tree.dart';
import 'package:jma_map/jma_map.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'earthquake_history_map_bounds_calculator.g.dart';

typedef EarthquakeHistoryMapPoint = ({
  double latitude,
  double longitude,
});

@riverpod
EarthquakeHistoryMapBoundsCalculator earthquakeHistoryMapBoundsCalculator(
  Ref ref,
) => const EarthquakeHistoryMapBoundsCalculator();

/// 地震履歴詳細マップの表示領域に含める座標を算出する。
class EarthquakeHistoryMapBoundsCalculator {
  const new();

  List<EarthquakeHistoryMapPoint> calculate({
    required Earthquake earthquake,
    required JmaMap_JmaMapData? regionMap,
    ShindoDbIntensityTree? dbTree,
  }) {
    final stationPoints = dbTree == null
        ? intensityStationPoints(earthquake)
        : databaseStationPoints(dbTree);
    final intensityPoints = dbTree != null || stationPoints.isNotEmpty
        ? stationPoints
        : regionMap == null
        ? const <EarthquakeHistoryMapPoint>[]
        : regionBoundsPoints(earthquake: earthquake, regionMap: regionMap);
    final hypocenter = hypocenterPoint(earthquake);
    return [...intensityPoints, if (hypocenter != null) hypocenter];
  }

  bool requiresRegionMap({
    required Earthquake earthquake,
    required ShindoDbIntensityTree? dbTree,
  }) {
    if (dbTree != null || intensityStationPoints(earthquake).isNotEmpty) {
      return false;
    }
    return earthquake.intensity?.regions.values.any(
          (regions) => regions.isNotEmpty,
        ) ??
        false;
  }

  List<EarthquakeHistoryMapPoint> intensityStationPoints(
    Earthquake earthquake,
  ) {
    final intensity = earthquake.intensity;
    if (intensity == null) {
      return const [];
    }
    return [
      for (final regions in intensity.intensityTree.values)
        for (final region in regions)
          for (final city in region.cities)
            for (final stationNode in city.stations)
              (
                latitude: stationNode.station.location.lat,
                longitude: stationNode.station.location.lon,
              ),
    ];
  }

  List<EarthquakeHistoryMapPoint> databaseStationPoints(
    ShindoDbIntensityTree tree,
  ) => [
    for (final prefectures in tree.tree.values)
      for (final prefecture in prefectures)
        for (final city in prefecture.cities)
          for (final station in city.stations)
            if (station.location case final location?)
              (latitude: location.lat, longitude: location.lon),
    for (final stations in tree.unresolvedStations.values)
      for (final station in stations)
        if (station.location case final location?)
          (latitude: location.lat, longitude: location.lon),
  ];

  List<EarthquakeHistoryMapPoint> regionBoundsPoints({
    required Earthquake earthquake,
    required JmaMap_JmaMapData regionMap,
  }) {
    final intensity = earthquake.intensity;
    if (intensity == null) {
      return const [];
    }
    final affectedCodes = {
      for (final regions in intensity.regions.values)
        for (final region in regions) region.region.code,
    };
    final items = regionMap.data.where(
      (item) => affectedCodes.contains(item.property.code) && item.hasBounds(),
    );
    return [
      for (final item in items)
        if (item.bounds.hasSouthWest())
          (
            latitude: item.bounds.southWest.lat,
            longitude: item.bounds.southWest.lng,
          ),
      for (final item in items)
        if (item.bounds.hasNorthEast())
          (
            latitude: item.bounds.northEast.lat,
            longitude: item.bounds.northEast.lng,
          ),
    ];
  }

  EarthquakeHistoryMapPoint? hypocenterPoint(Earthquake earthquake) =>
      switch (earthquake.hypocenter?.coordinates) {
        CoordinateLatLng(:final latitude, :final longitude) => (
          latitude: latitude,
          longitude: longitude,
        ),
        _ => null,
      };
}
