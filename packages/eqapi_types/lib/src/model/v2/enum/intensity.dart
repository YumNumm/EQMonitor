import 'package:freezed_annotation/freezed_annotation.dart';

/// 震度階級
@JsonEnum(valueField: 'value')
enum IntensityValue {
  @JsonValue('0')
  zero('0'),
  @JsonValue('1')
  one('1'),
  @JsonValue('2')
  two('2'),
  @JsonValue('3')
  three('3'),
  @JsonValue('4')
  four('4'),
  @JsonValue('!5-')
  fiveLowerNoInput('!5-'),
  @JsonValue('5-')
  fiveLower('5-'),
  @JsonValue('5+')
  fiveUpper('5+'),
  @JsonValue('6-')
  sixLower('6-'),
  @JsonValue('6+')
  sixUpper('6+'),
  @JsonValue('7')
  seven('7')
  ;

  const IntensityValue(this.value);
  final String value;

  @override
  String toString() => value
      .replaceAll('!5-', '5弱以上未入電')
      .replaceAll('+', '強')
      .replaceAll('-', '弱');
}

/// 長周期地震動階級
@JsonEnum(valueField: 'value')
enum LpgmIntensityValue {
  @JsonValue('0')
  zero('0'),
  @JsonValue('1')
  one('1'),
  @JsonValue('2')
  two('2'),
  @JsonValue('3')
  three('3'),
  @JsonValue('4')
  four('4')
  ;

  const LpgmIntensityValue(this.value);
  final String value;

  @override
  String toString() => value;
}
