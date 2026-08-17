// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'jma_intensity.dart';
import 'slot_override.dart';
import 'slot_type.dart';

part 'replace_slot_entry.freezed.dart';
part 'replace_slot_entry.g.dart';

@Freezed()
abstract class ReplaceSlotEntry with _$ReplaceSlotEntry {
  const factory ReplaceSlotEntry({
    @JsonKey(name: 'slot_type')
    required SlotType slotType,
    @JsonKey(includeIfNull: false,name: 'region_id')
    num? regionId,
    @JsonKey(includeIfNull: false,name: 'region_name')
    String? regionName,
    @JsonKey(includeIfNull: false,name: 'city_code')
    String? cityCode,
    @JsonKey(includeIfNull: false,name: 'city_name')
    String? cityName,
    @JsonKey(includeIfNull: false,name: 'display_order')
    num? displayOrder,
    @JsonKey(includeIfNull: false,name: 'eew_enabled')
    bool? eewEnabled,
    @JsonKey(includeIfNull: false,name: 'eew_min_intensity')
    JmaIntensity? eewMinIntensity,
    @JsonKey(includeIfNull: false,name: 'eew_overrides')
    List<SlotOverride>? eewOverrides,
    @JsonKey(includeIfNull: false,name: 'earthquake_enabled')
    bool? earthquakeEnabled,
    @JsonKey(includeIfNull: false,name: 'earthquake_min_intensity')
    JmaIntensity? earthquakeMinIntensity,
    @JsonKey(includeIfNull: false,name: 'earthquake_overrides')
    List<SlotOverride>? earthquakeOverrides,
  }) = _ReplaceSlotEntry;
  
  factory ReplaceSlotEntry.fromJson(Map<String, Object?> json) => _$ReplaceSlotEntryFromJson(json);
}
