import 'package:freezed_annotation/freezed_annotation.dart';

@JsonEnum(fieldRename: FieldRename.screamingSnake)
enum TelegramInfoType {
  publication,
  correction,
  delay,
  cancellation,
}
