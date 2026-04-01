// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'earthquake_partial.dart';
import 'intensity_station_info.dart';

part 'intensity_station_search_item.freezed.dart';
part 'intensity_station_search_item.g.dart';

@Freezed()
abstract class IntensityStationSearchItem with _$IntensityStationSearchItem {
  const factory IntensityStationSearchItem({
    @JsonKey(name: 'event_id')
    required String eventId,
    required IntensityStationInfo station,
    required EarthquakePartial earthquake,
  }) = _IntensityStationSearchItem;
  
  factory IntensityStationSearchItem.fromJson(Map<String, Object?> json) => _$IntensityStationSearchItemFromJson(json);
}
