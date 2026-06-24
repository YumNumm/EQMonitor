// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'intensity_tree_region_id.dart';
import 'intensity_tree_station_id.dart';
import 'jma_intensity.dart';

part 'intensity_tree.freezed.dart';
part 'intensity_tree.g.dart';

@Freezed()
abstract class IntensityTree with _$IntensityTree {
  const factory IntensityTree({
    required JmaIntensity intensity,
    required List<IntensityTreeRegionId> regions,
    @JsonKey(includeIfNull: false)
    List<IntensityTreeStationId>? stations,
  }) = _IntensityTree;
  
  factory IntensityTree.fromJson(Map<String, Object?> json) => _$IntensityTreeFromJson(json);
}
