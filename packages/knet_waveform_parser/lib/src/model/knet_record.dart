import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:knet_waveform_parser/src/model/knet_channel_direction.dart';
import 'package:knet_waveform_parser/src/model/knet_network_type.dart';

part 'knet_record.freezed.dart';
part 'knet_record.g.dart';

/// K-NET/KiK-net 強震記録（ASCII フォーマット）
@freezed
abstract class KnetRecord with _$KnetRecord {
  const factory({
    /// 地震情報（即時公開データでは null）
    required KnetEarthquakeInfo? earthquakeInfo,

    /// 観測点情報
    required KnetStationInfo stationInfo,

    /// 記録開始時刻（JST）
    required DateTime recordTime,

    /// サンプリング周波数 (Hz)
    required double samplingFrequencyHz,

    /// 計測時間 (秒)
    required double durationTimeSec,

    /// チャンネル方向
    required KnetChannelDirection direction,

    /// スケール係数の分子
    required double scaleFactorNumerator,

    /// スケール係数の分母
    required double scaleFactorDenominator,

    /// 最大加速度 (gal)
    required double maxAccelerationGal,

    /// 最終補正時刻
    required DateTime? lastCorrection,

    /// メモ
    required String memo,

    /// 波形データ（生デジタル値）
    required List<int> rawData,

    /// ネットワーク種別
    required KnetNetworkType networkType,
  }) = _KnetRecord;

  const new _();

  factory fromJson(Map<String, dynamic> json) =>
      _$KnetRecordFromJson(json);

  /// スケールファクタ（分子/分母）
  double get scaleFactor => scaleFactorNumerator / scaleFactorDenominator;

  /// 加速度波形 (gal)
  List<double> get accelerationGal =>
      rawData.map((v) => v * scaleFactor).toList();
}

/// 地震情報
@freezed
abstract class KnetEarthquakeInfo with _$KnetEarthquakeInfo {
  const factory({
    /// 地震発生時刻
    required DateTime originTime,

    /// 震源緯度 (度)
    required double latitude,

    /// 震源経度 (度)
    required double longitude,

    /// 震源深さ (km)
    required double depthKm,

    /// マグニチュード
    required double magnitude,
  }) = _KnetEarthquakeInfo;

  factory fromJson(Map<String, dynamic> json) =>
      _$KnetEarthquakeInfoFromJson(json);
}

/// 観測点情報
@freezed
abstract class KnetStationInfo with _$KnetStationInfo {
  const factory({
    /// 観測点コード
    required String stationCode,

    /// 観測点緯度 (度)
    required double latitude,

    /// 観測点経度 (度)
    required double longitude,

    /// 観測点標高 (m)
    required double heightM,
  }) = _KnetStationInfo;

  factory fromJson(Map<String, dynamic> json) =>
      _$KnetStationInfoFromJson(json);
}
