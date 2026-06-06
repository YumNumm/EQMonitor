// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'device_me_response.freezed.dart';
part 'device_me_response.g.dart';

@Freezed()
abstract class DeviceMeResponse with _$DeviceMeResponse {
  const factory DeviceMeResponse({
    required String id,
    required dynamic type,
    required dynamic registrationType,
    @JsonKey(includeIfNull: true)
    required String? userId,
    required DateTime createdAt,
    required DateTime updatedAt,
    @JsonKey(includeIfNull: true)
    @Default('ja')
    String? locale,
  }) = _DeviceMeResponse;
  
  factory DeviceMeResponse.fromJson(Map<String, Object?> json) => _$DeviceMeResponseFromJson(json);
}
