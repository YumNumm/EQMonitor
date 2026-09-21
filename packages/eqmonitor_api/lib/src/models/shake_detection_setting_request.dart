// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'shake_detection_level.dart';
import 'shake_detection_target_type.dart';

part 'shake_detection_setting_request.freezed.dart';
part 'shake_detection_setting_request.g.dart';

@Freezed()
abstract class ShakeDetectionSettingRequest with _$ShakeDetectionSettingRequest {
  const factory ShakeDetectionSettingRequest({
    @JsonKey(name: 'target_type')
    required ShakeDetectionTargetType targetType,
    @JsonKey(includeIfNull: true,name: 'region_code')
    required String? regionCode,
    required bool enabled,
    @JsonKey(name: 'min_level')
    required ShakeDetectionLevel minLevel,
  }) = _ShakeDetectionSettingRequest;
  
  factory ShakeDetectionSettingRequest.fromJson(Map<String, Object?> json) => _$ShakeDetectionSettingRequestFromJson(json);
}
