// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'shake_detection_level.dart';
import 'shake_detection_target_type.dart';

part 'shake_detection_setting_response.freezed.dart';
part 'shake_detection_setting_response.g.dart';

@Freezed()
abstract class ShakeDetectionSettingResponse with _$ShakeDetectionSettingResponse {
  const factory ShakeDetectionSettingResponse({
    required String id,
    @JsonKey(name: 'target_type')
    required ShakeDetectionTargetType targetType,
    @JsonKey(includeIfNull: true,name: 'region_code')
    required String? regionCode,
    required bool enabled,
    @JsonKey(name: 'min_level')
    required ShakeDetectionLevel minLevel,
    @JsonKey(name: 'created_at')
    required String createdAt,
    @JsonKey(name: 'updated_at')
    required String updatedAt,
  }) = _ShakeDetectionSettingResponse;
  
  factory ShakeDetectionSettingResponse.fromJson(Map<String, Object?> json) => _$ShakeDetectionSettingResponseFromJson(json);
}
