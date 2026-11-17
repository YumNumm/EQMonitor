class const TestLiveActivityStatus({
  required final bool isSupported,
  required final bool isActive,

  /// テスト表示を自動で終了する時刻。表示中でなければ null。
  final DateTime? endsAt,
});
