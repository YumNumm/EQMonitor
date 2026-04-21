// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'device_locale.dart';
import 'device_type.dart';

part 'device_upsert_request.freezed.dart';
part 'device_upsert_request.g.dart';

@Freezed()
abstract class DeviceUpsertRequest with _$DeviceUpsertRequest {
  const factory DeviceUpsertRequest({
    required DeviceType type,
    @JsonKey(includeIfNull: false)
    DeviceLocale? locale,
  }) = _DeviceUpsertRequest;
  
  factory DeviceUpsertRequest.fromJson(Map<String, Object?> json) => _$DeviceUpsertRequestFromJson(json);
}
