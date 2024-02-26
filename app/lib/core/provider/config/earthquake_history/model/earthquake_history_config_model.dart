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
    @Default(IntensityFillMode.fillCity) IntensityFillMode intensityFillMode,

    /// 震度観測点のアイコン表示
    @Default(true) bool showIntensityIcon,

    /// fromJsonでは、常にfalseを返す
    @Default(false) bool showingLpgmIntensity,
  }) = _EarthquakeHistoryDetailConfig;

  factory EarthquakeHistoryDetailConfig.fromJson(Map<String, dynamic> json) =>
      _$EarthquakeHistoryDetailConfigFromJson(json).copyWith(
        showingLpgmIntensity: false,
      );
}

/// 地震履歴詳細画面における震度の表示方法
enum IntensityFillMode {
  fillCity,
  fillRegion,
  none;
}
