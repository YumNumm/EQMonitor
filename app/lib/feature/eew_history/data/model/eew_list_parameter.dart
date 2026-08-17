import 'package:core/core.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'eew_list_parameter.freezed.dart';
part 'eew_list_parameter.g.dart';

/// `GET /v2/eew` に渡すクエリ値。すべて文字列化済み(intensity は API enum)。
typedef EewQuery = ({
  String limit,
  String? cursor,
  String? magnitudeGte,
  String? magnitudeLte,
  String? depthGte,
  String? depthLte,
  api.JmaIntensity? intensityGte,
  api.JmaIntensity? intensityLte,
  String? originTimeGte,
  String? originTimeLte,
  String? isWarning,
});

@freezed
abstract class EewListParameter with _$EewListParameter {
  const factory({
    double? magnitudeGte,
    double? magnitudeLte,
    int? depthGte,
    int? depthLte,
    JmaIntensity? intensityGte,
    JmaIntensity? intensityLte,
    Date? originTimeGte,
    Date? originTimeLte,
    bool? isWarning,
  }) = _EewListParameter;

  const new _();

  factory fromJson(Map<String, dynamic> json) =>
      _$EewListParameterFromJson(json);

  bool get isFiltering => this != const EewListParameter();

  EewQuery toQuery({required String? cursor, required int limit}) => (
    limit: limit.toString(),
    cursor: cursor,
    magnitudeGte: magnitudeGte?.toString(),
    magnitudeLte: magnitudeLte?.toString(),
    depthGte: depthGte?.toString(),
    depthLte: depthLte?.toString(),
    intensityGte: intensityGte?.toApiJmaIntensity,
    intensityLte: intensityLte?.toApiJmaIntensity,
    originTimeGte: originTimeGte?.toString(),
    originTimeLte: originTimeLte?.toString(),
    isWarning: isWarning?.toString(),
  );
}

extension EewListParameterEx on EewListParameter {
  EewListParameter updateMagnitude(double? min, double? max) =>
      copyWith(magnitudeGte: min, magnitudeLte: max);

  EewListParameter updateDepth(int? min, int? max) =>
      copyWith(depthGte: min, depthLte: max);

  EewListParameter updateIntensity(JmaIntensity? min, JmaIntensity? max) =>
      copyWith(intensityGte: min, intensityLte: max);

  EewListParameter updateOriginTimeRange(Date? gte, Date? lte) =>
      copyWith(originTimeGte: gte, originTimeLte: lte);

  /// 警報のみトグル。false は「全件表示」を意味するため null 化する。
  EewListParameter updateIsWarning({required bool value}) =>
      copyWith(isWarning: value ? true : null);
}
