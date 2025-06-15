import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kyoshin_monitor_api/src/model/result.dart';
import 'package:kyoshin_monitor_api/src/model/security.dart';
import 'package:kyoshin_monitor_api/src/model/web_api/jma_intensity.dart';
import 'package:kyoshin_monitor_api/src/model/web_api/kyoshin_monitor_web_api_response.dart';
import 'package:kyoshin_monitor_api/src/util/json_converters.dart';

part 'eew.freezed.dart';
part 'eew.g.dart';

/// Web版APIでの緊急地震速報の情報
@freezed
abstract class Eew with _$Eew implements KyoshinMonitorWebApiResponse {
  const factory Eew({
    /// リザルト
    Result? result,

    /// 発報時間
    @JsonKey(fromJson: dateTimeOrNullFromString, toJson: dateTimeOrNullToString)
    DateTime? reportTime,

    /// 地域コード
    String? regionCode,

    /// リクエスト時間
    String? requestTime,

    /// 地域名
    String? regionName,

    /// 経度
    @JsonKey(fromJson: doubleOrNullFromString, toJson: doubleOrNullToString)
    double? longitude,

    /// キャンセル報か
    @JsonKey(name: 'is_cancel', fromJson: boolFromDynamic) bool? isCancel,

    /// 震源の深さ
    @JsonKey(fromJson: depthFromString, toJson: depthToString) int? depth,

    /// 予想最大震度
    @JsonKey(name: 'calcintensity', fromJson: JmaIntensity.fromString)
    JmaIntensity? intensity,

    /// 最終報か
    @JsonKey(name: 'is_final', fromJson: boolFromDynamic) bool? isFinal,

    /// 訓練報か
    @JsonKey(name: 'isTraining', fromJson: boolFromDynamic) bool? isTraining,

    /// 緯度
    @JsonKey(fromJson: doubleOrNullFromString, toJson: doubleOrNullToString)
    double? latitude,

    /// 発生時間
    @JsonKey(name: 'origin_time', fromJson: originTimeFromString)
    DateTime? originTime,

    /// セキュリティ情報
    Security? security,

    /// マグニチュード
    @JsonKey(fromJson: doubleOrNullFromString, toJson: doubleOrNullToString)
    double? magnitude,

    /// 発報番号
    @JsonKey(name: 'report_num', fromJson: intFromString, toJson: intToString)
    int? reportNum,

    /// なにこれ?
    String? requestHypoType,

    /// 地震ID
    String? reportId,

    /// 警報 or 予報
    @JsonKey(name: 'alertflg') String? alertFlag,
  }) = _Eew;
  const Eew._();

  factory Eew.fromJson(Map<String, dynamic> json) => _$EewFromJson(json);

  /// 震源の座標
  Location? get location {
    if (latitude != null && longitude != null) {
      return Location(latitude!, longitude!);
    }
    return null;
  }

  /// 警報か
  bool get isAlert => alertFlag == '警報';
}

/// 位置情報
class Location {
  const Location(this.latitude, this.longitude);

  final double latitude;
  final double longitude;
}
