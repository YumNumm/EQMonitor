import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../const/kmoni/jma_intensity.dart';

part 'analyzed_point_model.freezed.dart';

@freezed
class AnalyzedPoint with _$AnalyzedPoint {
  const factory AnalyzedPoint({
    /// 観測点コード
    required String code,

    /// 観測点名
    required String name,

    /// 都道府県
    required String prefectureName,

    /// 緯度
    required double lat,

    /// 経度
    required double lon,

    /// リアルタイム震度
    required double? shindo,

    /// リアルタイム震度の色
    required Color? shindoColor,

    /// リアルタイム加速度(PGA)
    required double? pga,

    /// リアルタイム加速度(PGA)の色
    required Color? pgaColor,

    /// アプリ起動中に震度 もしくは PGAが値を持っていたかどうか
    required bool hadValue,

    /// リアルタイム震度をJMA-Intensityに変換したもの
    required JmaIntensity? intensity,
  }) = _AnalyzedPoint;
}
