import 'estimation/firstHeight.dart';
import 'estimation/maxHeight.dart';

/// 沖合の潮位観測点で観測された津波の情報に基づき、
/// 津波が到達とすると推定される沿岸地域について津波の推定値に関する情報を記載します。
/// VTSE52に出現します。
/// 1.3

class Estimation {
  Estimation({
    required this.code,
    required this.name,
    required this.firstHeight,
    required this.maxHeight,
  });
  Estimation.fromJson(Map<String, dynamic> j)
      : code = int.parse(j['code'].toString()),
        name = j['name'].toString(),
        firstHeight =
            FirstHeight.fromJson(j['firstHeight'] as Map<String, dynamic>),
        maxHeight = MaxHeight.fromJson(j['maxHeight'] as Map<String, dynamic>);

  /// 津波予報区コード
  /// コードは、気象庁防災情報XMLフォーマット コード表 地震火山関連コード表 による
  final int code;

  /// 津波予報区名
  final String name;

  /// 対象津波予報区に対しての津波の到達予想時刻(推定値)
  /// #1.3.3. first height
  final FirstHeight firstHeight;

  /// 対象津波予報区に対しての津波の予想高さ (推定値)
  /// #1.3.4. max height
  final MaxHeight maxHeight;
}
