// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_user_request_body.freezed.dart';
part 'update_user_request_body.g.dart';

@Freezed()
abstract class UpdateUserRequestBody with _$UpdateUserRequestBody {
  const factory UpdateUserRequestBody({
    /// The name of the user
    required String name,

    /// The image of the user
    @JsonKey(includeIfNull: false)
    String? image,
  }) = _UpdateUserRequestBody;
  
  factory UpdateUserRequestBody.fromJson(Map<String, Object?> json) => _$UpdateUserRequestBodyFromJson(json);
}
