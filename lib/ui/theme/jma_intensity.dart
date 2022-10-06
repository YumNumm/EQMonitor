// ignore_for_file: lines_longer_than_80_chars, avoid_positional_boolean_parameters

import 'dart:ui';

import 'package:eqmonitor/model/setting/jma_intensity_color_model.dart';
import 'package:flutter/material.dart';

/// 気象庁震度階級 + α
// ignore_for_file: constant_identifier_names, always_put_control_body_on_new_line, file_names, avoid_classes_with_only_static_members

enum JmaIntensity {
  /// 震度不明
  Unknown(
    '?',
    Color.fromARGB(255, 242, 242, 255),
    -1,
  ),

  /// 震度1未満
  Int0('0', Color.fromARGB(255, 255, 255, 255), 0),

  /// 震度1
  Int1('1', Color.fromARGB(255, 214, 217, 218), 1),

  /// 震度2
  Int2('2', Color.fromARGB(255, 170, 224, 249), 1),

  /// 震度3
  Int3('3', Color.fromARGB(255, 141, 206, 165), 3),

  /// 震度4
  /// 津波注意報
  Int4('4', Color.fromARGB(255, 250, 245, 0), 4),

  /// 震度5弱
  Int5Lower('5-', Color.fromARGB(255, 248, 156, 28), 5),

  /// 震度5強
  Int5Upper('5+', Color.fromARGB(255, 197, 112, 0), 6),

  /// 震度6弱
  /// 津波警報
  Int6Lower('6-', Color.fromARGB(255, 255, 40, 0), 7),

  /// 震度6強
  Int6Upper('6+', Color.fromARGB(255, 123, 0, 0), 8),

  /// 震度7
  /// 大津波警報
  Int7('7', Color.fromARGB(255, 200, 0, 255), 9),

  // 程度以上
  over('over', Color.fromARGB(255, 255, 255, 255), -1),

  /// 震度異常
  Error('-', Color.fromARGB(255, 73, 243, 214), -2);

  const JmaIntensity(
    this.name,
    this.color,
    this.intValue,
  );
  final String name;
  final Color color;
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

  Color fromUser(JmaIntensityColorModel colors) {
    switch (this) {
      case JmaIntensity.Int0:
        return colors.int0;
      case JmaIntensity.Int1:
        return colors.int1;
      case JmaIntensity.Int2:
        return colors.int2;
      case JmaIntensity.Int3:
        return colors.int3;
      case JmaIntensity.Int4:
        return colors.int4;
      case JmaIntensity.Int5Lower:
        return colors.int5Lower;
      case JmaIntensity.Int5Upper:
        return colors.int5Upper;
      case JmaIntensity.Int6Lower:
        return colors.int6Lower;
      case JmaIntensity.Int6Upper:
        return colors.int6Upper;
      case JmaIntensity.Int7:
        return colors.int7;
      case JmaIntensity.Unknown:
        return colors.unknown;
      case JmaIntensity.over:
        return colors.over;
      case JmaIntensity.Error:
        return colors.error;
    }
  }
}

extension on JmaIntensity {}
