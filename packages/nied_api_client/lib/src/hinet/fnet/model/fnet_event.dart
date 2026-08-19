import 'package:freezed_annotation/freezed_annotation.dart';

part 'fnet_event.freezed.dart';
part 'fnet_event.g.dart';

/// F-netの地震イベント
@freezed
abstract class FnetEvent with _$FnetEvent {
  const factory({
    /// 発生時刻(UT)
    required DateTime originTime,

    /// 緯度（度）
    required double latitude,

    /// 経度（度）
    required double longitude,

    /// JMA深さ（km）
    required double jmaDepth,

    /// JMAマグニチュード（Mj）
    required double jmaMagnitude,

    /// 地域名
    required String regionName,

    /// 走向（Strike）- 2つの値
    required FnetAnglePair strike,

    /// 傾斜（Dip）- 2つの値
    required FnetAnglePair dip,

    /// すべり角（Rake）- 2つの値
    required FnetAnglePair rake,

    /// 地震モーメント（Nm）
    required double seismicMoment,

    /// モーメントテンソル深さ（km）
    required double mtDepth,

    /// モーメントマグニチュード（Mw）
    required double momentMagnitude,

    /// 分散低減率（%）
    required double varianceReduction,

    /// モーメントテンソル成分
    required FnetMomentTensor momentTensor,

    /// 単位（Nm）
    required double unit,

    /// 観測点数
    required int numberOfStations,
  }) = _FnetEvent;

  factory fromJson(Map<String, dynamic> json) =>
      _$FnetEventFromJson(json);
}

/// 角度のペア（2つの節面を表す）
@freezed
abstract class FnetAnglePair with _$FnetAnglePair {
  const factory({
    required double plane1,
    required double plane2,
  }) = _FnetAnglePair;

  factory fromJson(Map<String, dynamic> json) =>
      _$FnetAnglePairFromJson(json);

  /// 文字列からパース（例: "68;181"）
  factory fromString(String value) {
    final parts = value.split(';');
    if (parts.length != 2) {
      throw FormatException('Invalid angle pair format: $value');
    }
    return FnetAnglePair(
      plane1: double.parse(parts[0]),
      plane2: double.parse(parts[1]),
    );
  }
}

/// モーメントテンソル成分
@freezed
abstract class FnetMomentTensor with _$FnetMomentTensor {
  const factory({
    required double mxx,
    required double mxy,
    required double mxz,
    required double myy,
    required double myz,
    required double mzz,
  }) = _FnetMomentTensor;

  factory fromJson(Map<String, dynamic> json) =>
      _$FnetMomentTensorFromJson(json);
}
