// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'location_payload.dart';

part 'region_payload.freezed.dart';
part 'region_payload.g.dart';

@Freezed()
abstract class RegionPayload with _$RegionPayload {
  const factory RegionPayload({
    required LocationPayload topLeft,
    required LocationPayload bottomRight,
  }) = _RegionPayload;

  factory RegionPayload.fromJson(Map<String, Object?> json) =>
      _$RegionPayloadFromJson(json);
}
