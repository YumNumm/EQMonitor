// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'v2_device_me_fcm_request_body.freezed.dart';
part 'v2_device_me_fcm_request_body.g.dart';

@Freezed()
abstract class V2DeviceMeFcmRequestBody with _$V2DeviceMeFcmRequestBody {
  const factory V2DeviceMeFcmRequestBody({
    required String token,
  }) = _V2DeviceMeFcmRequestBody;
  
  factory V2DeviceMeFcmRequestBody.fromJson(Map<String, Object?> json) => _$V2DeviceMeFcmRequestBodyFromJson(json);
}
