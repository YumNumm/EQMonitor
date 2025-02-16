/// 気象庁震度階級
enum JmaIntensity {
  /// 不明
  unknown(displayName: '不明', description: '不明', level: -1),

  /// 震度0
  zero(displayName: '0', description: '震度0', level: 0),

  /// 震度1
  one(displayName: '1', description: '震度1', level: 1),

  /// 震度2
  two(displayName: '2', description: '震度2', level: 2),

  /// 震度3
  three(displayName: '3', description: '震度3', level: 3),

  /// 震度4
  four(displayName: '4', description: '震度4', level: 4),

  /// 震度5弱
  fiveLower(
    displayName: '5-',
    description: '震度5弱',
    level: 5,
  ),

  /// 震度5強
  fiveUpper(
    displayName: '5+',
    description: '震度5強',
    level: 6,
  ),

  /// 震度6弱
  sixLower(
    displayName: '6-',
    description: '震度6弱',
    level: 7,
  ),

  /// 震度6強
  sixUpper(
    displayName: '6+',
    description: '震度6強',
    level: 8,
  ),

  /// 震度7
  seven(displayName: '7', description: '震度7', level: 9);

  const JmaIntensity({
    required this.displayName,
    required this.description,
    required this.level,
  });

  /// 表示名
  final String displayName;

  /// 説明
  final String description;

  /// レベル値
  final int level;

  /// 文字列から震度を取得
  static JmaIntensity fromString(String? value) {
    if (value == null) {
      return JmaIntensity.unknown;
    }

    switch (value.trim()) {
      case '0':
        return JmaIntensity.zero;
      case '1':
        return JmaIntensity.one;
      case '2':
        return JmaIntensity.two;
      case '3':
        return JmaIntensity.three;
      case '4':
        return JmaIntensity.four;
      case '5-':
        return JmaIntensity.fiveLower;
      case '5+':
        return JmaIntensity.fiveUpper;
      case '6-':
        return JmaIntensity.sixLower;
      case '6+':
        return JmaIntensity.sixUpper;
      case '7':
        return JmaIntensity.seven;
      default:
        return JmaIntensity.unknown;
    }
  }
}
