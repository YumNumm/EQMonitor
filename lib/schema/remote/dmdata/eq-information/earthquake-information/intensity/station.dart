import 'pre_period.dart';
import 'preperiod/periodic_band.dart';
import 'sva.dart';

class Station {
  Station({
    required this.code,
    required this.name,
    required this.intensity,
    required this.lpgmInt,
    required this.sva,
    required this.prePeriods,
    required this.revise,
    required this.condition,
  });
  Station.fromJson(Map<String, dynamic> j)
      : code = int.parse(j['code'].toString()),
        name = j['name'].toString(),
        intensity = j['int'].toString(),
        lpgmInt = (j['lpgmInt'] == null) ? null : j['lpgmInt'].toString(),
        sva = (j['sva'] == null)
            ? null
            : SVA.fromJson(j['sva'] as Map<String, dynamic>),
        prePeriods = (j['prePeriods'] == null)
            ? null
            : List<PrePeriod>.generate(
                (j['prePeriods'] as List<dynamic>).length,
                (i) => PrePeriod.fromJson(
                  (j['prePeriods'] as Map<String, dynamic>)[i]
                      as Map<String, dynamic>,
                ),
              ),
        revise = (j['revise'] == null)
            ? null
            : (j['revise'] == '追加')
                ? Revise.add
                : Revise.up,
        condition = (j['condition'] == null) ? null : j['condition'].toString();

  /// ##観測点コード
  /// コードは、気象庁防災情報XMLフォーマット コード表 地震火山関連コード表 による
  final int code;

  /// ##観測点名
  final String name;

  /// ## その観測点における最大震度
  /// `1`,`2`,`3`,`4`,`5-`,`5+`,`6-`,`6+`,`7`で記載する
  final String intensity;

  /// ## その観測点における最大長周期地震動階級
  /// `0`,`1`,`2`,`3`,`4`で記載する
  /// VXSE62時のみ出現
  final String? lpgmInt;

  /// ## その観測点における絶対応答スペクトルの最大値を記載する
  /// [#2.7.5. sva](https://dmdata.jp/doc/reference/conversion/json/schema/earthquake-information/#2-7-5-sva)
  /// 	VXSE62時のみ出現
  final SVA? sva;

  /// ## その観測点における周期帯毎の長周期地震動階級と絶対応答スペクトルを記載する。
  /// 要素は7個となる
  /// [#2.7.6. prePeriod](https://dmdata.jp/doc/reference/conversion/json/schema/earthquake-information/#2-7-6-preperiod)
  /// VXSE62時のみ出現
  final List<PrePeriod>? prePeriods;

  /// ## その観測点における最大震度が続報で変化した場合に記載する。
  /// 取りうる値は`上方修正`又は`追加`
  /// 続報で震度変化があれば出現
  final Revise? revise;

  /// ## その観測点で震度5弱以上未入電の震度観測点がある場合、`震度５弱以上未入電`を記載する
  ///	入電した震度がない場合に出現
  final String? condition;
}
