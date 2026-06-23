// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'subscription_inactive_response.freezed.dart';
part 'subscription_inactive_response.g.dart';

@Freezed()
abstract class SubscriptionInactiveResponse
    with _$SubscriptionInactiveResponse {
  const factory SubscriptionInactiveResponse({
    required dynamic status,
  }) = _SubscriptionInactiveResponse;

  factory SubscriptionInactiveResponse.fromJson(Map<String, Object?> json) =>
      _$SubscriptionInactiveResponseFromJson(json);
}
