import 'firstHeight.dart';
import 'maxHeight.dart';

/// 潮位観測点の満潮時刻と津波の到達予想時刻を表現します。
/// 1.1.6 station
class Station {
  Station.fromJson(Map<String, dynamic> j)
      : code = int.parse(j['code'].toString()),
        name = j['name'].toString(),
        sensor = (j['sensor'] == null) ? null : j['sensor'].toString(),
        firstHeight =
            FirstHeight.fromJson(j['firstHeight'] as Map<String, dynamic>),
        maxHeight = MaxHeight.fromJson(j['maxHeight'] as Map<String, dynamic>);
  Station({
    required this.code,
    required this.name,
    required this.sensor,
    required this.firstHeight,
    required this.maxHeight,
  });

  /// 潮位観測点コード
  /// コードは、気象庁防災情報XMLフォーマット コード表 地震火山関連コード表 による
  final int code;

  /// 潮位観測点名
  final String name;

  /// GPS波浪計や圧力計などの特殊な観測機器の名称を記載する
  /// 特殊な観測機器の場合に出現
  final String? sensor;

  /// 第一波の到達時刻
  /// [#1.2.3.4 first height](https://dmdata.jp/doc/reference/conversion/json/schema/tsunami-information#1-2-3-4-first-height)
  final FirstHeight firstHeight;

  /// 津波の最大波を観測した値
  /// [#1.2.3.5. max height](https://dmdata.jp/doc/reference/conversion/json/schema/tsunami-information#1-2-3-5-max-height)
  final MaxHeight maxHeight;
}
