// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'verify_password_request_body.freezed.dart';
part 'verify_password_request_body.g.dart';

@Freezed()
abstract class VerifyPasswordRequestBody with _$VerifyPasswordRequestBody {
  const factory VerifyPasswordRequestBody({
    /// The password to verify
    required String password,
  }) = _VerifyPasswordRequestBody;
  
  factory VerifyPasswordRequestBody.fromJson(Map<String, Object?> json) => _$VerifyPasswordRequestBodyFromJson(json);
}
