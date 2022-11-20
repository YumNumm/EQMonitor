import 'dart:convert';

import 'package:eqmonitor/schema/local/prefecture/map_polygon.dart';
import 'package:eqmonitor/utils/talker_log/log_types.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:geojson/geojson.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../../utils/map/map_global_offset.dart';

/// 市町村等(地震津波関係)
final mapAreaInformationCityQuakeProvider =
    Provider<List<MapAreaInformationCityQuakePolygon>>((ref) {
  throw UnimplementedError();
});

class MapAreaInformationCityQuakePolygon extends MapPolygon {
  const MapAreaInformationCityQuakePolygon({
    required super.code,
    required super.name,
    required super.path,
    required super.points,
    required this.regionname,
  });

  final String regionname;
}

Future<List<MapAreaInformationCityQuakePolygon>>
    loadMapAreaInformationCityQuake(Talker talker) async {
  final stopwatch = Stopwatch()..start();
  final geo = GeoJson();

  final mapPaths = <MapAreaInformationCityQuakePolygon>[];

  geo.processedFeatures.listen((feature) {
    if (feature.type == GeoJsonFeatureType.multipolygon) {
      final geometry = feature.geometry as GeoJsonMultiPolygon;
      for (final polygon in geometry.polygons) {
        for (final geoSeries in polygon.geoSeries) {
          if (feature.properties!['regioncode'] == null) {
            continue;
          }
          final tmpPoints = <Offset>[];
          for (final geoPoint in geoSeries.geoPoints) {
            final offset = MapGlobalOffset.latLonToGlobalPoint(geoPoint.point)
                .toLocalOffset(const Size(476, 927.4));
            tmpPoints.add(offset);
          }
          mapPaths.add(
            MapAreaInformationCityQuakePolygon(
              code: int.parse(feature.properties!['regioncode'].toString()),
              name: feature.properties!['name'].toString(),
              path: Path()..addPolygon(tmpPoints, true),
              points: tmpPoints,
              regionname: feature.properties!['regionname'].toString(),
            ),
          );
        }
      }
    } else if (feature.type == GeoJsonFeatureType.polygon) {
      final geometry = feature.geometry as GeoJsonPolygon;
      for (final geoSeries in geometry.geoSeries) {
        if (feature.properties!['regioncode'] == null) {
          continue;
        }
        final tmpPoints = <Offset>[];
        for (final geoPoint in geoSeries.geoPoints) {
          final offset = MapGlobalOffset.latLonToGlobalPoint(geoPoint.point)
              .toLocalOffset(const Size(476, 927.4));
          tmpPoints.add(offset);
        }
        mapPaths.add(
          MapAreaInformationCityQuakePolygon(
            code: int.parse(feature.properties!['regioncode'].toString()),
            name: feature.properties!['name'].toString(),
            path: Path()..addPolygon(tmpPoints, true),
            points: tmpPoints,
            regionname: feature.properties!['regionname'].toString(),
          ),
        );
      }
    }
  });
  geo.endSignal.listen((_) {
    stopwatch.stop();
    talker.logTyped(
      InitializationEventLog(
        'mapAreaInformationCityQuakeを読み込みました: '
        '${stopwatch.elapsedMicroseconds / 1000}ms\n'
        '読み込んだ数: ${mapPaths.length}',
      ),
    );
  });
  await geo.parse(
    utf8.decode(
      (await rootBundle.load('assets/maps/AreaInformationCityQuake.json'))
          .buffer
          .asUint8List(),
    ),
  );
  return mapPaths;
}
