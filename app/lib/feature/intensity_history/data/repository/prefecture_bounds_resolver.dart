import 'package:eqmonitor/core/provider/map/jma_map_provider.dart';
import 'package:eqmonitor/feature/parameter/data/model/earthquake/earthquake_parameter.dart';
import 'package:jma_map/jma_map.dart';
import 'package:maplibre/maplibre.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'prefecture_bounds_resolver.g.dart';

/// 細分区域コードとその外接矩形の組。
typedef RegionBoundsEntry = ({String code, LngLatBounds bounds});

@Riverpod(keepAlive: true)
PrefectureBoundsResolver prefectureBoundsResolver(Ref ref) =>
    const PrefectureBoundsResolver();

/// 都道府県フォーカス時にカメラを合わせる範囲を算出する。
///
/// 都道府県配下の細分区域の外接矩形を単純に union すると、遠隔の離島を持つ
/// 都道府県で範囲が数百km規模に広がり、人口の集中する陸地がほとんど見えない
/// ズームになる（東京都の小笠原諸島・南鳥島、鹿児島県の十島村、沖縄県の
/// 大東島など）。
///
/// そのため細分区域を近接するものだけで単連結にまとめ、[resolve] の
/// `seedRegionCode` を含むクラスタ（未指定時は市区町村数が最多のクラスタ）
/// だけを採用する。
class PrefectureBoundsResolver {
  const PrefectureBoundsResolver();

  /// 同一クラスタとみなす外接矩形間の最大ギャップ（度）。
  ///
  /// 陸続きの細分区域は境界を共有するため外接矩形が重なる。海で隔たれた
  /// 離島を別クラスタに分けたいので、矩形量子化の誤差を吸収できる程度の
  /// 小さな値のみを許容する。
  static const clusterGapDegrees = 0.2;

  LngLatBounds? resolve({
    required String prefectureCode,
    required List<EarthquakeParameterPrefectureItem> prefectures,
    required Map<JmaMapType, JmaMap_JmaMapData> jmaMap,
    String? seedRegionCode,
  }) {
    final prefecture = prefectures
        .where((prefecture) => prefecture.code == prefectureCode)
        .firstOrNull;
    if (prefecture == null) {
      return null;
    }

    final cityCountByRegionCode = {
      for (final region in prefecture.regions)
        region.code: region.cities.length,
    };
    final regions = jmaMap.areaForecastLocalE.data
        .where(
          (item) =>
              item.hasBounds() &&
              item.hasProperty() &&
              cityCountByRegionCode.containsKey(item.property.code),
        )
        .map(
          (item) => (
            code: item.property.code,
            bounds: LngLatBounds(
              longitudeWest: item.bounds.southWest.lng,
              longitudeEast: item.bounds.northEast.lng,
              latitudeSouth: item.bounds.southWest.lat,
              latitudeNorth: item.bounds.northEast.lat,
            ),
          ),
        )
        .toList();
    if (regions.isEmpty) {
      return null;
    }

    final clusters = clusterByProximity(regions);
    final seeded = seedRegionCode == null
        ? null
        : clusters
              .where(
                (cluster) =>
                    cluster.any((region) => region.code == seedRegionCode),
              )
              .firstOrNull;
    final selected =
        seeded ??
        clusters.reduce(
          (a, b) =>
              cityCount(
                    cityCountByRegionCode: cityCountByRegionCode,
                    cluster: b,
                  ) >
                  cityCount(
                    cityCountByRegionCode: cityCountByRegionCode,
                    cluster: a,
                  )
              ? b
              : a,
        );

    return unionBounds(selected.map((region) => region.bounds));
  }

  /// [clusterGapDegrees] 以内で連結する細分区域どうしを同じクラスタにまとめる。
  List<List<RegionBoundsEntry>> clusterByProximity(
    List<RegionBoundsEntry> regions,
  ) {
    final labels = List<int>.generate(regions.length, (index) => index);
    var hasMerged = true;
    while (hasMerged) {
      hasMerged = false;
      for (var i = 0; i < regions.length; i++) {
        for (var j = i + 1; j < regions.length; j++) {
          if (labels[i] == labels[j] ||
              !isNeighbouring(regions[i].bounds, regions[j].bounds)) {
            continue;
          }
          final keep = labels[i] < labels[j] ? labels[i] : labels[j];
          final drop = labels[i] < labels[j] ? labels[j] : labels[i];
          for (var k = 0; k < labels.length; k++) {
            if (labels[k] == drop) {
              labels[k] = keep;
            }
          }
          hasMerged = true;
        }
      }
    }

    final grouped = <int, List<RegionBoundsEntry>>{};
    for (var i = 0; i < regions.length; i++) {
      grouped.putIfAbsent(labels[i], () => []).add(regions[i]);
    }
    return grouped.values.toList();
  }

  /// [clusterGapDegrees] だけ膨らませた矩形同士が交差するかどうか。
  bool isNeighbouring(LngLatBounds a, LngLatBounds b) =>
      a.longitudeWest - clusterGapDegrees <= b.longitudeEast &&
      b.longitudeWest - clusterGapDegrees <= a.longitudeEast &&
      a.latitudeSouth - clusterGapDegrees <= b.latitudeNorth &&
      b.latitudeSouth - clusterGapDegrees <= a.latitudeNorth;

  int cityCount({
    required Map<String, int> cityCountByRegionCode,
    required List<RegionBoundsEntry> cluster,
  }) => cluster.fold(
    0,
    (sum, region) => sum + (cityCountByRegionCode[region.code] ?? 0),
  );

  LngLatBounds? unionBounds(Iterable<LngLatBounds> boundsList) {
    final first = boundsList.firstOrNull;
    if (first == null) {
      return null;
    }
    var west = first.longitudeWest;
    var east = first.longitudeEast;
    var south = first.latitudeSouth;
    var north = first.latitudeNorth;
    for (final bounds in boundsList.skip(1)) {
      west = bounds.longitudeWest < west ? bounds.longitudeWest : west;
      east = bounds.longitudeEast > east ? bounds.longitudeEast : east;
      south = bounds.latitudeSouth < south ? bounds.latitudeSouth : south;
      north = bounds.latitudeNorth > north ? bounds.latitudeNorth : north;
    }
    return LngLatBounds(
      longitudeWest: west,
      longitudeEast: east,
      latitudeSouth: south,
      latitudeNorth: north,
    );
  }
}
