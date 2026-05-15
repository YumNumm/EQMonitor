import 'package:freezed_annotation/freezed_annotation.dart';

part 'purchase_result.freezed.dart';

/// 課金フローの結果。UI 側のスナックバー / ダイアログ分岐に使う。
///
/// 本実装は別 PR (#12) で `purchases_flutter` 統合とあわせて差し替えられる。
@Freezed()
sealed class PurchaseResult with _$PurchaseResult {
  const factory PurchaseResult.success() = PurchaseResultSuccess;
  const factory PurchaseResult.cancelled() = PurchaseResultCancelled;
  const factory PurchaseResult.failed(String message) = PurchaseResultFailed;
  const factory PurchaseResult.unavailable(String reason) =
      PurchaseResultUnavailable;
}
