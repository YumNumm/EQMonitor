// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

import 'status.dart';

part 'get_v2_subscription_me_response_union.freezed.dart';
part 'get_v2_subscription_me_response_union.g.dart';

@Freezed()
sealed class GetV2SubscriptionMeResponseUnion with _$GetV2SubscriptionMeResponseUnion {
  @JsonSerializable()
  const factory GetV2SubscriptionMeResponseUnion.subscriptionActiveResponse({
    /// const: "ACTIVE" | const: "GRACE_PERIOD"
    required Status status,
    required String productId,
    @JsonKey(includeIfNull: true)
    required DateTime? expiresAt,
    required bool willRenew,
  }) = GetV2SubscriptionMeResponseUnionSubscriptionActiveResponse;
  
  @JsonSerializable()
  const factory GetV2SubscriptionMeResponseUnion.subscriptionInactiveResponse({
    /// const: "INACTIVE"
    required String status,
  }) = GetV2SubscriptionMeResponseUnionSubscriptionInactiveResponse;
  

  factory GetV2SubscriptionMeResponseUnion.fromJson(Map<String, Object?> json) =>
      switch (json['status']) {
        'ACTIVE' || 'GRACE_PERIOD' =>
          GetV2SubscriptionMeResponseUnionSubscriptionActiveResponse.fromJson(json),
        'INACTIVE' =>
          GetV2SubscriptionMeResponseUnionSubscriptionInactiveResponse.fromJson(json),
        final value => throw ArgumentError.value(
          value,
          'status',
          'Unknown subscription status',
        ),
      };

}
