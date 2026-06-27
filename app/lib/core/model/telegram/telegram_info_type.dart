import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:freezed_annotation/freezed_annotation.dart';

@JsonEnum(fieldRename: FieldRename.screamingSnake)
enum TelegramInfoType {
  publication,
  correction,
  cancellation,
  delay,
}

extension TelegramInfoTypeApiExtension on api.InfoType {
  TelegramInfoType get toTelegramInfoType => switch (this) {
    .publication => .publication,
    .correction => .correction,
    .delay => .delay,
    .cancellation => .cancellation,
  };
}
