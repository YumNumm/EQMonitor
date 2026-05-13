import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter.dart';
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

    /// ホーム「指定地域」用。将来の地域選択UIから設定
    RegionSearchType? designatedRegionSearchType,
    String? designatedRegionCode,
    String? designatedRegionName,
  }) = _EarthquakeHistoryListConfig;

  factory EarthquakeHistoryListConfig.fromJson(Map<String, dynamic> json) =>
      _$EarthquakeHistoryListConfigFromJson(json);
}

@freezed
abstract class EarthquakeHistoryDetailConfig
    with _$EarthquakeHistoryDetailConfig {
  const factory EarthquakeHistoryDetailConfig({
    /// アイコンの表示モード
    @JsonKey(unknownEnumValue: EarthquakeHistoryIconMode.auto)
    @Default(EarthquakeHistoryIconMode.auto)
    EarthquakeHistoryIconMode iconMode,

    /// 塗りつぶしの表示モード
    @JsonKey(unknownEnumValue: EarthquakeHistoryFillMode.none)
    @Default(EarthquakeHistoryFillMode.matchIcon)
    EarthquakeHistoryFillMode fillMode,

    /// 観測点の表示方法
    @Default(StationDisplayMode.maxFocused)
    StationDisplayMode stationDisplayMode,

    /// 震央マーカーの表示方法
    @Default(HypocenterDisplayMode.zoomFade)
    HypocenterDisplayMode hypocenterDisplayMode,

    /// 震央誤差矩形を表示するか
    @Default(false) bool showHypocenterError,

    /// 観測点名ラベルを表示するか
    @Default(false) bool showStationLabel,

    /// 推計震度データがある場合に自動で推計震度モードにするか（永続化）
    @Default(true) bool useEstimatedIntensityWhenAvailable,

    /// 震度凡例を表示するか
    @Default(true) bool showLegend,

    /// 長周期地震動階級を表示しているか
    @Default(false) bool showingLpgmIntensity,

    /// 観測点レイヤーを表示するか
    @Default(true) bool showStation,
  }) = _EarthquakeHistoryDetailConfig;

  factory EarthquakeHistoryDetailConfig.fromJson(Map<String, dynamic> json) =>
      _$EarthquakeHistoryDetailConfigFromJson(json);
}

/// 地震履歴詳細画面におけるアイコン表示モード
enum EarthquakeHistoryIconMode {
  /// 自動（細分化地域→市区町村→観測点をズームに応じて段階表示）
  auto,

  /// 観測点アイコンのみ（データなければ細分化地域にフォールバック）
  station,

  /// 市区町村アイコンのみ（データなければ細分化地域にフォールバック）
  municipality,

  /// 細分化地域アイコンのみ
  region,

  /// アイコン非表示
  none,
}

/// 地震履歴詳細画面における塗りつぶし表示モード
enum EarthquakeHistoryFillMode {
  /// 塗りつぶしなし
  none,

  /// アイコン表示モードに合わせて塗りつぶし
  matchIcon,
}

/// 観測点の表示方法
enum StationDisplayMode {
  /// 最大震度を観測した観測点以外を縮小表示
  maxFocused,

  /// 通常表示（全観測点同サイズ）
  normal,

  /// すべて縮小表示
  allMinimized,
}

/// 震央マーカーの表示方法
enum HypocenterDisplayMode {
  /// 低ズームでは不透明、ズームインで半透明（デフォルト）
  zoomFade,

  /// 常に不透明表示（観測点レイヤーの上）
  alwaysOpaque,

  /// 常に不透明表示（観測点レイヤーの下）
  belowStations,
}
