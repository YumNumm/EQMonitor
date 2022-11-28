// ignore_for_file: lines_longer_than_80_chars, avoid_positional_boolean_parameters

import 'dart:ui';

import 'package:dmdata_telegram_json/dmdata_telegram_json.dart';
import 'package:eqmonitor/model/setting/jma_intensity_color_model.dart';
import 'package:flutter/material.dart';
export 'package:dmdata_telegram_json/schema/component/jma_intensity.dart';

extension JmaIntensityColor on JmaIntensity {
  Color fromUser(JmaIntensityColorModel colors) {
    switch (this) {
      case JmaIntensity.int0:
        return colors.int0;
      case JmaIntensity.int1:
        return colors.int1;
      case JmaIntensity.int2:
        return colors.int2;
      case JmaIntensity.int3:
        return colors.int3;
      case JmaIntensity.int4:
        return colors.int4;
      case JmaIntensity.int5Lower:
        return colors.int5Lower;
      case JmaIntensity.int5Upper:
        return colors.int5Upper;
      case JmaIntensity.int6Lower:
        return colors.int6Lower;
      case JmaIntensity.int6Upper:
        return colors.int6Upper;
      case JmaIntensity.int7:
        return colors.int7;
      case JmaIntensity.unknown:
        return colors.unknown;
      case JmaIntensity.over:
        return colors.over;
      case JmaIntensity.notRecievedYet:
        return colors.notRecievedYet;
    }
  }
}

/// 気象庁震度階級 + α
// ignore_for_file: constant_identifier_names, always_put_control_body_on_new_line, file_names, avoid_classes_with_only_static_members
/*
enum JmaIntensity {
  /// 震度不明
  Unknown(
    '?',
    '震度不明',
    Color.fromARGB(255, 242, 242, 255),
    -1,
  ),

  /// 震度1未満
  Int0('0', '震度1未満', Color.fromARGB(200, 255, 255, 255), 0),

  /// 震度1
  Int1('1', '震度1', Color.fromARGB(255, 143, 159, 255), 1),

  /// 震度2
  Int2('2', '震度2', Color.fromARGB(255, 0, 85, 255), 2),

  /// 震度3
  Int3('3', '震度3', Color.fromARGB(255, 47, 255, 0), 3),

  /// 震度4
  /// 津波注意報
  Int4('4', '震度4', Color.fromARGB(255, 246, 255, 0), 4),

  /// 震度5弱
  Int5Lower('5-', '震度5弱', Color.fromARGB(255, 255, 230, 0), 5),

  /// 震度5強
  Int5Upper('5+', '震度5強', Color.fromARGB(255, 255, 153, 0), 6),

  /// 震度6弱
  /// 津波警報
  Int6Lower('6-', '震度6弱', Color.fromARGB(255, 255, 40, 0), 7),

  /// 震度6強
  Int6Upper('6+', '震度6強', Color.fromARGB(255, 165, 0, 33), 8),

  /// 震度7
  /// 大津波警報
  Int7('7', '震度7', Color.fromARGB(255, 200, 0, 255), 9),

  // 程度以上
  over('over', '程度以上', Color.fromARGB(255, 255, 255, 255), -1),

  /// 震度異常
  Error('-', '震度解析エラー', Color.fromARGB(255, 73, 243, 214), -2);

  const JmaIntensity(
    this.name,
    this.longName,
    this.color,
    this.intValue,
  );
  final String name;
  final String longName;
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
      if (intensity < 0.5) return JmaIntensity.int0;
      if (intensity < 1.5) return JmaIntensity.int1;
      if (intensity < 2.5) return JmaIntensity.int2;
      if (intensity < 3.5) return JmaIntensity.int3;
      if (intensity < 4.5) return JmaIntensity.int4;
      if (intensity < 5.0) return JmaIntensity.int5Lower;
      if (intensity < 5.5) return JmaIntensity.int5Upper;
      if (intensity < 6.0) return JmaIntensity.int6Lower;
      if (intensity < 6.5) return JmaIntensity.int6Upper;
      return JmaIntensity.int7;
    }
  }

  static String toShortString(JmaIntensity shindo) {
    switch (shindo) {
      case JmaIntensity.Error:
        return '*';

      case JmaIntensity.int0:
        return '0';

      case JmaIntensity.int1:
        return '1';

      case JmaIntensity.int2:
        return '2';

      case JmaIntensity.int3:
        return '3';

      case JmaIntensity.int4:
        return '4';

      case JmaIntensity.int5Lower:
        return '5-';

      case JmaIntensity.int5Upper:
        return '5+';

      case JmaIntensity.int6Lower:
        return '6-';

      case JmaIntensity.int6Upper:
        return '6+';

      case JmaIntensity.int7:
        return '7';
      case JmaIntensity.Unknown:
        return '-';
      case JmaIntensity.over:
        return '+';
    }
  }

  Color fromUser(JmaIntensityColorModel colors) {
    switch (this) {
      case JmaIntensity.int0:
        return colors.int0;
      case JmaIntensity.int1:
        return colors.int1;
      case JmaIntensity.int2:
        return colors.int2;
      case JmaIntensity.int3:
        return colors.int3;
      case JmaIntensity.int4:
        return colors.int4;
      case JmaIntensity.int5Lower:
        return colors.int5Lower;
      case JmaIntensity.int5Upper:
        return colors.int5Upper;
      case JmaIntensity.int6Lower:
        return colors.int6Lower;
      case JmaIntensity.int6Upper:
        return colors.int6Upper;
      case JmaIntensity.int7:
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
*/
