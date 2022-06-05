import 'observation/station.dart';

/// 津波の観測値に関する情報を本要素に記載します。
/// VTSE51や、VTSE52に出現します。
/// 1.2 observation
class Observation {
  ///津波予報区コード
  ///VTSE52の場合は`Null`とします
  ///コードは、気象庁防災情報XMLフォーマット コード表 地震火山関連コード表 による
  final int? code;

  /// 津波予報区名
  /// VTSE52の場合はNullとします
  final String? name;

  /// 潮位観測点の満潮時刻と津波の到達予想時刻
  /// [#1.2.3. station](https://dmdata.jp/doc/reference/conversion/json/schema/tsunami-information#1-2-3-station)
  final List<Station> stations;

  Observation({
    required this.code,
    required this.name,
    required this.stations,
  });

  Observation.fromJson(Map<String, dynamic> j)
      : code = (j['code'].toString() == "")
            ? null
            : int.parse(j['code'].toString()),
        name = (j['name'].toString() == "") ? null : j['name'].toString(),
        stations = List<Station>.generate(
            (j['stations'] as List<dynamic>).length,
            (index) => Station.fromJson((j['stations'] as List<dynamic>)[index]
                as Map<String, dynamic>));
}
