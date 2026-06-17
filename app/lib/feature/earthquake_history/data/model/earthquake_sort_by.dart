import 'package:eqmonitor_api/eqmonitor_api.dart' as api;

/// 地震一覧のソート項目
enum EarthquakeSortBy {
  eventId,
  magnitude,
  maxIntensity,
  maxLpgmIntensity,
  depth,
  originTime;

  String get label => switch (this) {
    .eventId => '新しい順',
    .magnitude => 'マグニチュード',
    .maxIntensity => '最大震度',
    .maxLpgmIntensity => '長周期階級',
    .depth => '震源の深さ',
    .originTime => '発生時刻',
  };
}

extension EarthquakeSortByApiExtension on api.EarthquakeSortBy {
  EarthquakeSortBy get toEarthquakeSortBy => switch (this) {
    .eventId => .eventId,
    .magnitude => .magnitude,
    .maxIntensity => .maxIntensity,
    .maxLpgmIntensity => .maxLpgmIntensity,
    .depth => .depth,
    .originTime => .originTime,
  };
}

extension EarthquakeSortByToApiExtension on EarthquakeSortBy {
  api.EarthquakeSortBy get toApiEarthquakeSortBy => switch (this) {
    .eventId => .eventId,
    .magnitude => .magnitude,
    .maxIntensity => .maxIntensity,
    .maxLpgmIntensity => .maxLpgmIntensity,
    .depth => .depth,
    .originTime => .originTime,
  };
}
