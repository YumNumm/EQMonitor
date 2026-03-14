import 'package:eqmonitor_api/export.dart' as api;
import 'package:freezed_annotation/freezed_annotation.dart';

@JsonEnum(fieldRename: FieldRename.screamingSnake)
enum TelegramType {
  vzse40,
  vxse42,
  vxse43,
  vxse44,
  vxse45,
  vxse47,
  vtse41,
  vtse51,
  vtse52,
  vxse51,
  vxse52,
  vxse53,
  vxse56,
  vxse60,
  vxse61,
  vxse62,
  nankai,
  vyse60,
  shindoDb,
}

extension TelegramTypeApiExtension on api.TelegramType {
  TelegramType get toTelegramType => switch (this) {
    .vzse40 => .vzse40,
    .vxse42 => .vxse42,
    .vxse43 => .vxse43,
    .vxse44 => .vxse44,
    .vxse45 => .vxse45,
    .vxse47 => .vxse47,
    .vtse41 => .vtse41,
    .vtse51 => .vtse51,
    .vtse52 => .vtse52,
    .vxse51 => .vxse51,
    .vxse52 => .vxse52,
    .vxse53 => .vxse53,
    .vxse56 => .vxse56,
    .vxse60 => .vxse60,
    .vxse61 => .vxse61,
    .vxse62 => .vxse62,
    .nankai => .nankai,
    .vyse60 => .vyse60,
    .shindoDb => .shindoDb,
  };
}
