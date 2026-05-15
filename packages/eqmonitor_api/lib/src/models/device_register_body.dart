// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'device_register_body.freezed.dart';
part 'device_register_body.g.dart';

@Freezed()
abstract class DeviceRegisterBody with _$DeviceRegisterBody {
  const factory DeviceRegisterBody({
    required dynamic type,
    @JsonKey(includeIfNull: true)
    @Default(ja)
    dynamic locale,
  }) = _DeviceRegisterBody;
  
  factory DeviceRegisterBody.fromJson(Map<String, Object?> json) => _$DeviceRegisterBodyFromJson(json);
}
