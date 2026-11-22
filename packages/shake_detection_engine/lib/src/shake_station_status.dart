enum ShakeStationStatus {
  observed,

  /// 周囲とかけ離れた高い値が続いており、検知から除外している。
  outlier,

  /// 直近の履歴には観測値があるが、最新のフレームでは欠測している。
  lost,
  absent,
}
