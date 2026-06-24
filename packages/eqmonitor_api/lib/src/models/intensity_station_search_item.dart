// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'earthquake_partial.dart';
import 'jma_intensity.dart';

part 'intensity_station_search_item.freezed.dart';
part 'intensity_station_search_item.g.dart';

@Freezed()
abstract class IntensityStationSearchItem with _$IntensityStationSearchItem {
  const factory IntensityStationSearchItem({
    required JmaIntensity intensity,
    required EarthquakePartial earthquake,
  }) = _IntensityStationSearchItem;
  
  factory IntensityStationSearchItem.fromJson(Map<String, Object?> json) => _$IntensityStationSearchItemFromJson(json);
}
