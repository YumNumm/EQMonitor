import 'package:eqmonitor/feature/kyoshin_monitor/data/service/kyoshin_monitor_delay_adjust_service.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kyoshin_monitor_api/kyoshin_monitor_api.dart';

part 'kyoshin_monitor_settings_model.freezed.dart';
part 'kyoshin_monitor_settings_model.g.dart';

@freezed
abstract class KyoshinMonitorSettingsModel with _$KyoshinMonitorSettingsModel {
  const factory({
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

  factory fromJson(Map<String, dynamic> json) =>
      _$KyoshinMonitorSettingsModelFromJson(json);
}

extension KyoshinMonitorSettingsModelX on KyoshinMonitorSettingsModel {
  RealtimeLayer get effectiveRealtimeLayer =>
      realtimeDataType.isLpgm ? RealtimeLayer.surface : realtimeLayer;

  bool get canSelectRealtimeLayer => useKmoni && !realtimeDataType.isLpgm;
}

@freezed
abstract class KyoshinMonitorSettingsApiModel
    with _$KyoshinMonitorSettingsApiModel {
  const factory({
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

    /// `latest.json` の再同期間隔
    ///
    /// 長周期地震動モニタの公式フロントエンドと同じ60秒。
    /// 端末時計のドリフトは NTP 側で吸収されるが、サーバの公開遅延の
    /// 変動を追うためにここでも定期的に測り直す。
    @Default(Duration(seconds: 60)) Duration delayAdjustInterval,

    /// 遅延調整の方式
    @Default(KyoshinMonitorDelayAdjustType.imageFetch404Ntp)
    @JsonKey(unknownEnumValue: KyoshinMonitorDelayAdjustType.imageFetch404Ntp)
    KyoshinMonitorDelayAdjustType delayAdjustType,

    /// 画像取得の404をもとにオフセットを自動調整するかどうか
    @Default(true) bool autoOffsetIncrement,

    /// データソース別の、`latest.json` 実測値からの補正量。
    ///
    /// 強震モニタと長周期地震動モニタでは画像の公開遅延が約 0.66 秒違う
    /// (実測: 1.23s と 0.57s) ため、共通の値にすると切り替えのたびに
    /// 再収束のための 404 が発生する。永続化して次回起動時も引き継ぐ。
    @Default(<KyoshinMonitorSource, Duration>{})
    Map<KyoshinMonitorSource, Duration> offsetAdjustments,

    /// 公開遅延の下限
    @Default(Duration(milliseconds: 600)) Duration minOffset,

    /// 公開遅延の上限
    @Default(Duration(milliseconds: 5000)) Duration maxOffset,
  }) = _KyoshinMonitorSettingsApiModel;

  factory fromJson(Map<String, dynamic> json) =>
      _$KyoshinMonitorSettingsApiModelFromJson(json);
}

extension KyoshinMonitorSettingsApiModelX on KyoshinMonitorSettingsApiModel {
  KyoshinMonitorDelayAdjustConfig get delayAdjustConfig =>
      KyoshinMonitorDelayAdjustConfig(
        minOffset: minOffset,
        maxOffset: maxOffset,
      );
}

@JsonEnum(valueField: 'url')
enum KyoshinMonitorEndpoint {
  kmoni('http://www.kmoni.bosai.go.jp'),
  lmoniexp('https://smi.lmoniexp.bosai.go.jp');

  new(this.url);

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
