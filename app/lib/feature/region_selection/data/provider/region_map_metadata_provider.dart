import 'package:eqmonitor/feature/region_selection/data/model/region_map_metadata.dart';
import 'package:eqmonitor/feature/region_selection/data/repository/region_map_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'region_map_metadata_provider.g.dart';

@riverpod
Future<RegionMapMetadata> regionMapMetadata(Ref ref) =>
    ref.watch(regionMapRepositoryProvider).metadata();
