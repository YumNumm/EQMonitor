import 'package:freezed_annotation/freezed_annotation.dart';

@JsonEnum(valueField: 'type')
enum TelegramStatus {
  normal('通常'),
  training('訓練'),
  test('試験');

  const TelegramStatus(this.type);
  final String type;
}

@JsonEnum(valueField: 'type')
enum TelegramInfoType {
  issue('発表'),
  correction('訂正'),
  delay('遅延'),
  cancel('取消');

  const TelegramInfoType(this.type);
  final String type;
}

@JsonEnum(valueField: 'type')
enum JmaIntensity {
  one('1'),
  two('2'),
  three('3'),
  four('4'),
  fiveLower('5-'),
  fiveUpper('5+'),
  sixLower('6-'),
  sixUpper('6+'),
  seven('7'),

  /// 震度5弱以上未入電
  fiveUpperNoInput('!5-');

  const JmaIntensity(this.type);
  final String type;

  @override
  String toString() => type
      .replaceAll('!5-', '5弱以上未入電')
      .replaceAll('+', '強')
      .replaceAll('-', '弱');

  bool operator <(JmaIntensity other) {
    return index < other.index;
  }

  bool operator <=(JmaIntensity other) {
    return index <= other.index;
  }

  bool operator >(JmaIntensity other) {
    return index > other.index;
  }

  bool operator >=(JmaIntensity other) {
    return index >= other.index;
  }
}

@JsonEnum(valueField: 'type')
enum JmaForecastIntensity {
  zero('0'),
  one('1'),
  two('2'),
  three('3'),
  four('4'),
  fiveLower('5-'),
  fiveUpper('5+'),
  sixLower('6-'),
  sixUpper('6+'),
  seven('7'),
  unknown('不明');

  const JmaForecastIntensity(this.type);
  final String type;

  bool operator <(JmaForecastIntensity other) {
    return index < other.index;
  }

  bool operator <=(JmaForecastIntensity other) {
    return index <= other.index;
  }

  bool operator >(JmaForecastIntensity other) {
    return index > other.index;
  }

  bool operator >=(JmaForecastIntensity other) {
    return index >= other.index;
  }
}

@JsonEnum(valueField: 'type')
enum JmaForecastIntensityOver {
  zero('0'),
  one('1'),
  two('2'),
  three('3'),
  four('4'),
  fiveLower('5-'),
  fiveUpper('5+'),
  sixLower('6-'),
  sixUpper('6+'),
  seven('7'),
  unknown('不明'),
  over('over');

  const JmaForecastIntensityOver(this.type);
  final String type;

  /// `over`の場合は`unknown`に変換されます
  JmaForecastIntensity get toJmaForecastIntensity => switch (this) {
        JmaForecastIntensityOver.zero => JmaForecastIntensity.zero,
        JmaForecastIntensityOver.one => JmaForecastIntensity.one,
        JmaForecastIntensityOver.two => JmaForecastIntensity.two,
        JmaForecastIntensityOver.three => JmaForecastIntensity.three,
        JmaForecastIntensityOver.four => JmaForecastIntensity.four,
        JmaForecastIntensityOver.fiveLower => JmaForecastIntensity.fiveLower,
        JmaForecastIntensityOver.fiveUpper => JmaForecastIntensity.fiveUpper,
        JmaForecastIntensityOver.sixLower => JmaForecastIntensity.sixLower,
        JmaForecastIntensityOver.sixUpper => JmaForecastIntensity.sixUpper,
        JmaForecastIntensityOver.seven => JmaForecastIntensity.seven,
        JmaForecastIntensityOver.unknown => JmaForecastIntensity.unknown,
        JmaForecastIntensityOver.over => JmaForecastIntensity.unknown,
      };
}

@JsonEnum(valueField: 'type')
enum JmaLgIntensity {
  zero('0'),
  one('1'),
  two('2'),
  three('3'),
  four('4');

  const JmaLgIntensity(this.type);
  final String type;

  @override
  String toString() => type;
  bool operator <(JmaLgIntensity other) {
    return index < other.index;
  }

  bool operator <=(JmaLgIntensity other) {
    return index <= other.index;
  }

  bool operator >(JmaLgIntensity other) {
    return index > other.index;
  }

  bool operator >=(JmaLgIntensity other) {
    return index >= other.index;
  }
}

@JsonEnum(valueField: 'type')
enum JmaForecastLgIntensity {
  zero('0'),
  one('1'),
  two('2'),
  three('3'),
  four('4'),
  unknown('不明');

  const JmaForecastLgIntensity(this.type);
  final String type;

  bool operator >(JmaLgIntensity other) {
    return type.compareTo(other.type) > 0;
  }
}

@JsonEnum(valueField: 'type')
enum JmaForecastLgIntensityOver {
  zero('0'),
  one('1'),
  two('2'),
  three('3'),
  four('4'),
  unknown('不明'),
  over('over');

  const JmaForecastLgIntensityOver(this.type);
  final String type;

  /// `over`の場合は`unknown`に変換されます
  JmaForecastLgIntensity get toJmaForecastLgIntensity => switch (this) {
        JmaForecastLgIntensityOver.zero => JmaForecastLgIntensity.zero,
        JmaForecastLgIntensityOver.one => JmaForecastLgIntensity.one,
        JmaForecastLgIntensityOver.two => JmaForecastLgIntensity.two,
        JmaForecastLgIntensityOver.three => JmaForecastLgIntensity.three,
        JmaForecastLgIntensityOver.four => JmaForecastLgIntensity.four,
        JmaForecastLgIntensityOver.unknown => JmaForecastLgIntensity.unknown,
        JmaForecastLgIntensityOver.over => JmaForecastLgIntensity.unknown,
      };
}

@JsonEnum(valueField: 'type')
enum LgType {
  one('1'),
  two('2'),
  three('3'),
  four('4');

  const LgType(this.type);
  final String type;
}
