import 'package:eqmonitor_api/eqmonitor_api.dart' as api;

/// 地震に紐づく電文タイプ
enum EarthquakeTelegramType {
  vxse51,
  vxse52,
  vxse53,
  vxse61,
  vxse62,
  vxse45Forecast,
  vxse45Warning;

  String get label => switch (this) {
    .vxse51 => '震度速報',
    .vxse52 => '震源に関する情報',
    .vxse53 => '震源・震度に関する情報',
    .vxse61 => '地震の活動状況等に関する情報',
    .vxse62 => '地震回数に関する情報',
    .vxse45Forecast => '緊急地震速報（予報）',
    .vxse45Warning => '緊急地震速報（警報）',
  };
}

extension EarthquakeTelegramTypeApiExtension on api.EarthquakeTelegramType {
  EarthquakeTelegramType get toEarthquakeTelegramType => switch (this) {
    .vxse51 => .vxse51,
    .vxse52 => .vxse52,
    .vxse53 => .vxse53,
    .vxse61 => .vxse61,
    .vxse62 => .vxse62,
    .vxse45Forecast => .vxse45Forecast,
    .vxse45Warning => .vxse45Warning,
  };
}

extension TelegramTypeApiEarthquakeExtension on api.TelegramType {
  EarthquakeTelegramType? get toEarthquakeTelegramTypeOrNull => switch (this) {
    .vxse51 => .vxse51,
    .vxse52 => .vxse52,
    .vxse53 => .vxse53,
    .vxse61 => .vxse61,
    .vxse62 => .vxse62,
    _ => null,
  };
}

extension EarthquakeTelegramTypeToApiExtension on EarthquakeTelegramType {
  api.EarthquakeTelegramType get toApiEarthquakeTelegramType => switch (this) {
    .vxse51 => .vxse51,
    .vxse52 => .vxse52,
    .vxse53 => .vxse53,
    .vxse61 => .vxse61,
    .vxse62 => .vxse62,
    .vxse45Forecast => .vxse45Forecast,
    .vxse45Warning => .vxse45Warning,
  };
}
