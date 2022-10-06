import 'forecast/firstHeight.dart';
import 'forecast/kind.dart';
import 'forecast/maxHeight.dart';
import 'forecast/station.dart';

/// 津波警報・注意報・予報に関する情報を本要素に記載します。
/// VTSE41や、VTSE51に出現します。VTSE51の場合、津波観測がされるとその津波予報区で到達予想時刻が第１波到達を確認となります。
/// 下記は各予報区ごとに出現します。
class Forecast {
  Forecast({
    required this.code,
    required this.name,
    required this.kind,
    required this.firstHeight,
    required this.maxHeight,
    required this.stations,
  });
  Forecast.fromJson(Map<String, dynamic> j)
      : code = int.parse(j['code'].toString()),
        name = j['name'].toString(),
        kind = Kind.fromJson(j['kind'] as Map<String, dynamic>),
        firstHeight = (j['firstHeight'] == null)
            ? null
            : FirstHeight.fromJson(j['firstHeight'] as Map<String, dynamic>),
        maxHeight = (j['maxHeight'] == null)
            ? null
            : MaxHeight.fromJson(j['maxHeight'] as Map<String, dynamic>),
        stations = (j['stations'] == null)
            ? null
            : List<Station>.generate(
                (j['stations'] as List<dynamic>).length,
                (index) => Station.fromJson(
                  (j['stations'] as List<dynamic>)[index]
                      as Map<String, dynamic>,
                ),
              );

  /// 津波予報区コード
  /// コードは、気象庁防災情報XMLフォーマット コード表 地震火山関連コード表 による
  final int code;

  /// 津波予報区名
  final String name;

  /// 津波警報等の種別 #1. 1. 3. kind
  final Kind kind;

  /// 対象津波予報区に対しての津波の到達予想時刻 #1. 1. 4. first height
  /// 対象とする津波予報区が`若干の海面変動`の時には出現しません。
  final FirstHeight? firstHeight;

  /// 対象津波予報区に対しての津波の予想高さ #1. 1. 5. max height
  /// 	津波注意報以上から、若干の海面変動となった場合は出現しない
  final MaxHeight? maxHeight;

  /// 対象津波予報区に所属する潮位観測点毎の満潮時刻と到達予想時刻 #1. 1. 6. station
  /// VTSE51で、津波注意情報以上の時に出現する
  final List<Station>? stations;
}
