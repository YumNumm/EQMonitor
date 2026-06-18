import 'package:eqmonitor_api/eqmonitor_api.dart' as api;

/// アプリ側の JMA 震度（観測・予想共通）
enum JmaIntensity {
  unknown,
  zero,
  one,
  two,
  three,
  four,
  fiveUnknown,
  fiveLower,
  fiveUpper,
  sixLower,
  sixUpper,
  seven;

  String get label => switch (this) {
    .unknown => '不明',
    .zero => '0',
    .one => '1',
    .two => '2',
    .three => '3',
    .four => '4',
    .fiveUnknown => '5',
    .fiveLower => '5-',
    .fiveUpper => '5+',
    .sixLower => '6-',
    .sixUpper => '6+',
    .seven => '7',
  };

  String get mainText => switch (this) {
    .fiveUnknown => '5',
    .fiveLower => '5',
    .fiveUpper => '5',
    .sixLower => '6',
    .sixUpper => '6',
    _ => label.replaceAll('-', '').replaceAll('+', ''),
  };

  String get suffix => switch (this) {
    .fiveUnknown => '弱以上',
    .fiveLower => '弱',
    .fiveUpper => '強',
    .sixLower => '弱',
    .sixUpper => '強',
    _ => '',
  };

  /// ソート・比較用の順序（0=最小, 10=最大）
  int get orderIndex => switch (this) {
    .unknown => -1,
    .zero => 0,
    .one => 1,
    .two => 2,
    .three => 3,
    .four => 4,
    .fiveUnknown => 5,
    .fiveLower => 6,
    .fiveUpper => 7,
    .sixLower => 8,
    .sixUpper => 9,
    .seven => 10,
  };
}

extension ApiJmaIntensityConverter on api.JmaIntensity {
  JmaIntensity get toJmaIntensity => switch (this) {
    .undefined1 => .unknown,
    .value0 => .zero,
    .value1 => .one,
    .value2 => .two,
    .value3 => .three,
    .value4 => .four,
    .value5unknown => .fiveUnknown,
    .value5minus => .fiveLower,
    .value5plus => .fiveUpper,
    .value6minus => .sixLower,
    .value6plus => .sixUpper,
    .value7 => .seven,
  };
}

extension JmaIntensityToApi on JmaIntensity {
  api.JmaIntensity? get toApiJmaIntensity => switch (this) {
    .unknown => null,
    .zero => .value0,
    .one => .value1,
    .two => .value2,
    .three => .value3,
    .four => .value4,
    .fiveUnknown => .value5unknown,
    .fiveLower => .value5minus,
    .fiveUpper => .value5plus,
    .sixLower => .value6minus,
    .sixUpper => .value6plus,
    .seven => .value7,
  };
}

extension JmaIntensityFromRawKnetInt on JmaIntensity {
  /// K-NET 計測震度の小数値（rawInt）から JmaIntensity に変換する
  static JmaIntensity fromRawKnetInt(double rawInt) {
    if (rawInt < 0.5) {
      return JmaIntensity.zero;
    }
    if (rawInt < 1.5) {
      return JmaIntensity.one;
    }
    if (rawInt < 2.5) {
      return JmaIntensity.two;
    }
    if (rawInt < 3.5) {
      return JmaIntensity.three;
    }
    if (rawInt < 4.5) {
      return JmaIntensity.four;
    }
    if (rawInt < 5.0) {
      return JmaIntensity.fiveLower;
    }
    if (rawInt < 5.5) {
      return JmaIntensity.fiveUpper;
    }
    if (rawInt < 6.0) {
      return JmaIntensity.sixLower;
    }
    if (rawInt < 6.5) {
      return JmaIntensity.sixUpper;
    }
    return JmaIntensity.seven;
  }
}

extension ApiMinJmaIntensityConverter on api.MinJmaIntensity {
  JmaIntensity get toJmaIntensity => switch (this) {
    .undefined1 => .unknown,
    .value0 => .zero,
    .value1 => .one,
    .value2 => .two,
    .value3 => .three,
    .value4 => .four,
    .value5unknown => .fiveUnknown,
    .value5minus => .fiveLower,
    .value5plus => .fiveUpper,
    .value6minus => .sixLower,
    .value6plus => .sixUpper,
    .value7 => .seven,
  };
}

extension JmaIntensityToApiMin on JmaIntensity {
  api.MinJmaIntensity? get toApiMinJmaIntensity => switch (this) {
    JmaIntensity.unknown => null,
    JmaIntensity.zero => .value0,
    JmaIntensity.one => .value1,
    JmaIntensity.two => .value2,
    JmaIntensity.three => .value3,
    JmaIntensity.four => .value4,
    JmaIntensity.fiveUnknown => .value5unknown,
    JmaIntensity.fiveLower => .value5minus,
    JmaIntensity.fiveUpper => .value5plus,
    JmaIntensity.sixLower => .value6minus,
    JmaIntensity.sixUpper => .value6plus,
    JmaIntensity.seven => .value7,
  };
}
