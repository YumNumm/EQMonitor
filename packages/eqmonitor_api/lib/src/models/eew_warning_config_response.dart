// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'current_location_interruption_level.dart';
import 'nationwide_interruption_level.dart';
import 'target.dart';

part 'eew_warning_config_response.freezed.dart';
part 'eew_warning_config_response.g.dart';

@Freezed()
abstract class EewWarningConfigResponse with _$EewWarningConfigResponse {
  const factory EewWarningConfigResponse({
    required Target target,
    @JsonKey(name: 'current_location_interruption_level')
    required CurrentLocationInterruptionLevel currentLocationInterruptionLevel,
    @JsonKey(includeIfNull: true,name: 'nationwide_interruption_level')
    required NationwideInterruptionLevel? nationwideInterruptionLevel,
  }) = _EewWarningConfigResponse;
  
  factory EewWarningConfigResponse.fromJson(Map<String, Object?> json) => _$EewWarningConfigResponseFromJson(json);
}
