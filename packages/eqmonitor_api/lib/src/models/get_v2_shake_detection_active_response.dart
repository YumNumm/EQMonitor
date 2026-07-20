// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'events.dart';

part 'get_v2_shake_detection_active_response.freezed.dart';
part 'get_v2_shake_detection_active_response.g.dart';

@Freezed()
abstract class GetV2ShakeDetectionActiveResponse with _$GetV2ShakeDetectionActiveResponse {
  const factory GetV2ShakeDetectionActiveResponse({
    /// const: "shake_detection"
    required String type,
    required int revision,
    required DateTime responseAt,
    required List<Events> events,
  }) = _GetV2ShakeDetectionActiveResponse;

  factory GetV2ShakeDetectionActiveResponse.fromJson(Map<String, Object?> json) => _$GetV2ShakeDetectionActiveResponseFromJson(json);
}
