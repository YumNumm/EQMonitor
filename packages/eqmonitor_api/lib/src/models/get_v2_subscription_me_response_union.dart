// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_v2_subscription_me_response_union.freezed.dart';
part 'get_v2_subscription_me_response_union.g.dart';

@Freezed()
sealed class GetV2SubscriptionMeResponseUnion
    with _$GetV2SubscriptionMeResponseUnion {
  @JsonSerializable()
  const factory GetV2SubscriptionMeResponseUnion.subscriptionActiveResponse({
    required dynamic status,
    required String productId,
    @JsonKey(includeIfNull: true) required DateTime? expiresAt,
    required bool willRenew,
  }) = GetV2SubscriptionMeResponseUnionSubscriptionActiveResponse;

  @JsonSerializable()
  const factory GetV2SubscriptionMeResponseUnion.subscriptionInactiveResponse({
    required dynamic status,
  }) = GetV2SubscriptionMeResponseUnionSubscriptionInactiveResponse;

  factory GetV2SubscriptionMeResponseUnion.fromJson(
    Map<String, Object?> json,
  ) =>
      // TODO: No discriminator in OpenAPI spec - you must implement this manually.
      //
      // Inspect the JSON and return the matching variant. Each variant has a fromJson:
      //   GetV2SubscriptionMeResponseUnionVariantName.fromJson(json)
      //
      // Example pattern (check for unique fields):
      //   json.containsKey('uniqueFieldA') ? GetV2SubscriptionMeResponseUnionTypeA.fromJson(json) :
      //   json.containsKey('uniqueFieldB') ? GetV2SubscriptionMeResponseUnionTypeB.fromJson(json) :
      //   GetV2SubscriptionMeResponseUnionDefault.fromJson(json);
      //
      // IMPORTANT: Keep the => arrow syntax. Converting to a { } body will cause
      // freezed to skip generating toJson/fromJson for this class.
      throw UnimplementedError();
}
