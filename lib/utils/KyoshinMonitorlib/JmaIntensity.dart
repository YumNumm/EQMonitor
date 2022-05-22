/// 気象庁震度階級 + α
// ignore_for_file: constant_identifier_names, always_put_control_body_on_new_line, file_names, avoid_classes_with_only_static_members

enum JmaIntensity {
  /// 震度不明
  Unknown("unknown"),

  /// 震度1未満
  Int0("0"),

  /// 震度1
  Int1("1"),

  /// 震度2
  Int2("2"),

  /// 震度3
  Int3("3"),

  /// 震度4
  Int4("4"),

  /// 震度5弱
  Int5Lower("5-"),

  /// 震度5強
  Int5Upper("5+"),

  /// 震度6弱
  Int6Lower("6-"),

  /// 震度6強
  Int6Upper("6+"),

  /// 震度7
  Int7("7"),

  /// 震度異常
  Error("unknown");

  final String name;
  const JmaIntensity(this.name);
}

/// JMAIntensityの拡張メゾッド
class JmaIntensityExtensions {
  /// 生の震度の値を気象庁震度階級(`JmaIntensity`型へ変換)
  static JmaIntensity toJmaIntensity({required double? intensity}) {
    if (intensity == null) {
      return JmaIntensity.Unknown;
    } else {
      if (intensity < 0.5) return JmaIntensity.Int0;
      if (intensity < 1.5) return JmaIntensity.Int1;
      if (intensity < 2.5) return JmaIntensity.Int2;
      if (intensity < 3.5) return JmaIntensity.Int3;
      if (intensity < 4.5) return JmaIntensity.Int4;
      if (intensity < 5.0) return JmaIntensity.Int5Lower;
      if (intensity < 5.5) return JmaIntensity.Int5Upper;
      if (intensity < 6.0) return JmaIntensity.Int6Lower;
      if (intensity < 6.5) return JmaIntensity.Int6Upper;
      return JmaIntensity.Int7;
    }
  }

  /// 気象庁震度階級を短い形式の文字列に変換します
  static String toShortString(JmaIntensity shindo) {
    switch (shindo) {
      case JmaIntensity.Error:
        return '*';

      case JmaIntensity.Int0:
        return '0';

      case JmaIntensity.Int1:
        return '1';

      case JmaIntensity.Int2:
        return '2';

      case JmaIntensity.Int3:
        return '3';

      case JmaIntensity.Int4:
        return '4';

      case JmaIntensity.Int5Lower:
        return '5-';

      case JmaIntensity.Int5Upper:
        return '5+';

      case JmaIntensity.Int6Lower:
        return '6-';

      case JmaIntensity.Int6Upper:
        return '6+';

      case JmaIntensity.Int7:
        return '7';
      case JmaIntensity.Unknown:
        return '-';
    }
  }
}
