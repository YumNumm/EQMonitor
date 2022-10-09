import 'dart:convert';

import 'package:eqmonitor/schema/local/prefecture/map_polygon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:geojson/geojson.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';

import '../../utils/map/map_global_offset.dart';

/// 緊急地震速報/府県予報区
final mapAreaForecastLocalEewProvider = Provider<List<MapPolygon>>((ref) {
  throw UnimplementedError();
});

Future<List<MapPolygon>> loadMapAreaForecastLocalEew() async {
  final stopwatch = Stopwatch()..start();
  final geo = GeoJson();
  final logger = Logger();

  final mapPaths = <MapPolygon>[];

  geo.processedFeatures.listen((feature) {
    if (feature.type == GeoJsonFeatureType.multipolygon) {
      final geometry = feature.geometry as GeoJsonMultiPolygon;
      for (final polygon in geometry.polygons) {
        for (final geoSeries in polygon.geoSeries) {
          if (feature.properties!['code'] == null) {
            continue;
          }
          final tmpPoints = <Offset>[];
          for (final geoPoint in geoSeries.geoPoints) {
            final offset = MapGlobalOffset.latLonToGlobalPoint(geoPoint.point)
                .toLocalOffset(const Size(476, 927.4));
            tmpPoints.add(offset);
          }
          mapPaths.add(
            MapPolygon(
              code: int.parse(feature.properties!['code'].toString()),
              name: feature.properties!['name'].toString(),
              path: Path()..addPolygon(tmpPoints, true),
              points: tmpPoints,
            ),
          );
        }
      }
    } else if (feature.type == GeoJsonFeatureType.polygon) {
      final geometry = feature.geometry as GeoJsonPolygon;
      for (final geoSeries in geometry.geoSeries) {
        if (feature.properties!['code'] == null) {
          continue;
        }
        final tmpPoints = <Offset>[];
        for (final geoPoint in geoSeries.geoPoints) {
          final offset = MapGlobalOffset.latLonToGlobalPoint(geoPoint.point)
              .toLocalOffset(const Size(476, 927.4));
          tmpPoints.add(offset);
        }
        mapPaths.add(
          MapPolygon(
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
        'AreaForecastLocalEEW.jsonを読み込みました: ${stopwatch.elapsedMicroseconds / 1000}ms');
  });
  await geo.parse(
    utf8.decode(
      (await rootBundle.load('assets/maps/AreaForecastLocalEEW.json'))
          .buffer
          .asUint8List(),
    ),
  );
  return mapPaths;
}