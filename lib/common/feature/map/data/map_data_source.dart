// ignore_for_file: avoid_catches_without_on_clauses, empty_catches

import 'package:eqapi_schema/model/lat_lng.dart';
import 'package:eqmonitor/common/feature/map/data/model/jma_map_property.dart';
import 'package:eqmonitor/common/feature/map/data/model/map_polygon.dart';
import 'package:eqmonitor/common/feature/map/data/model/world_map_property.dart';
import 'package:flutter/services.dart';
import 'package:geojson/geojson.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'map_data_source.g.dart';

@Riverpod(keepAlive: true)
MapLocalDataSource mapLocalDataSource(MapLocalDataSourceRef ref) =>
    MapLocalDataSource();

class MapLocalDataSource {
Future<Map<LandLayerType>>
}
