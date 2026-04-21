// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'earthquake_partial.dart';
import 'intensity_region_info.dart';

part 'intensity_city_search_item.freezed.dart';
part 'intensity_city_search_item.g.dart';

@Freezed()
abstract class IntensityCitySearchItem with _$IntensityCitySearchItem {
  const factory IntensityCitySearchItem({
    @JsonKey(name: 'event_id')
    required String eventId,
    required IntensityRegionInfo city,
    required EarthquakePartial earthquake,
  }) = _IntensityCitySearchItem;
  
  factory IntensityCitySearchItem.fromJson(Map<String, Object?> json) => _$IntensityCitySearchItemFromJson(json);
}
