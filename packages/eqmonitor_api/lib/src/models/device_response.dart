// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'locale.dart';
import 'type.dart';

part 'device_response.freezed.dart';
part 'device_response.g.dart';

@Freezed()
abstract class DeviceResponse with _$DeviceResponse {
  const factory DeviceResponse({
    required String id,
    required Type type,
    @JsonKey(includeIfNull: true, name: 'user_id') required String? userId,
    required Locale locale,
    @JsonKey(name: 'created_at') required String createdAt,
    @JsonKey(name: 'updated_at') required String updatedAt,
  }) = _DeviceResponse;

  factory DeviceResponse.fromJson(Map<String, Object?> json) =>
      _$DeviceResponseFromJson(json);
}
