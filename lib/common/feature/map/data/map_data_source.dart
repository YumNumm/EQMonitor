import 'package:eqmonitor/common/feature/map/model/jma_map_property.dart';
import 'package:eqmonitor/common/feature/map/model/lat_lng.dart';
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
    });

    final bundleData = await rootBundle.loadString(path);
    await geo.parseInMainThread(bundleData);
    return data;
  }

  Future<List<MultiPolygonMapData<WorldMapProperty>>> loadWorldMap(
    String path,
  ) async {
    final geo = GeoJson();

    final data = <MultiPolygonMapData<WorldMapProperty>>[];

    geo.processedFeatures.listen((feature) {
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
            WorldMapProperty.fromJson(feature.properties!),
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
            WorldMapProperty.fromJson(feature.properties!),
          ),
        );
      }
    });

    final bundleData = await rootBundle.loadString(path);
    await geo.parseInMainThread(bundleData);
    return data;
  }
}
