import 'package:freezed_annotation/freezed_annotation.dart';

part 'subscription_status.freezed.dart';

enum SubscriptionSyncPhase {
  idle,
  pending,
  synchronizing,
  failed,
  authenticationRequired,
}

/// バックエンドで確認した利用権限と同期状態。SDK状態だけではProを付与しない。
@freezed
sealed class SubscriptionStatus with _$SubscriptionStatus {
  const factory active({
    required String productId,
    DateTime? expiresAt,
    @Default(true) bool willRenew,
    @Default(SubscriptionSyncPhase.idle) SubscriptionSyncPhase syncPhase,
  }) = SubscriptionStatusActive;

  const factory inactive({
    @Default(SubscriptionSyncPhase.idle) SubscriptionSyncPhase syncPhase,
  }) = SubscriptionStatusInactive;
}
