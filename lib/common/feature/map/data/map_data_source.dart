// ignore_for_file: avoid_catches_without_on_clauses, empty_catches

import 'package:eqapi_schema/model/lat_lng.dart';
import 'package:eqmonitor/common/feature/map/model/jma_map_property.dart';
import 'package:eqmonitor/common/feature/map/model/map_polygon.dart';
import 'package:eqmonitor/common/feature/map/model/world_map_property.dart';
import 'package:flutter/services.dart';
import 'package:geojson/geojson.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'map_data_source.g.dart';

@Riverpod(keepAlive: true)
MapLocalDataSource mapLocalDataSource(MapLocalDataSourceRef ref) =>
    MapLocalDataSource();

class MapLocalDataSource {
  Future<List<MultiPolygonMapData<JmaMapProperty>>> loadJmaMap(
    String path,
  ) async {
    final geo = GeoJson();

    final data = <MultiPolygonMapData<JmaMapProperty>>[];

    geo.processedFeatures.listen((feature) {
      try {
        if (feature.type == GeoJsonFeatureType.multipolygon) {
          final geometry = feature.geometry as GeoJsonMultiPolygon;
          if (feature.properties == null) {
            return;
          }
          final polygons = <MapPolygon>[];
          for (final polygon in geometry.polygons) {
            if (!(feature.properties?.containsKey('code') ?? false)) {
              continue;
            }
            final points = <LatLng>[];
            for (final geoSeries in polygon.geoSeries) {
              for (final e in geoSeries.geoPoints) {
                points.add(LatLng(e.latitude, e.longitude));
              }
            }
            polygons.add(MapPolygon.fromList(points));
          }
          data.add(
            MultiPolygonMapData.fromList(
              polygons,
              JmaMapProperty.fromJson(feature.properties!),
            ),
          );
        }
        if (feature.type == GeoJsonFeatureType.polygon) {
          final polygon = feature.geometry as GeoJsonPolygon;
          final polygons = <MapPolygon>[];
          if (!(feature.properties?.containsKey('code') ?? false)) {
            return;
          }
          final points = <LatLng>[];
          for (final geoSeries in polygon.geoSeries) {
            for (final e in geoSeries.geoPoints) {
              points.add(LatLng(e.latitude, e.longitude));
            }
          }
          polygons.add(MapPolygon.fromList(points));
          data.add(
            MultiPolygonMapData.fromList(
              polygons,
              JmaMapProperty.fromJson(feature.properties!),
            ),
          );
        }
      } catch (e) {}
    });

    final bundleData = await rootBundle.loadString(path);
    await geo.parse(bundleData);
    return data;
  }

  Future<List<MultiLineMapData<JmaMapProperty>>> loadTsunamiMapData(
    String path,
  ) async {
    final geo = GeoJson();

    final data = <MultiLineMapData<JmaMapProperty>>[];

    geo.processedFeatures.listen((feature) {
      try {
        if (feature.type == GeoJsonFeatureType.multiline) {
          final geometry = feature.geometry as GeoJsonMultiLine;
          if (feature.properties == null) {
            return;
          }
          final lines = <MapPolyline>[];
          for (final line in geometry.lines) {
            if (!(feature.properties?.containsKey('code') ?? false)) {
              continue;
            }
            final points = <LatLng>[];
            final geoSerie = line.geoSerie;
            if (geoSerie == null) {
              continue;
            }
            for (final e in geoSerie.geoPoints) {
              points.add(LatLng(e.latitude, e.longitude));
            }
            lines.add(MapPolyline.fromList(points));
          }
          data.add(
            MultiLineMapData.fromList(
              lines,
              JmaMapProperty.fromJson(feature.properties!),
            ),
          );
        }
        if (feature.type == GeoJsonFeatureType.line) {
          final geometry = feature.geometry as GeoJsonLine;
          if (feature.properties == null) {
            return;
          }
          final lines = <MapPolyline>[];
          if (!(feature.properties?.containsKey('code') ?? false)) {
            return;
          }
          final points = <LatLng>[];
          final geoSerie = geometry.geoSerie;
          if (geoSerie == null) {
            return;
          }
          for (final e in geoSerie.geoPoints) {
            points.add(LatLng(e.latitude, e.longitude));
          }
          lines.add(MapPolyline.fromList(points));
          data.add(
            MultiLineMapData.fromList(
              lines,
              JmaMapProperty.fromJson(feature.properties!),
            ),
          );
        }
      } catch (e) {}
    });

    final bundleData = await rootBundle.loadString(path);
    await geo.parse(bundleData);
    return data;
  }

  Future<List<MultiPolygonMapData<WorldMapProperty>>> loadWorldMap(
    String path,
  ) async {
    final geo = GeoJson();

    final data = <MultiPolygonMapData<WorldMapProperty>>[];

    geo.processedFeatures.listen((feature) {
      try {
        if (feature.type == GeoJsonFeatureType.multipolygon) {
          final geometry = feature.geometry as GeoJsonMultiPolygon;
          if (feature.properties == null) {
            return;
          }
          final polygons = <MapPolygon>[];
          for (final polygon in geometry.polygons) {
            final points = <LatLng>[];
            for (final geoSeries in polygon.geoSeries) {
              for (final e in geoSeries.geoPoints) {
                points.add(LatLng(e.latitude, e.longitude));
              }
            }
            polygons.add(MapPolygon.fromList(points));
          }
          data.add(
            MultiPolygonMapData.fromList(
              polygons,
              WorldMapProperty.fromJson(feature.properties!),
            ),
          );
        }
        if (feature.type == GeoJsonFeatureType.polygon) {
          final polygon = feature.geometry as GeoJsonPolygon;
          final polygons = <MapPolygon>[];
          final points = <LatLng>[];
          for (final geoSeries in polygon.geoSeries) {
            for (final e in geoSeries.geoPoints) {
              points.add(LatLng(e.latitude, e.longitude));
            }
          }
          polygons.add(MapPolygon.fromList(points));
          data.add(
            MultiPolygonMapData.fromList(
              polygons,
              WorldMapProperty.fromJson(feature.properties!),
            ),
          );
        }
      } catch (_) {}
    });

    final bundleData = await rootBundle.loadString(path);
    await geo.parse(
      bundleData,
    );
    return data;
  }
}
