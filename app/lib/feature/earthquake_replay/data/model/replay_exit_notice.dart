enum ReplayExitNotice(final String message) {
  eewIssued('緊急地震速報が発表されたため、現在の情報に戻りました'),
  archiveExpired('強震モニタで再生できる期間を過ぎたため、再生を終了しました'),
}
