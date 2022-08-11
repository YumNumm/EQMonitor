import 'package:eqmonitor/const/prefecture/area_forecast_local_eew.model.dart';
import 'package:eqmonitor/model/kmoni_map_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geojson/geojson.dart';
import 'package:logger/logger.dart';

import '../utils/map/map_global_offset.dart';

class KmoniMapController extends StateNotifier<KmoniMapModel> {
  KmoniMapController()
      : super(
          KmoniMapModel(
            isMapLoaded: false,
            mapPolygons: [],
            mapMatrix4: Matrix4.identity(),
            mapOutlineStrokeWidth: 0.1,
            mapOutlineStrokeColor: Colors.black,
            mapFillColor: Colors.white,
            loadDuration: null,
          ),
        ) {
    onInit();
  }

  static const String japanMapFileName = 'assets/maps/japan_comp.json';
  static const String areaForecastLocalEFileName =
      'assets/maps/AreaForecastLocalE.json';
  static const String areaForecastLocalEewFileName =
      'assets/maps/AreaForecastLocalEew.json';

  final Logger logger = Logger(
    printer: PrettyPrinter(
      methodCount: 1,
      printTime: true,
    ),
  );
  late GeoJsonFeatureCollection japanMap;

  void onInit() {
    if (!state.isMapLoaded) {
      // マップを読み込み
      _loadJapanMap();
    }
  }

  Future<void> _loadJapanMap() async {
    final stopwatch = Stopwatch()..start();
    final geo = GeoJson();

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
            ),
          );
        }
      }
    });
    geo.endSignal.listen((_) {
      stopwatch.stop();
      logger.i('マップデータを読み込みました: ${stopwatch.elapsedMicroseconds / 1000}ms');
      if (mounted) {
        state = state.copyWith(
          isMapLoaded: true,
          mapPolygons: mapPaths,
          loadDuration: stopwatch.elapsed,
        );
      }
    });
    await geo.parse(
      await rootBundle.loadString('assets/maps/AreaForecastLocalE.json'),
    );
    return;
  }
}
