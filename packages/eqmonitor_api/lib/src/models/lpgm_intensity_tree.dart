// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'intensity_station_item.dart';
import 'jma_lpgm_intensity.dart';
import 'lpgm_intensity_tree_region_id.dart';

part 'lpgm_intensity_tree.freezed.dart';
part 'lpgm_intensity_tree.g.dart';

@Freezed()
abstract class LpgmIntensityTree with _$LpgmIntensityTree {
  const factory LpgmIntensityTree({
    @JsonKey(name: 'lpgm_intensity')
    required JmaLpgmIntensity lpgmIntensity,
    required List<LpgmIntensityTreeRegionId> regions,
    required List<IntensityStationItem> stations,
  }) = _LpgmIntensityTree;
  
  factory LpgmIntensityTree.fromJson(Map<String, Object?> json) => _$LpgmIntensityTreeFromJson(json);
}
