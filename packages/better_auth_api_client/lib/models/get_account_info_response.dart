// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'user4.dart';

part 'get_account_info_response.freezed.dart';
part 'get_account_info_response.g.dart';

@Freezed()
abstract class GetAccountInfoResponse with _$GetAccountInfoResponse {
  const factory GetAccountInfoResponse({
    required User4 user,
    required dynamic data,
  }) = _GetAccountInfoResponse;
  
  factory GetAccountInfoResponse.fromJson(Map<String, Object?> json) => _$GetAccountInfoResponseFromJson(json);
}
