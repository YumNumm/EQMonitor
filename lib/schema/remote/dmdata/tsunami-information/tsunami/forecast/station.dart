import 'firstHeight.dart';

/// 潮位観測点の満潮時刻と津波の到達予想時刻を表現します。

class Station {
  Station({
    required this.code,
    required this.name,
    required this.highTideDateTime,
    required this.firstHeight,
  });
  Station.fromJson(Map<String, dynamic> j)
      : code = int.parse(j['code'].toString()),
        name = j['name'].toString(),
        highTideDateTime = DateTime.parse(j['highTideDateTime'].toString()),
        firstHeight =
            FirstHeight.fromJson(j['firstHeight'] as Map<String, dynamic>);

  /// 潮位観測点コード
  /// コードは、気象庁防災情報XMLフォーマット コード表 地震火山関連コード表 による
  final int code;

  /// 潮位観測点名
  final String name;

  /// 満潮時刻、ISO8601の日本時間で記載する
  final DateTime highTideDateTime;

  /// 潮位観測点に対しての津波の到達予想時刻
  final FirstHeight firstHeight;
}
