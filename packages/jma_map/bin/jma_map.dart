import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:collection/collection.dart';
import 'package:geobase/coordinates.dart';
import 'package:geobase/vector.dart';
import 'package:geobase/vector_data.dart';
import 'package:geodata/geodata.dart';
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
    final body =
        await File('geojson/${target.toFileName}.geojson').readAsString();
    final data = await _parseGeoJsonToJmaMap(body);
    jmaMapDataList.add(JmaMap_JmaMapData(data: data, mapType: target));
  }
  // dump to file
  final file = File('out.pb');
  await file.writeAsBytes(JmaMap(data: jmaMapDataList).writeToBuffer());

  // dump to json
  final json = JmaMap(data: jmaMapDataList).toProto3Json();
  await File('out.json').writeAsString(jsonEncode(json));
}

Future<List<JmaMap_JmaMapData_JmaMapDataItem>> _parseGeoJsonToJmaMap(
  String body,
) async {
  final results = <JmaMap_JmaMapData_JmaMapDataItem>[];

  final source = GeoJSONFeatures.any(() async => body);
  final items = await source.itemsAllPaged(limit: null);
  final features = items.current.collection.features;
  for (final feature in features) {
    final geometry = feature.geometry;
    final propertyMap = feature.properties;

    final p = (
      code:
          (propertyMap['code'] as String?) ??
          propertyMap['regioncode'] as String?,
      name: propertyMap['name'] as String,
      nameKana: propertyMap['namekana'] as String?,
    );

    final byteFormat = WKB.geometry;

    switch (geometry) {
      case Polygon():
        final polylabel = geometry.polylabel2D(scheme: Geographic.scheme);
        final bbox = geometry.calculateBounds(scheme: Geographic.scheme)!;

        results.add(
          JmaMap_JmaMapData_JmaMapDataItem(
            bounds: JmaMap_LatLngBounds(
              southWest: JmaMap_LatLng(lat: bbox.minY, lng: bbox.minX),
              northEast: JmaMap_LatLng(lat: bbox.maxY, lng: bbox.maxX),
            ),
            polylabel: JmaMap_LatLng(
              lat: polylabel.position.y,
              lng: polylabel.position.x,
            ),
            property: JmaMap_JmaMapData_JmaMapDataItem_Property(
              code: p.code,
              name: p.name,
              nameKana: p.nameKana,
            ),
            bytes: geometry.toBytes(format: byteFormat),
            dataType: JmaMap_JmaMapData_DataType.POLYGON,
          ),
        );
      case MultiPolygon():
        // 最も面積が大きいPolygonのpolylabelを取得する
        final maxAreaPolygon =
            geometry.polygons
                .map((polygon) {
                  final area = polygon.area2D();
                  return (polygon, area);
                })
                .sorted((a, b) => b.$2.compareTo(a.$2))
                .first;
        final polylabel = maxAreaPolygon.$1.polylabel2D(
          scheme: Geographic.scheme,
        );

        final bbox = geometry.calculateBounds(scheme: Geographic.scheme)!;

        results.add(
          JmaMap_JmaMapData_JmaMapDataItem(
            bounds: JmaMap_LatLngBounds(
              southWest: JmaMap_LatLng(lat: bbox.minY, lng: bbox.minX),
              northEast: JmaMap_LatLng(lat: bbox.maxY, lng: bbox.maxX),
            ),
            polylabel: JmaMap_LatLng(
              lat: polylabel.position.y,
              lng: polylabel.position.x,
            ),
            property: JmaMap_JmaMapData_JmaMapDataItem_Property(
              code: p.code,
              name: p.name,
              nameKana: p.nameKana,
            ),
            bytes: geometry.toBytes(format: byteFormat),
            dataType: JmaMap_JmaMapData_DataType.MULTI_POLYGON,
          ),
        );
      case MultiLineString():
        // 最も長いLineStringのcentroidを取得する
        final maxLengthLineString =
            geometry.lineStrings
                .map((lineString) {
                  final length = lineString.length2D();
                  return (lineString, length);
                })
                .sorted((a, b) => b.$2.compareTo(a.$2))
                .first;
        final centroid =
            maxLengthLineString.$1.centroid2D(scheme: Geographic.scheme)!;

        final bbox = geometry.calculateBounds(scheme: Geographic.scheme)!;

        results.add(
          JmaMap_JmaMapData_JmaMapDataItem(
            bounds: JmaMap_LatLngBounds(
              southWest: JmaMap_LatLng(lat: bbox.minY, lng: bbox.minX),
              northEast: JmaMap_LatLng(lat: bbox.maxY, lng: bbox.maxX),
            ),
            polylabel: JmaMap_LatLng(lat: centroid.y, lng: centroid.x),
            property: JmaMap_JmaMapData_JmaMapDataItem_Property(
              code: p.code,
              name: p.name,
              nameKana: p.nameKana,
            ),
            bytes: geometry.toBytes(format: byteFormat),
            dataType: JmaMap_JmaMapData_DataType.MULTI_LINE_STRING,
          ),
        );
      case LineString():
        final centroid = geometry.centroid2D(scheme: Geographic.scheme)!;

        final bbox = geometry.calculateBounds(scheme: Geographic.scheme)!;

        results.add(
          JmaMap_JmaMapData_JmaMapDataItem(
            bounds: JmaMap_LatLngBounds(
              southWest: JmaMap_LatLng(lat: bbox.minY, lng: bbox.minX),
              northEast: JmaMap_LatLng(lat: bbox.maxY, lng: bbox.maxX),
            ),
            polylabel: JmaMap_LatLng(lat: centroid.y, lng: centroid.x),
            property: JmaMap_JmaMapData_JmaMapDataItem_Property(
              code: p.code,
              name: p.name,
              nameKana: p.nameKana,
            ),
            bytes: geometry.toBytes(format: byteFormat),
            dataType: JmaMap_JmaMapData_DataType.LINE_STRING,
          ),
        );
      case null:
        print('geometry is null: $feature');
        continue;
      case _:
        throw UnimplementedError(
          "Unsupported geometry type: ${geometry.geomType}",
        );
    }
  }
  return results;
}

extension LatLngListEx on List<JmaMap_LatLng> {
  JmaMap_LatLngBounds get toLatLngBounds {
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
    final latLngBounds = JmaMap_LatLngBounds(
      northEast: JmaMap_LatLng(lat: northEastLat, lng: northEastLng),
      southWest: JmaMap_LatLng(lat: southWestLat, lng: southWestLng),
    );
    return latLngBounds;
  }
}

extension JmaMapTypeConverter on JmaMap_JmaMapData_JmaMapType {
  String get toFileName => switch (this) {
    JmaMap_JmaMapData_JmaMapType.AREA_FORECAST_LOCAL_E => 'AreaForecastLocalE',
    JmaMap_JmaMapData_JmaMapType.AREA_FORECAST_LOCAL_EEW =>
      'AreaForecastLocalEew',
    JmaMap_JmaMapData_JmaMapType.AREA_INFORMATION_CITY =>
      'AreaInformationCityQuake',
    JmaMap_JmaMapData_JmaMapType.AREA_TSUNAMI => 'AreaTsunami',
    _ => throw UnimplementedError(),
  };
}
