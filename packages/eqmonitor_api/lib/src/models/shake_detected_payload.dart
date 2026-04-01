// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'observation_point_payload.dart';
import 'region_payload.dart';
import 'shake_detection_level.dart';

part 'shake_detected_payload.freezed.dart';
part 'shake_detected_payload.g.dart';

@Freezed()
abstract class ShakeDetectedPayload with _$ShakeDetectedPayload {
  const factory ShakeDetectedPayload({
    required dynamic type,
    required String eventId,
    required String createdAt,
    required ShakeDetectionLevel level,
    required List<String> changeReasons,
    required bool isReplay,
    required num pointCount,
    required RegionPayload region,
    required List<ObservationPointPayload> points,
  }) = _ShakeDetectedPayload;
  
  factory ShakeDetectedPayload.fromJson(Map<String, Object?> json) => _$ShakeDetectedPayloadFromJson(json);
}
