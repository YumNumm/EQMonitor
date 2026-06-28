// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'interruption_level.dart';
import 'min_jma_intensity.dart';

part 'slot_override.freezed.dart';
part 'slot_override.g.dart';

@Freezed()
abstract class SlotOverride with _$SlotOverride {
  const factory SlotOverride({
    @JsonKey(name: 'min_jma_intensity')
    required MinJmaIntensity minJmaIntensity,
    required String sound,
    @JsonKey(name: 'interruption_level')
    required InterruptionLevel interruptionLevel,
  }) = _SlotOverride;
  
  factory SlotOverride.fromJson(Map<String, Object?> json) => _$SlotOverrideFromJson(json);
}
