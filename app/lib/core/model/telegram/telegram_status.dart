import 'package:eqmonitor_api/export.dart' as api;
import 'package:freezed_annotation/freezed_annotation.dart';

@JsonEnum(fieldRename: FieldRename.screamingSnake)
enum TelegramStatus {
  normal,
  training,
  test,
}

extension TelegramStatusApiExtension on api.TelegramStatus {
  TelegramStatus get toTelegramStatus => switch (this) {
    .normal => .normal,
    .training => .training,
    .test => .test,
  };
}

extension TelegramStatusToApiExtension on TelegramStatus {
  api.TelegramStatus get toApiTelegramStatus => switch (this) {
    .normal => .normal,
    .training => .training,
    .test => .test,
  };
}
