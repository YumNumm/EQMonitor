// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'earthquake_min_intensity.dart';
import 'eew_min_intensity.dart';
import 'slot_override.dart';
import 'slot_type.dart';

part 'slot_response.freezed.dart';
part 'slot_response.g.dart';

@Freezed()
abstract class SlotResponse with _$SlotResponse {
  const factory SlotResponse({
    required String id,
    @JsonKey(name: 'slot_type')
    required SlotType slotType,
    @JsonKey(includeIfNull: true,name: 'region_id')
    required num? regionId,
    @JsonKey(includeIfNull: true,name: 'region_name')
    required String? regionName,
    @JsonKey(includeIfNull: true,name: 'city_code')
    required String? cityCode,
    @JsonKey(includeIfNull: true,name: 'city_name')
    required String? cityName,
    @JsonKey(name: 'display_order')
    required num displayOrder,
    @JsonKey(name: 'eew_enabled')
    required bool eewEnabled,
    @JsonKey(includeIfNull: true,name: 'eew_min_intensity')
    required EewMinIntensity? eewMinIntensity,
    @JsonKey(includeIfNull: true,name: 'eew_overrides')
    required List<SlotOverride>? eewOverrides,
    @JsonKey(name: 'earthquake_enabled')
    required bool earthquakeEnabled,
    @JsonKey(includeIfNull: true,name: 'earthquake_min_intensity')
    required EarthquakeMinIntensity? earthquakeMinIntensity,
    @JsonKey(includeIfNull: true,name: 'earthquake_overrides')
    required List<SlotOverride>? earthquakeOverrides,
    @JsonKey(name: 'created_at')
    required String createdAt,
    @JsonKey(name: 'updated_at')
    required String updatedAt,
  }) = _SlotResponse;
  
  factory SlotResponse.fromJson(Map<String, Object?> json) => _$SlotResponseFromJson(json);
}
