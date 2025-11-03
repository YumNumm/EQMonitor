import 'package:core/core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nied_api_client/src/hinet/aqua/model/aqua_event_type.dart';
import 'package:nied_api_client/src/hinet/aqua/model/focal_mechanism.dart';
import 'package:timezone/timezone.dart';

part 'aqua_event.freezed.dart';
part 'aqua_event.g.dart';

/// AQUA解析イベント
///
/// 防災科学技術研究所のAQUAシステム（Accurate and QUick Analysis System for Source Parameters）
/// によって解析された地震イベントを表します
@freezed
abstract class AquaEvent with _$AquaEvent {
  /// AQUA解析イベントを作成
  const factory AquaEvent({
    /// イベントID (yyyyMMddHHmmss形式)
    ///
    /// 地震発生日時を表す14桁の数字
    /// 例: 20251103000018 = 2025年11月3日 00時00分18秒
    required String id,

    /// 発生日時
    ///
    /// 地震の発生時刻（震源時）
    /// JST時刻
    /// ただし、typeがCMTの場合は、セントロイドの時刻を表す
    @TZDateTimeJstJsonConverter() required TZDateTime originTime,

    /// 震央地名
    ///
    /// 震源の位置を表す地名
    /// 例: "福島県沖", "Off Fukushima Prefecture"
    required String region,

    /// 緯度 (度)
    ///
    /// 震源の緯度（北緯が正）
    /// ただし、typeがCMTの場合は、セントロイドの緯度を表す
    required double latitude,

    /// 経度 (度)
    ///
    /// 震源の経度（東経が正）
    /// ただし、typeがCMTの場合は、セントロイドの経度を表す
    required double longitude,

    /// 深さ (km)
    ///
    /// 震源の深さ（地表面からの距離）
    /// ただし、typeがCMTの場合は、セントロイドの深さを表す
    required double depth,

    /// モーメントマグニチュード (Mw)
    ///
    /// 地震のエネルギー規模を表すマグニチュード
    required double magnitude,

    /// 発震機構解
    ///
    /// 地震のメカニズム解
    /// nullの場合、発震機構解が求められなかったことを示します
    required FocalMechanism? focalMechanism,

    /// Variance Reduction (%)
    ///
    /// 観測波形と計算波形の二乗残渣を観測波形振幅で正規化し、その値を1から引いた値
    /// 80%以上だとかなり良く、50%程度であれば妥当な解と言える。20%以下の解は信用できない
    required double? varianceReduction,

    /// 使用観測点数
    ///
    /// 解析に使用された観測点の数
    required int stationCount,

    /// 解析タイプ
    ///
    /// AQUA-CMT（セントロイドモーメントテンソル）または
    /// AQUA-MT（モーメントテンソル）
    required AquaEventType type,
  }) = _AquaEvent;

  /// JSONからデシリアライズ
  factory AquaEvent.fromJson(Map<String, dynamic> json) =>
      _$AquaEventFromJson(json);
}
