// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'unlink_account_request_body.freezed.dart';
part 'unlink_account_request_body.g.dart';

@Freezed()
abstract class UnlinkAccountRequestBody with _$UnlinkAccountRequestBody {
  const factory UnlinkAccountRequestBody({
    required String providerId,
    @JsonKey(includeIfNull: false)
    String? accountId,
  }) = _UnlinkAccountRequestBody;
  
  factory UnlinkAccountRequestBody.fromJson(Map<String, Object?> json) => _$UnlinkAccountRequestBodyFromJson(json);
}
