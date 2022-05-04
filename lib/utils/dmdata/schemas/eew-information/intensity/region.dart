import 'forecastmaxint.dart';
import 'region/kind.dart';

class Region {
  Region({
    required this.code,
    required this.name,
    required this.isPlum,
    required this.isWarning,
    required this.forecastMaxInt,
    required this.forecastMaxLpgmInt,
    required this.kind,
    required this.condition,
    required this.arraivalTime,
  });
  Region.fromJson(Map<String, dynamic> j)
      : code = int.parse(j['code'].toString()),
        name = j['name'].toString(),
        isPlum = j['isPlum'].toString().toLowerCase() == 'true',
        isWarning = j['isWarning'].toString().toLowerCase() == 'true',
        forecastMaxInt = ForecastMaxInt.fromJson(
          j['forecastMaxInt'] as Map<String, dynamic>,
        ),
        forecastMaxLpgmInt = (j['forecastMaxLpgmInt'].toString() == 'null')
            ? null
            : ForecastMaxInt.fromJson(
                j['forecastMaxInt'] as Map<String, dynamic>,
              ),
        kind = Kind.fromJson(j['kind'] as Map<String, dynamic>),
        condition =
            (j['condition'].toString() == 'null') ? null : 'すでに主要動到達と予測',
        arraivalTime = (j['arraivalTime'].toString() == 'null')
            ? null
            : DateTime.parse(j['arraivalTime'].toString());

  /// ## 細分化地域コード
  /// コードは、コード表41 による
  final int code;

  /// ## 細分化地域名
  final String name;

  /// ## この細分化地域でPLUM法による震度予測であるか示す
  /// PLUM法時は`true`とする
  final bool isPlum;

  /// ## この細分化地域で警報発表しているかどうかを示す
  /// 警報時は`true`とする
  final bool isWarning;

  /// ## 最大予測震度を記載する #8.4.5.forecastMaxInt
  final ForecastMaxInt forecastMaxInt;

  /// ## 最大予測長周期地震動階級を記載する #8.4.6.forecastMaxLpgmInt
  final ForecastMaxInt? forecastMaxLpgmInt;

  /// ## 緊急地震速報の種別 #8.4.7.kind
  final Kind kind;

  /// ## この細分化地域で主要動到達に関する状況等を示す
  /// 主要動の到達予測時刻を過ぎており、既に主要動が到達していると推測される時には出現する
  /// `既に主要動到達と推測`で固定
  final String? condition;

  /// ## この細分化地域で主要動の到達予測時刻を示す
  /// 主要動の到達予測時刻以前であり、主要動が未到達と推測される時には、本要素が出現する
  /// 該当区域について PLUM法で予測している時には、「PLUM法でその震度（階級震度）を初めて予測した時刻」を示す
  final DateTime? arraivalTime;
}

enum Revise {
  up,
  add,
}
