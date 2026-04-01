// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'location_payload.freezed.dart';
part 'location_payload.g.dart';

@Freezed()
abstract class LocationPayload with _$LocationPayload {
  const factory LocationPayload({
    required num latitude,
    required num longitude,
  }) = _LocationPayload;

  factory LocationPayload.fromJson(Map<String, Object?> json) =>
      _$LocationPayloadFromJson(json);
}
