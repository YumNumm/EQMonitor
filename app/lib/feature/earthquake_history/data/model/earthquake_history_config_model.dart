import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_sort_by.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'earthquake_history_config_model.freezed.dart';
part 'earthquake_history_config_model.g.dart';

@freezed
abstract class EarthquakeHistoryConfig with _$EarthquakeHistoryConfig {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory({
    required EarthquakeHistoryListConfig list,
    @Default(EarthquakeHistoryDetailsConfig())
    EarthquakeHistoryDetailsConfig details,
  }) = _EarthquakeHistoryConfig;

  factory fromJson(Map<String, dynamic> json) =>
      _$EarthquakeHistoryConfigFromJson(json);
}

@freezed
abstract class EarthquakeHistoryListConfig with _$EarthquakeHistoryListConfig {
  const factory({
    /// 背景塗りつぶしの有無
    @Default(true) bool isFillBackground,

    /// 日付見出しの表示方法
    @Default(DateHeaderDisplayMode.onlyWhenDateSort)
    DateHeaderDisplayMode dateHeaderDisplayMode,

    /// ホーム「指定地域」用。将来の地域選択UIから設定
    RegionSearchType? designatedRegionSearchType,
    String? designatedRegionCode,
    String? designatedRegionName,
  }) = _EarthquakeHistoryListConfig;

  factory fromJson(Map<String, dynamic> json) =>
      _$EarthquakeHistoryListConfigFromJson(json);
}

/// 地震履歴一覧の日付見出しの表示方法
enum DateHeaderDisplayMode {
  always,
  onlyWhenDateSort,
  never;

  bool isVisible({required EarthquakeSortBy sortBy}) => switch (this) {
    .always => true,
    .onlyWhenDateSort => sortBy == EarthquakeSortBy.eventId,
    .never => false,
  };
}

/// 地震履歴詳細画面の設定
@freezed
abstract class EarthquakeHistoryDetailsConfig
    with _$EarthquakeHistoryDetailsConfig {
  const factory({
    /// 観測点アイコンの表示モード
    @Default(StationDisplayMode.auto) StationDisplayMode stationDisplayMode,
  }) = _EarthquakeHistoryDetailsConfig;

  factory fromJson(Map<String, dynamic> json) =>
      _$EarthquakeHistoryDetailsConfigFromJson(json);
}

/// 地震履歴詳細画面における塗りつぶし表示モード
enum EarthquakeHistoryFillMode { none, auto, region, city }

/// 観測点の表示方法
enum StationDisplayMode {
  /// ズームに応じて自動切替 (閾値未満: 最大震度のみ数字入り / 閾値以上: すべて数字入り)
  auto,
  maxFocused,
  normal,
  allMinimized,
}

/// 震央マーカーの表示方法
enum HypocenterDisplayMode { zoomFade, alwaysOpaque, belowStations }
