import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kyoshin_monitor_api/kyoshin_monitor_api.dart';

part 'kyoshin_monitor_settings_model.freezed.dart';
part 'kyoshin_monitor_settings_model.g.dart';

@freezed
abstract class KyoshinMonitorSettingsModel with _$KyoshinMonitorSettingsModel {
  const factory KyoshinMonitorSettingsModel({
    /// 強震モニタの表示最低リアルタイム震度
    @Default(null) double? minRealtimeShindo,

    /// スケールを表示するかどうか
    @Default(true) bool showScale,

    /// 強震モニタを使用するかどうか
    @Default(true) bool useKmoni,

    /// 強震モニタ観測点のマーカーの種類
    @Default(KyoshinMonitorMarkerType.onlyEew)
    KyoshinMonitorMarkerType kmoniMarkerType,

    /// データソース (強震モニタ / 長周期地震動モニタ)
    @Default(KyoshinMonitorSource.kmoni)
    @JsonKey(unknownEnumValue: KyoshinMonitorSource.kmoni)
    KyoshinMonitorSource monitorSource,

    /// 強震モニタのリアルタイムデータの種類
    @Default(RealtimeDataType.shindo) RealtimeDataType realtimeDataType,

    /// 強震モニタのリアルタイムデータのレイヤー
    @Default(RealtimeLayer.surface) RealtimeLayer realtimeLayer,

    /// 強震モニタ API関連の設定
    @Default(KyoshinMonitorSettingsApiModel())
    KyoshinMonitorSettingsApiModel api,
  }) = _KyoshinMonitorSettingsModel;

  factory KyoshinMonitorSettingsModel.fromJson(Map<String, dynamic> json) =>
      _$KyoshinMonitorSettingsModelFromJson(json);
}

@freezed
abstract class KyoshinMonitorSettingsApiModel
    with _$KyoshinMonitorSettingsApiModel {
  const factory KyoshinMonitorSettingsApiModel({
    /// 強震モニタ APIのベースURL
    @Default(KyoshinMonitorEndpoint.kmoni)
    @JsonKey(unknownEnumValue: KyoshinMonitorEndpoint.kmoni)
    KyoshinMonitorEndpoint endpoint,

    /// 画像取得頻度
    @Default(Duration(seconds: 1))
    @Assert(
      'imageFetchInterval.inSeconds > 1',
      'imageFetchInterval must be greater than 1 second',
    )
    Duration imageFetchInterval,

    /// 遅延調整間隔
    @Default(Duration(minutes: 10)) Duration delayAdjustInterval,
  }) = _KyoshinMonitorSettingsApiModel;

  factory KyoshinMonitorSettingsApiModel.fromJson(Map<String, dynamic> json) =>
      _$KyoshinMonitorSettingsApiModelFromJson(json);
}

@JsonEnum(valueField: 'url')
enum KyoshinMonitorEndpoint {
  kmoni('http://www.kmoni.bosai.go.jp'),
  lmoniexp('https://smi.lmoniexp.bosai.go.jp');

  const KyoshinMonitorEndpoint(this.url);

  final String url;
}

/// データソースの種類
enum KyoshinMonitorSource {
  /// 強震モニタ (K-NET / KiK-net)
  kmoni,

  /// 長周期地震動モニタ (長周期地震動階級など追加データ種別あり)
  lmoni,
}

enum KyoshinMonitorMarkerType {
  /// 常に枠を表示する
  always,

  /// EEW時のみ枠を表示する
  onlyEew,

  /// 常に枠を表示しない
  never,
}
