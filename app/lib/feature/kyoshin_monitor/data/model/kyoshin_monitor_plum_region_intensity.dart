/// PLUM 法で予測した、細分区域ごとの最大予測震度。
final class const KyoshinMonitorPlumRegionIntensity({
  required final String regionCode,
  required final String regionName,

  /// 予測震度（リアルタイム震度の値そのもの）
  required final double intensity,
});
