import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'earthquake_history_config_model.freezed.dart';
part 'earthquake_history_config_model.g.dart';

@freezed
abstract class EarthquakeHistoryConfig with _$EarthquakeHistoryConfig {
  const factory EarthquakeHistoryConfig({
    required EarthquakeHistoryListConfig list,
  }) = _EarthquakeHistoryConfig;

  factory EarthquakeHistoryConfig.fromJson(Map<String, dynamic> json) =>
      _$EarthquakeHistoryConfigFromJson(json);
}

@freezed
abstract class EarthquakeHistoryListConfig with _$EarthquakeHistoryListConfig {
  const factory EarthquakeHistoryListConfig({
    /// 背景塗りつぶしの有無
    @Default(true) bool isFillBackground,

    /// ホーム「指定地域」用。将来の地域選択UIから設定
    RegionSearchType? designatedRegionSearchType,
    String? designatedRegionCode,
    String? designatedRegionName,
  }) = _EarthquakeHistoryListConfig;

  factory EarthquakeHistoryListConfig.fromJson(Map<String, dynamic> json) =>
      _$EarthquakeHistoryListConfigFromJson(json);
}

/// 地震履歴詳細画面における塗りつぶし表示モード
enum EarthquakeHistoryFillMode {
  none,
  auto,
  region,
  city,
}

/// 観測点の表示方法
enum StationDisplayMode {
  maxFocused,
  normal,
  allMinimized,
}

/// 震央マーカーの表示方法
enum HypocenterDisplayMode {
  zoomFade,
  alwaysOpaque,
  belowStations,
}
