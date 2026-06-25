// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'subscription_active_response.freezed.dart';
part 'subscription_active_response.g.dart';

@Freezed()
abstract class SubscriptionActiveResponse with _$SubscriptionActiveResponse {
  const factory SubscriptionActiveResponse({
    required String status,
    required String productId,
    @JsonKey(includeIfNull: true)
    required DateTime? expiresAt,
    required bool willRenew,
  }) = _SubscriptionActiveResponse;
  
  factory SubscriptionActiveResponse.fromJson(Map<String, Object?> json) => _$SubscriptionActiveResponseFromJson(json);
}
