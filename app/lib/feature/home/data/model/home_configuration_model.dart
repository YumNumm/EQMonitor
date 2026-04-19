import 'package:freezed_annotation/freezed_annotation.dart';

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
  @JsonValue('designatedRegion')
  designatedRegion,
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
abstract class HomeEewSettings with _$HomeEewSettings {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory HomeEewSettings({
    @Default(HomeEewFillMode.intensity) HomeEewFillMode fillMode,
    @Default(HomeEewAnimationRate.unlimited) HomeEewAnimationRate animationRate,
    @Default(true) bool autoZoom,
    @Default(true) bool showPSWaveCircle,
  }) = _HomeEewSettings;

  factory HomeEewSettings.fromJson(Map<String, dynamic> json) =>
      _$HomeEewSettingsFromJson(json);
}

@freezed
abstract class HomeKyoshinMonitorSettings with _$HomeKyoshinMonitorSettings {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory HomeKyoshinMonitorSettings({
    @Default(null) double? minRealtimeShindo,
    @Default(HomeKmoniMarkerSize.medium) HomeKmoniMarkerSize markerSize,
  }) = _HomeKyoshinMonitorSettings;

  factory HomeKyoshinMonitorSettings.fromJson(Map<String, dynamic> json) =>
      _$HomeKyoshinMonitorSettingsFromJson(json);
}

/// ホーム地図のユーザー保存表示範囲（[HomeMapDefaultBounds.custom] 用）
class HomeMapCustomBounds {
  const HomeMapCustomBounds({
    required this.longitudeWest,
    required this.longitudeEast,
    required this.latitudeSouth,
    required this.latitudeNorth,
  });

  factory HomeMapCustomBounds.fromJson(Map<String, dynamic> json) {
    return HomeMapCustomBounds(
      longitudeWest: (json['longitude_west'] as num).toDouble(),
      longitudeEast: (json['longitude_east'] as num).toDouble(),
      latitudeSouth: (json['latitude_south'] as num).toDouble(),
      latitudeNorth: (json['latitude_north'] as num).toDouble(),
    );
  }

  final double longitudeWest;
  final double longitudeEast;
  final double latitudeSouth;
  final double latitudeNorth;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'longitude_west': longitudeWest,
    'longitude_east': longitudeEast,
    'latitude_south': latitudeSouth,
    'latitude_north': latitudeNorth,
  };
}

HomeMapCustomBounds? _nullableCustomBoundsFromJson(Object? json) {
  if (json == null) {
    return null;
  }
  if (json is! Map<String, dynamic>) {
    return null;
  }
  if (json.isEmpty) {
    return null;
  }
  if (json['longitude_west'] == null) {
    return null;
  }
  return HomeMapCustomBounds.fromJson(json);
}

Map<String, dynamic>? _nullableCustomBoundsToJson(HomeMapCustomBounds? v) =>
    v?.toJson();

@freezed
abstract class HomeMapSettings with _$HomeMapSettings {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory HomeMapSettings({
    @Default(null) double? maxZoom,
    @Default(HomeMapDefaultBounds.mainIsland)
    HomeMapDefaultBounds defaultBounds,
    @JsonKey(
      fromJson: _nullableCustomBoundsFromJson,
      toJson: _nullableCustomBoundsToJson,
    )
    @Default(null)
    HomeMapCustomBounds? customBounds,
    @Default(false) bool lockBearing,
  }) = _HomeMapSettings;

  factory HomeMapSettings.fromJson(Map<String, dynamic> json) =>
      _$HomeMapSettingsFromJson(json);
}

@freezed
abstract class HomeCommonSettings with _$HomeCommonSettings {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory HomeCommonSettings({
    @Default(false) bool showLocation,
    @Default(HomeEarthquakeHistoryScope.nationwide)
    HomeEarthquakeHistoryScope earthquakeHistoryScope,
  }) = _HomeCommonSettings;

  factory HomeCommonSettings.fromJson(Map<String, dynamic> json) =>
      _$HomeCommonSettingsFromJson(json);
}

@freezed
abstract class HomeConfigurationModel with _$HomeConfigurationModel {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory HomeConfigurationModel({
    @Default(HomeEewSettings()) HomeEewSettings eew,
    @JsonKey(name: 'kyoshin_monitor')
    @Default(HomeKyoshinMonitorSettings())
    HomeKyoshinMonitorSettings kyoshinMonitor,
    @Default(HomeMapSettings()) HomeMapSettings map,
    @Default(HomeCommonSettings()) HomeCommonSettings common,
  }) = _HomeConfigurationModel;

  factory HomeConfigurationModel.fromJson(Map<String, dynamic> json) =>
      _$HomeConfigurationModelFromJson(_migrateHomeConfigurationJson(json));
}

/// 旧フォーマット（トップレベル `show_location` 等）をネスト構造へ移行する。
Map<String, dynamic> _migrateHomeConfigurationJson(Map<String, dynamic> json) {
  if (json.containsKey('common')) {
    return json;
  }
  return <String, dynamic>{
    'eew': <String, dynamic>{},
    'kyoshin_monitor': <String, dynamic>{},
    'map': <String, dynamic>{},
    'common': <String, dynamic>{
      'show_location': json['show_location'] ?? false,
      'earthquake_history_scope':
          json['earthquake_history_scope'] ?? 'nationwide',
    },
  };
}
