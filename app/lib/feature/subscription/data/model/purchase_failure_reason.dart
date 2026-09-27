enum PurchaseFailureReason {
  operationInProgress,
  planNotFound,
  activationNotConfirmed,
  revenueCatConfiguration,
  purchaseFailed,
  restoreNotFound,
  restoreFailed,
}

extension PurchaseFailureReasonMessage on PurchaseFailureReason {
  String get message => switch (this) {
    PurchaseFailureReason.operationInProgress => '購入または復元の処理が進行中です',
    PurchaseFailureReason.planNotFound => 'プラン情報を取得できませんでした',
    PurchaseFailureReason.activationNotConfirmed =>
      '購入は完了しましたが、Pro プランの有効化を確認できませんでした',
    PurchaseFailureReason.revenueCatConfiguration => '現在この機能はご利用いただけません',
    PurchaseFailureReason.purchaseFailed => '購入に失敗しました',
    PurchaseFailureReason.restoreNotFound => '復元できる購入が見つかりませんでした',
    PurchaseFailureReason.restoreFailed => '購入の復元に失敗しました',
  };
}
