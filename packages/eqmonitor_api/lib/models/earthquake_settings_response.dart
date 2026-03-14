// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'sound_settings_response.dart';

part 'earthquake_settings_response.freezed.dart';
part 'earthquake_settings_response.g.dart';

@Freezed()
abstract class EarthquakeSettingsResponse with _$EarthquakeSettingsResponse {
  const factory EarthquakeSettingsResponse({
    required bool enabled,
    required SoundSettingsResponse sound,
    @JsonKey(name: 'hypocenter_update_enabled')
    required bool hypocenterUpdateEnabled,
    @JsonKey(name: 'estimated_intensity_enabled')
    required bool estimatedIntensityEnabled,
  }) = _EarthquakeSettingsResponse;
  
  factory EarthquakeSettingsResponse.fromJson(Map<String, Object?> json) => _$EarthquakeSettingsResponseFromJson(json);
}
