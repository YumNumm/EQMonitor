// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'location_payload.dart';

part 'observation_point_payload.freezed.dart';
part 'observation_point_payload.g.dart';

@Freezed()
abstract class ObservationPointPayload with _$ObservationPointPayload {
  const factory ObservationPointPayload({
    required String code,
    required String name,
    required String region,
    required String type,
    required LocationPayload location,
    @JsonKey(includeIfNull: true) required num? intensity,
    required num intensityDiff,
  }) = _ObservationPointPayload;

  factory ObservationPointPayload.fromJson(Map<String, Object?> json) =>
      _$ObservationPointPayloadFromJson(json);
}
