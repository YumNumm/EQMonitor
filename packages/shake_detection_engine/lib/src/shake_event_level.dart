enum ShakeEventLevel {
  weaker,
  weak,
  medium,
  strong,
  stronger;

  /// 震度階級の境界に合わせる。
  ///
  /// 配信側の検知サービスと同じ境界にする。
  /// weaker: 震度0以下、weak: 震度1〜2、medium: 震度3、
  /// strong: 震度4〜5強、stronger: 震度6弱以上。
  factory fromIntensity(double? intensity) {
    if (intensity == null) {
      return weaker;
    }
    if (intensity >= 5.5) {
      return stronger;
    }
    if (intensity >= 3.5) {
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
