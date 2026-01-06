import 'package:freezed_annotation/freezed_annotation.dart';

/// 電文の情報種別
@JsonEnum(valueField: 'value')
enum TelegramInfoType {
  @JsonValue('PUBLICATION')
  publication('PUBLICATION'),
  @JsonValue('CORRECTION')
  correction('CORRECTION'),
  @JsonValue('DELAY')
  delay('DELAY'),
  @JsonValue('CANCELLATION')
  cancellation('CANCELLATION')
  ;

  const TelegramInfoType(this.value);
  final String value;
}
