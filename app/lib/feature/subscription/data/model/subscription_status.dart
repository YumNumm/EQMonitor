import 'package:freezed_annotation/freezed_annotation.dart';

part 'subscription_status.freezed.dart';

/// サブスクリプションの状態を表すモデル。
///
/// 本実装は別 PR (#12) で `purchases_flutter` 統合とあわせて差し替えられる。
/// UI 側はこの型に依存する。
@Freezed()
sealed class SubscriptionStatus with _$SubscriptionStatus {
  const factory SubscriptionStatus.active({
    required String productId,
    DateTime? expiresAt,
    @Default(true) bool willRenew,
  }) = SubscriptionStatusActive;

  const factory SubscriptionStatus.inactive() = SubscriptionStatusInactive;
}
