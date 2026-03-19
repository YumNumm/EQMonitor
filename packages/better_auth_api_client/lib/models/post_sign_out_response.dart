// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_sign_out_response.freezed.dart';
part 'post_sign_out_response.g.dart';

@Freezed()
abstract class PostSignOutResponse with _$PostSignOutResponse {
  const factory PostSignOutResponse({
    required bool success,
  }) = _PostSignOutResponse;
  
  factory PostSignOutResponse.fromJson(Map<String, Object?> json) => _$PostSignOutResponseFromJson(json);
}
