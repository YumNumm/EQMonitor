import 'package:eqmonitor/feature/subscription/data/model/purchase_result.dart';
import 'package:eqmonitor/feature/subscription/data/model/subscription_status.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'purchase_outcome.freezed.dart';

@Freezed()
abstract class PurchaseOutcome with _$PurchaseOutcome {
  const factory PurchaseOutcome({
    required PurchaseResult result,
    SubscriptionStatus? status,
  }) = _PurchaseOutcome;
}
