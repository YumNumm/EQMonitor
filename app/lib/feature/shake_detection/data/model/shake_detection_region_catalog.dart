import 'package:eqmonitor/feature/parameter/data/model/kyoshin/kyoshin_observation_points_parameter.dart';

/// 揺れ検知の範囲を要約するための、観測点と地域名の対応。
final class const ShakeDetectionRegionCatalog({
  /// 検知対象のすべての観測点。地域の全体を知るために使う。
  required final List<KyoshinObservationPoint> stations,

  /// 都道府県コードから都道府県名への対応。
  required final Map<String, String> prefectureNames,

  /// 地震情報の細分区域コードから地域名への対応。
  required final Map<String, String> regionNames,
});
