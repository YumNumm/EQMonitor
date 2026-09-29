enum PurchaseFailureReason {
  operationInProgress,
  planNotFound,
  activationNotConfirmed,
  revenueCatConfiguration,
  purchaseFailed,

  /// ストアでの支払いが保留中 (承認待ち・後払いなど)。失敗ではない。
  paymentPending,
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
    PurchaseFailureReason.paymentPending =>
      '支払いの完了を待っています。完了すると Pro プランが有効になります。再購入は不要です',
    PurchaseFailureReason.restoreNotFound => '復元できる購入が見つかりませんでした',
    PurchaseFailureReason.restoreFailed => '購入の復元に失敗しました',
  };
}
