import 'package:freezed_annotation/freezed_annotation.dart';

part 'earthquake_history_config_model.freezed.dart';
part 'earthquake_history_config_model.g.dart';

@freezed
class EarthquakeHistoryConfigModel with _$EarthquakeHistoryConfigModel {
  const factory EarthquakeHistoryConfigModel({
    required EarthquakeHistoryListConfig list,
    required EarthquakeHistoryDetailConfig detail,
  }) = _EarthquakeHistoryConfigModel;

  factory EarthquakeHistoryConfigModel.fromJson(Map<String, dynamic> json) =>
      _$EarthquakeHistoryConfigModelFromJson(json);
}

@freezed
class EarthquakeHistoryListConfig with _$EarthquakeHistoryListConfig {
  const factory EarthquakeHistoryListConfig({
    /// 背景塗りつぶしの有無
    @Default(true) bool isFillBackground,

    /// 訓練・試験用の電文を含めるかどうか
    @Default(false) bool includeTestTelegrams,
  }) = _EarthquakeHistoryListConfig;

  factory EarthquakeHistoryListConfig.fromJson(Map<String, dynamic> json) =>
      _$EarthquakeHistoryListConfigFromJson(json);
}

@freezed
class EarthquakeHistoryDetailConfig with _$EarthquakeHistoryDetailConfig {
  const factory EarthquakeHistoryDetailConfig({
    /// 震度の表示方法
    @Default(IntensityDisplayMode.fillCity)
    IntensityDisplayMode intensityDisplayMode,
  }) = _EarthquakeHistoryDetailConfig;

  factory EarthquakeHistoryDetailConfig.fromJson(Map<String, dynamic> json) =>
      _$EarthquakeHistoryDetailConfigFromJson(json);
}

/// 地震履歴詳細画面における震度の表示方法
enum IntensityDisplayMode {
  /// 震度観測点のアイコンを表示
  icon,

  /// 市区町村レベルの震度塗りつぶし
  fillCity,

  /// 都道府県レベルの震度塗りつぶし
  fillPrefecture,

  /// 震度観測点のアイコンと市区町村レベルの震度塗りつぶし
  iconAndFillCity,
  ;
}
