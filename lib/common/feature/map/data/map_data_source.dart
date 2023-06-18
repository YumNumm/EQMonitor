// ignore_for_file: avoid_catches_without_on_clauses, empty_catches


import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'map_data_source.g.dart';

@Riverpod(keepAlive: true)
MapLocalDataSource mapLocalDataSource(MapLocalDataSourceRef ref) =>
    MapLocalDataSource();

class MapLocalDataSource {
}
