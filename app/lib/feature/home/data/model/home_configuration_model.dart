import 'package:eqmonitor/core/util/converter/lat_lng_boundary_converter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lat_lng/lat_lng.dart';

part 'home_configuration_model.freezed.dart';
part 'home_configuration_model.g.dart';

/// ホームの地震履歴カードで表示する対象
@JsonEnum(alwaysCreate: true)
enum HomeEarthquakeHistoryScope {
  /// 全国の地震一覧
  @JsonValue('nationwide')
  nationwide,

  /// 現在地（市区町村）に関連する地震
  @JsonValue('currentLocation')
  currentLocation,

  /// 設定で指定した地域
  @JsonValue('custom')
  custom,
}

/// ホーム地図の EEW 塗りつぶしモード
@JsonEnum(alwaysCreate: true)
enum HomeEewFillMode {
  /// 各地域の予想震度で塗りつぶし
  @JsonValue('intensity')
  intensity,

  /// 警報地域を塗りつぶし
  @JsonValue('warning')
  warning,

  /// 塗りつぶしなし
  @JsonValue('none')
  none,
}

/// P/S 波アニメーションの更新レート
@JsonEnum(alwaysCreate: true)
enum HomeEewAnimationRate {
  @JsonValue('unlimited')
  unlimited,

  @JsonValue('oneHz')
  oneHz,
}

/// 強震モニタ観測点の表示サイズ（ホーム地図）
@JsonEnum(alwaysCreate: true)
enum HomeKmoniMarkerSize {
  @JsonValue('small')
  small,

  @JsonValue('medium')
  medium,

  @JsonValue('large')
  large,
}

/// 揺れ検知のアニメーションモード
@JsonEnum(alwaysCreate: true)
enum HomeShakeDetectionAnimationMode {
  /// EEW と同周期で点滅
  @JsonValue('blink')
  blink,

  /// EEW と同周期で明滅（フェード）
  @JsonValue('fade')
  fade,

  /// 常時点灯
  @JsonValue('solid')
  solid,
}

/// ホーム地図のデフォルト表示範囲（EEW なし時のホーム等）
@JsonEnum(alwaysCreate: true)
enum HomeMapDefaultBounds {
  /// 九州〜北海道（沖縄除く）
  @JsonValue('mainIsland')
  mainIsland,

  /// 日本全域（沖縄含む）
  @JsonValue('all')
  all,

  /// ユーザーが保存した矩形
  @JsonValue('custom')
  custom,
}

@freezed
abstract class HomeShakeDetectionSettings with _$HomeShakeDetectionSettings {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory({
    @Default(true) bool show,
    @Default(HomeShakeDetectionAnimationMode.blink)
    HomeShakeDetectionAnimationMode animationMode,
  }) = _HomeShakeDetectionSettings;

  factory fromJson(Map<String, dynamic> json) =>
      _$HomeShakeDetectionSettingsFromJson(json);
}

@freezed
abstract class HomeEewSettings with _$HomeEewSettings {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory({
    @Default(HomeEewFillMode.intensity) HomeEewFillMode fillMode,
    @Default(HomeEewAnimationRate.unlimited) HomeEewAnimationRate animationRate,
    @Default(true) bool autoZoom,
    @Default(true) bool showPSWaveCircle,
  }) = _HomeEewSettings;

  factory fromJson(Map<String, dynamic> json) =>
      _$HomeEewSettingsFromJson(json);
}

@freezed
abstract class HomeKyoshinMonitorSettings with _$HomeKyoshinMonitorSettings {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory({
    @Default(null) double? minRealtimeShindo,
    @Default(HomeKmoniMarkerSize.medium) HomeKmoniMarkerSize markerSize,
  }) = _HomeKyoshinMonitorSettings;

  factory fromJson(Map<String, dynamic> json) =>
      _$HomeKyoshinMonitorSettingsFromJson(json);
}

@freezed
abstract class HomeMapGridSettings with _$HomeMapGridSettings {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory({@Default(false) bool enabled}) =
      _HomeMapGridSettings;

  factory fromJson(Map<String, dynamic> json) =>
      _$HomeMapGridSettingsFromJson(json);
}

@freezed
abstract class HomeMapSettings with _$HomeMapSettings {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory({
    @Default(null) double? maxZoom,
    @Default(HomeMapDefaultBounds.mainIsland)
    HomeMapDefaultBounds defaultBounds,
    @LatLngBoundaryJsonConverter() LatLngBoundary? customBounds,
    @Default(false) bool lockBearing,
  }) = _HomeMapSettings;

  factory fromJson(Map<String, dynamic> json) =>
      _$HomeMapSettingsFromJson(json);
}

@freezed
abstract class HomeCommonSettings with _$HomeCommonSettings {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory({
    @Default(false) bool showLocation,
    @Default(HomeEarthquakeHistoryScope.nationwide)
    HomeEarthquakeHistoryScope earthquakeHistoryScope,
    EarthquakeHistoryParameter? parameter,
  }) = _HomeCommonSettings;

  factory fromJson(Map<String, dynamic> json) =>
      _$HomeCommonSettingsFromJson(json);
}

@freezed
abstract class HomeConfigurationModel with _$HomeConfigurationModel {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory({
    @Default(HomeEewSettings()) HomeEewSettings eew,
    @Default(HomeKyoshinMonitorSettings())
    HomeKyoshinMonitorSettings kyoshinMonitor,
    @Default(HomeMapSettings()) HomeMapSettings map,
    @Default(HomeCommonSettings()) HomeCommonSettings common,
    @Default(HomeShakeDetectionSettings())
    HomeShakeDetectionSettings shakeDetection,
    @Default(HomeMapGridSettings()) HomeMapGridSettings mapGrid,
  }) = _HomeConfigurationModel;

  factory fromJson(Map<String, dynamic> json) =>
      _$HomeConfigurationModelFromJson(json);
}
