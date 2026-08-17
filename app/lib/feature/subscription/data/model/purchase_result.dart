import 'package:eqmonitor/feature/subscription/data/model/purchase_failure_reason.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'purchase_result.freezed.dart';

/// 課金フローの結果。UI 側のスナックバー / ダイアログ分岐に使う。
@Freezed()
sealed class PurchaseResult with _$PurchaseResult {
  const factory success() = PurchaseResultSuccess;
  const factory cancelled() = PurchaseResultCancelled;
  const factory failed(PurchaseFailureReason reason) =
      PurchaseResultFailed;
}
