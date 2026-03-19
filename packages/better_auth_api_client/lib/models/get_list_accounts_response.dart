// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_list_accounts_response.freezed.dart';
part 'get_list_accounts_response.g.dart';

@Freezed()
abstract class GetListAccountsResponse with _$GetListAccountsResponse {
  const factory GetListAccountsResponse({
    required String id,
    required String providerId,
    required DateTime createdAt,
    required DateTime updatedAt,
    required String accountId,
    required String userId,
    required List<String> scopes,
  }) = _GetListAccountsResponse;
  
  factory GetListAccountsResponse.fromJson(Map<String, Object?> json) => _$GetListAccountsResponseFromJson(json);
}
