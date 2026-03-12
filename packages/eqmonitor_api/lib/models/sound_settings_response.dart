// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'intensity_sound_mode.dart';

part 'sound_settings_response.freezed.dart';
part 'sound_settings_response.g.dart';

@Freezed()
abstract class SoundSettingsResponse with _$SoundSettingsResponse {
  const factory SoundSettingsResponse({
    required IntensitySoundMode mode,
    @JsonKey(includeIfNull: true)
    required Map<String, String>? map,
  }) = _SoundSettingsResponse;
  
  factory SoundSettingsResponse.fromJson(Map<String, Object?> json) => _$SoundSettingsResponseFromJson(json);
}
