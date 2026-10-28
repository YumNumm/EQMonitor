// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'device_locale.dart';

part 'device_locale_update_request.freezed.dart';
part 'device_locale_update_request.g.dart';

@Freezed()
abstract class DeviceLocaleUpdateRequest with _$DeviceLocaleUpdateRequest {
  const factory DeviceLocaleUpdateRequest({
    required DeviceLocale locale,
  }) = _DeviceLocaleUpdateRequest;

  factory DeviceLocaleUpdateRequest.fromJson(Map<String, Object?> json) => _$DeviceLocaleUpdateRequestFromJson(json);
}
