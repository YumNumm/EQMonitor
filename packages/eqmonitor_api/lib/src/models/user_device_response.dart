// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'locale.dart';
import 'type.dart';

part 'user_device_response.freezed.dart';
part 'user_device_response.g.dart';

@Freezed()
abstract class UserDeviceResponse with _$UserDeviceResponse {
  const factory UserDeviceResponse({
    required String id,
    required Type type,
    required Locale locale,
    @JsonKey(name: 'created_at') required String createdAt,
    @JsonKey(name: 'updated_at') required String updatedAt,
  }) = _UserDeviceResponse;

  factory UserDeviceResponse.fromJson(Map<String, Object?> json) =>
      _$UserDeviceResponseFromJson(json);
}
