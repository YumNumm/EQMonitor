// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

@JsonEnum()
enum SoundSettingsMode {
  @JsonValue('max_intensity')
  maxIntensity('max_intensity'),
  @JsonValue('location_intensity')
  locationIntensity('location_intensity'),
  @JsonValue('registered_max')
  registeredMax('registered_max');

  const SoundSettingsMode(this.json);

  final dynamic json;

  dynamic toJson() => json;

  @override
  String toString() => json?.toString() ?? super.toString();
}
