// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_unlink_account_response.freezed.dart';
part 'post_unlink_account_response.g.dart';

@Freezed()
abstract class PostUnlinkAccountResponse with _$PostUnlinkAccountResponse {
  const factory PostUnlinkAccountResponse({
    required bool status,
  }) = _PostUnlinkAccountResponse;
  
  factory PostUnlinkAccountResponse.fromJson(Map<String, Object?> json) => _$PostUnlinkAccountResponseFromJson(json);
}
