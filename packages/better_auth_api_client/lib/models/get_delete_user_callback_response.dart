// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'message3.dart';

part 'get_delete_user_callback_response.freezed.dart';
part 'get_delete_user_callback_response.g.dart';

@Freezed()
abstract class GetDeleteUserCallbackResponse with _$GetDeleteUserCallbackResponse {
  const factory GetDeleteUserCallbackResponse({
    /// Indicates if the deletion was successful
    required bool success,

    /// Confirmation message
    required Message3 message,
  }) = _GetDeleteUserCallbackResponse;
  
  factory GetDeleteUserCallbackResponse.fromJson(Map<String, Object?> json) => _$GetDeleteUserCallbackResponseFromJson(json);
}
