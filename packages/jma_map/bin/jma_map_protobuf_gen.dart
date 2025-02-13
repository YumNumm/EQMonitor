import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:jma_map/gen/jma_map.pb.dart';

Future<void> main() async {
  final jmaMapDataList = <JmaMap_JmaMapData>[];

  final targets = [
    JmaMap_JmaMapData_JmaMapType.AREA_FORECAST_LOCAL_EEW,
    JmaMap_JmaMapData_JmaMapType.AREA_FORECAST_LOCAL_E,
    JmaMap_JmaMapData_JmaMapType.AREA_INFORMATION_CITY,
    JmaMap_JmaMapData_JmaMapType.AREA_TSUNAMI,
  ];
  for (final target in targets) {
    final body = await File('maps/${target.toFileName}.geojson').readAsString();
    final json = jsonDecode(body) as Map<String, dynamic>;

    final jmaMapData = await _parseGeoJsonToJmaMap(json);
    print(jmaMapData.length);
    jmaMapDataList.add(JmaMap_JmaMapData(mapType: target, data: jmaMapData));
  }
  // dump to file
  final file = File('out.pb');
  await file.writeAsBytes(JmaMap(data: jmaMapDataList).writeToBuffer());
}

Future<List<JmaMap_JmaMapData_JmaMapDataItem>> _parseGeoJsonToJmaMap(
  Map<String, dynamic> geojson,
) async {
  final results = <JmaMap_JmaMapData_JmaMapDataItem>[];
  final features = geojson['features'] as List<dynamic>;
  for (final feature in features) {
    final json = feature as Map<String, dynamic>;
    if (json case {
      'geometry': {
        'type': final String geometryType,
        'coordinates': final List<dynamic> coordinates,
      },
      'properties': final Map<String, dynamic> properties,
    }) {
      final latLngs = <LatLng>[];
      if (geometryType == 'Polygon') {
        for (final lists in coordinates) {
          for (final list in lists as List<dynamic>) {
            final ld = list as List<dynamic>;
            final lat = ld[1] as double;
            final lng = ld[0] as double;
            latLngs.add(LatLng(lat: lat, lng: lng));
          }
        }
      } else if (geometryType == 'MultiPolygon') {
        for (final lists in coordinates) {
          for (final list in lists as List<dynamic>) {
            for (final l in list as List<dynamic>) {
              final ld = l as List<dynamic>;
              final lat = ld[1] as double;
              final lng = ld[0] as double;
              latLngs.add(LatLng(lat: lat, lng: lng));
            }
          }
        }
      } else if (geometryType == 'MultiLineString') {
        for (final e in coordinates) {
          for (final list in e as List<dynamic>) {
            final ld = list as List<dynamic>;
            final lat = ld[1] as double;
            final lng = ld[0] as double;
            latLngs.add(LatLng(lat: lat, lng: lng));
          }
        }
      } else if (geometryType == 'LineString') {
        for (final list in coordinates) {
          final ld = list as List<dynamic>;
          final lat = ld[1] as double;
          final lng = ld[0] as double;
          latLngs.add(LatLng(lat: lat, lng: lng));
        }
      } else {
        throw Exception('Unknown geometry type: $geometryType');
      }
      final bbox = latLngs.toLatLngBounds;
      var skipFlag = false;
      final property = JmaMap_JmaMapData_JmaMapDataItem_Property(
        code:
            properties['code'] as String? ??
            properties['regioncode'] as String? ??
            (() {
              skipFlag = true;
              print('Unknown code: $properties');
            }()),
        name:
            properties['name'] as String? ??
            (throw Exception('Unknown name: $properties')),
        nameKana:
            properties['namekana'] as String? ??
            (() {
              skipFlag = true;
              print('Unknown nameKana: $properties');
            }()),
      );
      if (skipFlag) {
        continue;
      }
      results.add(
        JmaMap_JmaMapData_JmaMapDataItem(bounds: bbox, property: property),
      );
    } else {
      throw Exception('Unknown feature: $json');
    }
  }
  return results;
}

extension LatLngListEx on List<LatLng> {
  LatLngBounds get toLatLngBounds {
    final latLngs = this;
    if (latLngs.isEmpty) {
      throw Exception('LatLngs is empty');
    }
    var northEastLat = -180.0;
    var northEastLng = -180.0;
    var southWestLat = 180.0;
    var southWestLng = 180.0;
    for (final latLng in latLngs) {
      northEastLat = max(northEastLat, latLng.lat);
      northEastLng = max(northEastLng, latLng.lng);
      southWestLat = min(southWestLat, latLng.lat);
      southWestLng = min(southWestLng, latLng.lng);
    }
    final latLngBounds = LatLngBounds(
      northEast: LatLng(lat: northEastLat, lng: northEastLng),
      southWest: LatLng(lat: southWestLat, lng: southWestLng),
    );
    return latLngBounds;
  }
}

extension JmaMapTypeConverter on JmaMap_JmaMapData_JmaMapType {
  String get toFileName => switch (this) {
    JmaMap_JmaMapData_JmaMapType.AREA_FORECAST_LOCAL_E => 'areaForecastLocalE',
    JmaMap_JmaMapData_JmaMapType.AREA_FORECAST_LOCAL_EEW =>
      'areaForecastLocalEew',
    JmaMap_JmaMapData_JmaMapType.AREA_INFORMATION_CITY =>
      'areaInformationCityQuake',
    JmaMap_JmaMapData_JmaMapType.AREA_TSUNAMI => 'areaTsunami',
    _ => throw UnimplementedError(),
  };
}
