// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'nationwide_interruption_level.dart';
import 'target.dart';

part 'eew_warning_config_request.freezed.dart';
part 'eew_warning_config_request.g.dart';

@Freezed()
abstract class EewWarningConfigRequest with _$EewWarningConfigRequest {
  const factory EewWarningConfigRequest({
    @JsonKey(includeIfNull: false)
    Target? target,
    @JsonKey(includeIfNull: false,name: 'nationwide_interruption_level')
    NationwideInterruptionLevel? nationwideInterruptionLevel,
  }) = _EewWarningConfigRequest;
  
  factory EewWarningConfigRequest.fromJson(Map<String, Object?> json) => _$EewWarningConfigRequestFromJson(json);
}
