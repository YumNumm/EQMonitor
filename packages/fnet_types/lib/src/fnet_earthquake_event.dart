import 'package:freezed_annotation/freezed_annotation.dart';

part 'fnet_earthquake_event.freezed.dart';
part 'fnet_earthquake_event.g.dart';

/// F-net地震イベント
@freezed
class FnetEarthquakeEvent with _$FnetEarthquakeEvent {
  const factory FnetEarthquakeEvent({
    /// 発生時刻 (UTC)
    required DateTime originTime,

    /// 緯度 (度)
    required double latitude,

    /// 経度 (度)
    required double longitude,

    /// JMA震源の深さ (km)
    required double jmaDepth,

    /// JMAマグニチュード (Mj)
    required double jmaMagnitude,

    /// 地域名
    required String regionName,

    /// 断層面の走向 (度) - 2つの可能な値
    required FaultParameterPair strike,

    /// 断層面の傾斜角 (度) - 2つの可能な値
    required FaultParameterPair dip,

    /// 断層面のすべり角 (度) - 2つの可能な値
    required FaultParameterPair rake,

    /// 地震モーメント (Nm)
    required double seismicMoment,

    /// モーメントテンソル解の震源深さ (km)
    required double mtDepth,

    /// モーメントマグニチュード (Mw)
    required double mtMagnitude,

    /// バリアンス・リダクション (%)
    required double varianceReduction,

    /// モーメントテンソル成分
    required MomentTensor momentTensor,

    /// モーメントテンソルの単位 (Nm)
    required double unit,

    /// 使用観測点数
    required int numberOfStations,
  }) = _FnetEarthquakeEvent;

  factory FnetEarthquakeEvent.fromJson(Map<String, dynamic> json) =>
      _$FnetEarthquakeEventFromJson(json);
}

/// 断層パラメータのペア（2つの可能な断層面解）
@freezed
class FaultParameterPair with _$FaultParameterPair {
  const factory FaultParameterPair({
    required double plane1,
    required double plane2,
  }) = _FaultParameterPair;

  factory FaultParameterPair.fromJson(Map<String, dynamic> json) =>
      _$FaultParameterPairFromJson(json);

  /// セミコロン区切りの文字列からパースする
  factory FaultParameterPair.parse(String value) {
    final parts = value.split(';');
    if (parts.length != 2) {
      throw FormatException('Invalid fault parameter format: $value');
    }
    return FaultParameterPair(
      plane1: double.parse(parts[0]),
      plane2: double.parse(parts[1]),
    );
  }
}

/// モーメントテンソル成分
@freezed
class MomentTensor with _$MomentTensor {
  const factory MomentTensor({
    required double mxx,
    required double mxy,
    required double mxz,
    required double myy,
    required double myz,
    required double mzz,
  }) = _MomentTensor;

  factory MomentTensor.fromJson(Map<String, dynamic> json) =>
      _$MomentTensorFromJson(json);
}
