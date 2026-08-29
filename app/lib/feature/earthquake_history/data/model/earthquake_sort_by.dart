import 'package:eqmonitor_api/eqmonitor_api.dart' as api;

/// 地震一覧のソート項目
///
/// 発生時刻順は eventId ソートで代用する
/// (eventId は発生時刻ベースの採番のため並びが一致する)。
enum EarthquakeSortBy {
  eventId,
  magnitude,
  maxIntensity,
  maxLpgmIntensity,
  depth,
  regionalIntensity;

  String get label => switch (this) {
    .eventId => '発生時刻',
    .magnitude => 'マグニチュード',
    .maxIntensity => '地震の最大震度',
    .maxLpgmIntensity => '長周期階級',
    .depth => '震源の深さ',
    .regionalIntensity => '選択地域の観測震度',
  };

  bool get showsDateHeader => this == .eventId;
}

extension EarthquakeSortByApiExtension on api.EarthquakeSortBy {
  EarthquakeSortBy get toEarthquakeSortBy => switch (this) {
    .eventId || .originTime => .eventId,
    .magnitude => .magnitude,
    .maxIntensity => .maxIntensity,
    .maxLpgmIntensity => .maxLpgmIntensity,
    .depth => .depth,
  };
}

extension EarthquakeSortByToApiExtension on EarthquakeSortBy {
  api.EarthquakeSortBy get toApiEarthquakeSortBy => switch (this) {
    .eventId => .eventId,
    .magnitude => .magnitude,
    .maxIntensity => .maxIntensity,
    .maxLpgmIntensity => .maxLpgmIntensity,
    .depth => .depth,
    .regionalIntensity => throw StateError(
      '選択地域の観測震度は全地震検索では利用できません',
    ),
  };
}

extension EarthquakeSortByToIntensityApiExtension on EarthquakeSortBy {
  api.IntensitySearchSortBy get toApiIntensitySearchSortBy => switch (this) {
    .eventId => .eventId,
    .magnitude => .magnitude,
    .maxIntensity => .maxIntensity,
    .maxLpgmIntensity => .maxLpgmIntensity,
    .depth => .depth,
    .regionalIntensity => .intensity,
  };
}
