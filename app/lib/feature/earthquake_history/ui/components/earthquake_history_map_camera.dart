import 'package:eqmonitor/feature/earthquake_history/data/model/coordinate.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_intensity_map_focus.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_tree.dart';
import 'package:maplibre/maplibre.dart';

/// 地震履歴詳細マップの初期表示位置（震源が取れない場合のフォールバック）
const Geographic kEarthquakeHistoryMapDefaultCenter = Geographic(
  lon: 138,
  lat: 36.5,
);

const double kEarthquakeHistoryMapDefaultZoom = 5;
const double kEarthquakeHistoryMapHypocenterZoom = 6.5;
const double kEarthquakeHistoryMapFocusZoom = 8;

/// 震源があればその位置、なければ日本付近の既定位置
Geographic initialGeographicForEarthquake(Earthquake earthquake) {
  final hyp = earthquake.hypocenter;
  if (hyp == null) {
    return kEarthquakeHistoryMapDefaultCenter;
  }
  return switch (hyp.coordinates) {
    CoordinateLatLng(latitude: final lat, longitude: final lng) =>
      Geographic(lon: lng, lat: lat),
    _ => kEarthquakeHistoryMapDefaultCenter,
  };
}

double initialZoomForEarthquake(Earthquake earthquake) =>
    earthquake.hypocenter == null
    ? kEarthquakeHistoryMapDefaultZoom
    : kEarthquakeHistoryMapHypocenterZoom;

/// 各地の震度ツリーで選択されたコードに対応する代表座標（観測点の緯度経度を優先）
Geographic? geographicForEarthquakeIntensityFocus(
  Earthquake earthquake,
  EarthquakeIntensityMapFocus focus,
) {
  final intensity = earthquake.intensity;
  if (intensity == null) {
    return null;
  }

  for (final regions in intensity.intensityTree.values) {
    for (final regionNode in regions) {
      final region = regionNode.region.region;
      switch (focus.kind) {
        case EarthquakeIntensityMapFocusKind.prefectureRegion:
          if (region.code == focus.code) {
            return _representativeGeographicForRegion(regionNode);
          }
        case EarthquakeIntensityMapFocusKind.city:
          for (final city in regionNode.cities) {
            if (city.city.code == focus.code) {
              return _representativeGeographicForCity(city);
            }
          }
        case EarthquakeIntensityMapFocusKind.station:
          for (final city in regionNode.cities) {
            for (final stationNode in city.stations) {
              final station = stationNode.station;
              if (station.code == focus.code) {
                if (station.hasLatitude() && station.hasLongitude()) {
                  return Geographic(lon: station.longitude, lat: station.latitude);
                }
                return null;
              }
            }
          }
      }
    }
  }
  return null;
}

Geographic? _representativeGeographicForRegion(RegionIntensityNode regionNode) {
  for (final city in regionNode.cities) {
    final g = _representativeGeographicForCity(city);
    if (g != null) {
      return g;
    }
  }
  Geographic? fallback;
  for (final city in regionNode.cities) {
    for (final stationNode in city.stations) {
      final station = stationNode.station;
      if (station.hasLatitude() && station.hasLongitude()) {
        fallback ??= Geographic(lon: station.longitude, lat: station.latitude);
      }
    }
  }
  return fallback;
}

Geographic? _representativeGeographicForCity(CityIntensityNode cityNode) {
  for (final stationNode in cityNode.stations) {
    final station = stationNode.station;
    if (station.hasLatitude() && station.hasLongitude()) {
      return Geographic(lon: station.longitude, lat: station.latitude);
    }
  }
  return null;
}
