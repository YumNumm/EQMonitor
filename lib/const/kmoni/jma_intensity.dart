// ignore_for_file: lines_longer_than_80_chars, avoid_positional_boolean_parameters

import 'dart:ui';

/// 気象庁震度階級 + α
// ignore_for_file: constant_identifier_names, always_put_control_body_on_new_line, file_names, avoid_classes_with_only_static_members

enum JmaIntensity {
  /// 震度不明
  Unknown(
    '?',
    Color.fromARGB(255, 242, 242, 255),
    true,
    -1,
  ),

  /// 震度1未満
  Int0('0', Color.fromARGB(255, 242, 242, 255), true, 0),

  /// 震度1
  Int1('1', Color.fromARGB(255, 107, 120, 120), true, 1),

  /// 震度2
  Int2('2', Color.fromARGB(255, 30, 110, 230), false, 2),

  /// 震度3
  Int3('3', Color.fromARGB(255, 50, 180, 100), true, 3),

  /// 震度4
  Int4('4', Color.fromARGB(255, 255, 224, 93), true, 4),

  /// 震度5弱
  Int5Lower('5-', Color.fromARGB(255, 255, 170, 19), true, 5),

  /// 震度5強
  Int5Upper('5+', Color.fromARGB(255, 255, 112, 15), true, 6),

  /// 震度6弱
  Int6Lower('6-', Color.fromARGB(255, 230, 0, 0), false, 7),

  /// 震度6強
  Int6Upper('6+', Color.fromARGB(255, 160, 0, 0), false, 8),

  /// 震度7
  Int7('7', Color.fromARGB(255, 93, 0, 144), false, 9),

  // 程度以上
  over('over', Color.fromARGB(255, 255, 255, 255), true, -1),

  /// 震度異常
  Error('-', Color.fromARGB(255, 73, 243, 214), true, -2);

  const JmaIntensity(
    this.name,
    this.color,
    this.shouldTextBlack,
    this.intValue,
  );
  final String name;
  final Color color;
  final bool shouldTextBlack;
  final int intValue;

  static JmaIntensity fromInt(int value) {
    switch (value) {
      case 0:
        return Int0;
      case 1:
        return Int1;
      case 2:
        return Int2;
      case 3:
        return Int3;
      case 4:
        return Int4;
      case 5:
        return Int5Lower;
      case 6:
        return Int6Lower;
      case 7:
        return Int7;
      case 8:
        return Int6Upper;
      case 9:
        return Int5Upper;
      default:
        return Unknown;
    }
  }

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
      case JmaIntensity.over:
        return '+';
    }
  }
}
