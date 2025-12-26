import 'package:freezed_annotation/freezed_annotation.dart';

/// 電文のステータス
@JsonEnum(valueField: 'value')
enum TelegramStatus {
  @JsonValue('NORMAL')
  normal('NORMAL'),
  @JsonValue('TRAINING')
  training('TRAINING'),
  @JsonValue('TEST')
  test('TEST');

  const TelegramStatus(this.value);
  final String value;
}
