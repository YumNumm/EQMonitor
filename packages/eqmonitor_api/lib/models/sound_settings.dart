// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'sound_settings_mode.dart';

part 'sound_settings.freezed.dart';
part 'sound_settings.g.dart';

@Freezed()
abstract class SoundSettings with _$SoundSettings {
  const factory SoundSettings({
    required SoundSettingsMode mode,
    @JsonKey(includeIfNull: false) Map<String, String>? map,
  }) = _SoundSettings;

  factory SoundSettings.fromJson(Map<String, Object?> json) =>
      _$SoundSettingsFromJson(json);
}
