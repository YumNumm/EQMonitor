// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'shake_detection_level.dart';

part 'shake_detection_setting_response.freezed.dart';
part 'shake_detection_setting_response.g.dart';

@Freezed()
abstract class ShakeDetectionSettingResponse
    with _$ShakeDetectionSettingResponse {
  const factory ShakeDetectionSettingResponse({
    required String id,
    @JsonKey(includeIfNull: true, name: 'sub_region_id')
    required String? subRegionId,
    @JsonKey(name: 'min_level') required ShakeDetectionLevel minLevel,
    @JsonKey(name: 'is_current_location') required bool isCurrentLocation,
    @JsonKey(name: 'created_at') required String createdAt,
    @JsonKey(name: 'updated_at') required String updatedAt,
  }) = _ShakeDetectionSettingResponse;

  factory ShakeDetectionSettingResponse.fromJson(Map<String, Object?> json) =>
      _$ShakeDetectionSettingResponseFromJson(json);
}
