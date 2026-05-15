// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'v2_device_me_apns_kind_request_body.freezed.dart';
part 'v2_device_me_apns_kind_request_body.g.dart';

@Freezed()
abstract class V2DeviceMeApnsKindRequestBody with _$V2DeviceMeApnsKindRequestBody {
  const factory V2DeviceMeApnsKindRequestBody({
    required String token,
  }) = _V2DeviceMeApnsKindRequestBody;
  
  factory V2DeviceMeApnsKindRequestBody.fromJson(Map<String, Object?> json) => _$V2DeviceMeApnsKindRequestBodyFromJson(json);
}
