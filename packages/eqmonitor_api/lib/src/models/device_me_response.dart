// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'device_locale.dart';
import 'device_registration_type.dart';
import 'device_type.dart';

part 'device_me_response.freezed.dart';
part 'device_me_response.g.dart';

@Freezed()
abstract class DeviceMeResponse with _$DeviceMeResponse {
  const factory DeviceMeResponse({
    required String id,
    required DeviceType type,
    required DeviceLocale locale,
    @JsonKey(includeIfNull: true)
    required DeviceRegistrationType? registrationType,
    @JsonKey(includeIfNull: true)
    required String? userId,
    @JsonKey(name: 'is_pro')
    required bool isPro,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _DeviceMeResponse;
  
  factory DeviceMeResponse.fromJson(Map<String, Object?> json) => _$DeviceMeResponseFromJson(json);
}
