import 'package:freezed_annotation/freezed_annotation.dart';

part 'subscription_status.freezed.dart';

/// サブスクリプションの状態を表す
@freezed
sealed class SubscriptionStatus with _$SubscriptionStatus {
  const factory SubscriptionStatus.active({
    required String productId,
    DateTime? expiresAt,
    @Default(true) bool willRenew,
  }) = SubscriptionStatusActive;

  const factory SubscriptionStatus.inactive() = SubscriptionStatusInactive;
}
