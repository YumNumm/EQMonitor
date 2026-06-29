import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_sort_by.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/sort_order.dart';
import 'package:flutter/foundation.dart';

@immutable
class NearbyEarthquakeSearchParameter {
  const NearbyEarthquakeSearchParameter({
    required this.latitude,
    required this.longitude,
    required this.sortBy,
    required this.sortOrder,
    this.depth,
    this.latLngRange = defaultLatLngRange,
    this.depthRangeKm = defaultDepthRangeKm,
  });

  static const defaultLatLngRange = 0.5;
  static const defaultDepthRangeKm = 50;
  static const detailPageFetchLimit = 5;

  final double latitude;
  final double longitude;
  final int? depth;
  final double latLngRange;
  final int depthRangeKm;
  final EarthquakeSortBy sortBy;
  final SortOrder sortOrder;

  int get fetchLimit => detailPageFetchLimit;

  String get latLngRangeLabel =>
      '緯度経度: 震源から±${latLngRange.toStringAsFixed(1)}°';

  String get depthRangeLabel {
    final historyParameter = toHistoryParameter();
    final depthGte = historyParameter.depthGte;
    final depthLte = historyParameter.depthLte;
    if (depthGte == null || depthLte == null) {
      return '深さ: 条件なし';
    }
    return '深さ: $depthGte〜${depthLte}km';
  }

  NearbyEarthquakeSearchParameter updateSort(EarthquakeSortBy newSortBy) {
    if (sortBy == newSortBy) {
      return NearbyEarthquakeSearchParameter(
        latitude: latitude,
        longitude: longitude,
        depth: depth,
        latLngRange: latLngRange,
        depthRangeKm: depthRangeKm,
        sortBy: sortBy,
        sortOrder: sortOrder == SortOrder.asc ? SortOrder.desc : SortOrder.asc,
      );
    }
    return NearbyEarthquakeSearchParameter(
      latitude: latitude,
      longitude: longitude,
      depth: depth,
      latLngRange: latLngRange,
      depthRangeKm: depthRangeKm,
      sortBy: newSortBy,
      sortOrder: switch (newSortBy) {
        EarthquakeSortBy.depth => SortOrder.asc,
        _ => SortOrder.desc,
      },
    );
  }

  EarthquakeHistoryParameter toHistoryParameter() {
    final depthValue = depth;
    return EarthquakeHistoryParameter(
      latitudeGte: latitude - latLngRange,
      latitudeLte: latitude + latLngRange,
      longitudeGte: longitude - latLngRange,
      longitudeLte: longitude + latLngRange,
      depthGte: depthValue != null
          ? (depthValue - depthRangeKm).clamp(0, 9999)
          : null,
      depthLte: depthValue != null ? depthValue + depthRangeKm : null,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  bool operator ==(covariant NearbyEarthquakeSearchParameter other) =>
      latitude == other.latitude &&
      longitude == other.longitude &&
      depth == other.depth &&
      latLngRange == other.latLngRange &&
      depthRangeKm == other.depthRangeKm &&
      sortBy == other.sortBy &&
      sortOrder == other.sortOrder;

  @override
  int get hashCode => Object.hash(
    latitude,
    longitude,
    depth,
    latLngRange,
    depthRangeKm,
    sortBy,
    sortOrder,
  );
}
