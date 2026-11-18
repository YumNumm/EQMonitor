enum ShakeEventLevel {
  weaker,
  weak,
  medium,
  strong,
  stronger;

  /// 震度階級の境界に合わせる。
  ///
  /// 微弱: 震度1未満、弱い: 震度1〜2、やや強い: 震度3〜4、
  /// 強い: 震度5弱〜5強、非常に強い: 震度6弱以上。
  factory fromIntensity(double? intensity) {
    if (intensity == null) {
      return weaker;
    }
    if (intensity >= 5.5) {
      return stronger;
    }
    if (intensity >= 4.5) {
      return strong;
    }
    if (intensity >= 2.5) {
      return medium;
    }
    if (intensity >= 0.5) {
      return weak;
    }
    return weaker;
  }
}
