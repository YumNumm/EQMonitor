// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'device_register_response.freezed.dart';
part 'device_register_response.g.dart';

@Freezed()
abstract class DeviceRegisterResponse with _$DeviceRegisterResponse {
  const factory DeviceRegisterResponse({
    required String deviceId,
    required String deviceToken,
    required dynamic expiresAt,
  }) = _DeviceRegisterResponse;
  
  factory DeviceRegisterResponse.fromJson(Map<String, Object?> json) => _$DeviceRegisterResponseFromJson(json);
}
