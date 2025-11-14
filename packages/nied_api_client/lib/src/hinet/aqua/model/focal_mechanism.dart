import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nied_api_client/src/hinet/aqua/model/angle_pair.dart';

part 'focal_mechanism.freezed.dart';
part 'focal_mechanism.g.dart';

/// 発震機構解 (Focal Mechanism)
/// 地震のメカニズム解を表す2つの節面で構成されます
@freezed
abstract class FocalMechanism with _$FocalMechanism {
  /// 発震機構解を作成
  const factory FocalMechanism({
    /// 傾斜角(δ)
    ///
    /// 水平面から下向きに測る
    required AnglePair tiltAngle,

    /// すべり角(λ)
    ///
    /// すべりの方向を水平面から半時計回りに測る
    required AnglePair slipAngle,

    /// 走向(θ)
    ///
    /// 北から時計回りに測る
    required AnglePair strikeAngle,
  }) = _FocalMechanism;

  /// JSONからデシリアライズ
  factory FocalMechanism.fromJson(Map<String, dynamic> json) =>
      _$FocalMechanismFromJson(json);
}
