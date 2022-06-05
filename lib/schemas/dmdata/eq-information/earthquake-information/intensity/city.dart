import 'preperiod/periodic_band.dart';

class City {
  City({
    required this.code,
    required this.name,
    required this.maxInt,
    required this.maxLpgmInt,
    required this.revise,
  });
  City.fromJson(Map<String, dynamic> j)
      : code = int.parse(j['code'].toString()),
        name = j['name'].toString(),
        maxInt = j['maxInt'].toString(),
        maxLpgmInt = j['maxLpgmInt'].toString(),
        revise = (j['revise'] == null)
            ? null
            : (j['revise'] == '追加')
                ? Revise.add
                : Revise.up;

  /// ## 市区町村コード
  /// コードは、気象庁防災情報XMLフォーマット コード表 地震火山関連コード表 による
  final int code;

  /// ## 市区町村名
  final String name;

  /// ## そ 市区町村における最大震度
  /// `1`,`2`,`3`,`4`,`5-`,`5+`,`6-`,`6+`,`7`で記載する
  final String? maxInt;

  /// ## そ 市区町村における最大長周期地震動階級
  /// `0`,`1`,`2`,`3`,`4`で記載する
  /// VXSE62時のみ出現
  final String maxLpgmInt;

  /// ## そ 市区町村における最大震度が続報で変化した場合に記載する。
  /// 取りうる値は`上方修正`又は`追加`
  /// VXSE53、VXSE62時で、続報で震度変化があれば出現
  final Revise? revise;
}
