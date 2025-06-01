import 'package:freezed_annotation/freezed_annotation.dart';

part 'earthquake_history_config_model.freezed.dart';
part 'earthquake_history_config_model.g.dart';

@freezed
abstract class EarthquakeHistoryConfig with _$EarthquakeHistoryConfig {
  const factory EarthquakeHistoryConfig({
    required EarthquakeHistoryListConfig list,
    required EarthquakeHistoryDetailConfig detail,
  }) = _EarthquakeHistoryConfig;

  factory EarthquakeHistoryConfig.fromJson(Map<String, dynamic> json) =>
      _$EarthquakeHistoryConfigFromJson(json);
}

@freezed
abstract class EarthquakeHistoryListConfig with _$EarthquakeHistoryListConfig {
  const factory EarthquakeHistoryListConfig({
    /// 背景塗りつぶしの有無
    @Default(true) bool isFillBackground,
  }) = _EarthquakeHistoryListConfig;

  factory EarthquakeHistoryListConfig.fromJson(Map<String, dynamic> json) =>
      _$EarthquakeHistoryListConfigFromJson(json);
}

@freezed
abstract class EarthquakeHistoryDetailConfig
    with _$EarthquakeHistoryDetailConfig {
  const factory EarthquakeHistoryDetailConfig({
    /// 震度の表示方法
    @Default(IntensityFillMode.fillCity) IntensityFillMode intensityFillMode,

    /// 震度観測点のアイコン表示
    @Default(true) bool showIntensityIcon,

    /// 長周期地震動階級を表示しているか
    @Default(false) bool showingLpgmIntensity,
  }) = _EarthquakeHistoryDetailConfig;

  factory EarthquakeHistoryDetailConfig.fromJson(Map<String, dynamic> json) =>
      _$EarthquakeHistoryDetailConfigFromJson(
        json,
      ).copyWith(showingLpgmIntensity: false);
}

/// 地震履歴詳細画面における震度の表示方法
enum IntensityFillMode { fillCity, fillRegion, none }
