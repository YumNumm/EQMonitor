// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'message2.dart';

part 'post_delete_user_response.freezed.dart';
part 'post_delete_user_response.g.dart';

@Freezed()
abstract class PostDeleteUserResponse with _$PostDeleteUserResponse {
  const factory PostDeleteUserResponse({
    /// Indicates if the operation was successful
    required bool success,

    /// Status message of the deletion process
    required Message2 message,
  }) = _PostDeleteUserResponse;
  
  factory PostDeleteUserResponse.fromJson(Map<String, Object?> json) => _$PostDeleteUserResponseFromJson(json);
}
