import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:freezed_annotation/freezed_annotation.dart';

@JsonEnum(fieldRename: FieldRename.screamingSnake)
enum TelegramInfoType {
  publication,
  correction,
  delay,
  cancellation,
}

extension TelegramInfoTypeApiExtension on api.TelegramInfoType {
  TelegramInfoType get toTelegramInfoType => switch (this) {
    .publication => .publication,
    .correction => .correction,
    .delay => .delay,
    .cancellation => .cancellation,
  };
}

extension TelegramInfoTypeToApiExtension on TelegramInfoType {
  api.TelegramInfoType get toApiTelegramInfoType => switch (this) {
    .publication => .publication,
    .correction => .correction,
    .delay => .delay,
    .cancellation => .cancellation,
  };
}
