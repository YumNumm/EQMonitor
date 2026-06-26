// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'changelog_bad_request_response.freezed.dart';
part 'changelog_bad_request_response.g.dart';

@Freezed()
abstract class ChangelogBadRequestResponse with _$ChangelogBadRequestResponse {
  const factory ChangelogBadRequestResponse({
    /// const: "BAD_REQUEST"
    required String code,
    required String message,
  }) = _ChangelogBadRequestResponse;
  
  factory ChangelogBadRequestResponse.fromJson(Map<String, Object?> json) => _$ChangelogBadRequestResponseFromJson(json);
}
