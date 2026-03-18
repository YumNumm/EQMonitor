import 'package:eqmonitor_api/export.dart' as api;
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

extension EewInfoTypeApiExtension on api.EewItemWithRelationsInfoType {
  TelegramInfoType get toTelegramInfoType => switch (this) {
    .publication => .publication,
    .correction => .correction,
    .delay => .delay,
    .cancellation => .cancellation,
  };
}

extension InfoTypeApiExtension on api.InfoType {
  TelegramInfoType get toTelegramInfoType => switch (this) {
    .publication => .publication,
    .correction => .correction,
    .delay => .delay,
    .cancellation => .cancellation,
  };
}
