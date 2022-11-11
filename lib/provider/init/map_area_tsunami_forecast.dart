import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:geojson/geojson.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';

import '../../schema/local/prefecture/map_polygon.dart';
import '../../utils/map/map_global_offset.dart';

/// 地震情報／細分区域
final mapAreaTsunamiForecastProvider = Provider<List<MapPolygon>>((ref) {
  throw UnimplementedError();
});

class MapAreaTsunami extends MapPolygon {
  const MapAreaTsunami({
    required super.code,
    required super.name,
    required super.path,
    required super.points,
  });
}

Future<List<MapAreaTsunami>> loadMapAreaTsunamiForecast() async {
  final stopwatch = Stopwatch()..start();
  final geo = GeoJson();
  final logger = Logger();

  final mapPaths = <MapAreaTsunami>[];

  geo.processedFeatures.listen((feature) {
    if (feature.type == GeoJsonFeatureType.line) {
      final geometry = feature.geometry as GeoJsonLine;
      if (geometry.geoSerie != null) {
        final tmpPoints = <Offset>[];
        for (final geoPoint in geometry.geoSerie!.geoPoints) {
          final offset = MapGlobalOffset.latLonToGlobalPoint(geoPoint.point)
              .toLocalOffset(const Size(476, 927.4));
          tmpPoints.add(offset);
        }
        mapPaths.add(
          MapAreaTsunami(
            code: int.parse(feature.properties!['code'].toString()),
            name: feature.properties!['name'].toString(),
            path: Path()..addPolygon(tmpPoints, true),
            points: tmpPoints,
          ),
        );
      }
    } else if (feature.type == GeoJsonFeatureType.multiline) {
      final geometrys = feature.geometry as GeoJsonMultiLine;
      for (final lines in geometrys.lines) {
        final tmpPoints = <Offset>[];
        for (final geoPoint in lines.geoSerie!.geoPoints) {
          final offset = MapGlobalOffset.latLonToGlobalPoint(geoPoint.point)
              .toLocalOffset(const Size(476, 927.4));
          tmpPoints.add(offset);
        }
        mapPaths.add(
          MapAreaTsunami(
            code: int.parse(feature.properties!['code'].toString()),
            name: feature.properties!['name'].toString(),
            path: Path()..addPolygon(tmpPoints, true),
            points: tmpPoints,
          ),
        );
      }
    }
  });
  geo.endSignal.listen((_) {
    stopwatch.stop();
    logger.i(
      'MapAreaTsunamiForecastを読み込みました: ${stopwatch.elapsedMicroseconds / 1000}ms',
    );
  });
  await geo.parse(
    utf8.decode(
      (await rootBundle.load('assets/maps/AreaTsunamiForecast.json'))
          .buffer
          .asUint8List(),
    ),
  );
  return mapPaths;
}
