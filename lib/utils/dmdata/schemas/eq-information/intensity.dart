/// VXSE51、VXSE53、VXSE62時に出現し、震度データがない場合(遠地地震や、緊急地震速報(警報)を発表したが震度1以上を観測しなかったとき等)や取消時には出現しません。
class Intensity {
  Intensity({
    required this.maxInt,
    required this.maxLpgmInt,
    required this.lpgmCategory,
    required this.prefectures,
    required this.regions,
    required this.cities,
    required this.stations,
  });
  Intensity.fromJson(Map<String, dynamic> j)
      : maxInt = j['maxInt'].toString(),
        maxLpgmInt =
            (j['maxLpgmInt'] == null) ? null : j['maxLpgmInt'].toString(),
        lpgmCategory =
            (j['lpgmCategory'] == null) ? null : j['lpgmCategory'].toString(),
        prefectures = List<Prefecture>.generate(
          (j['prefectures'] as List<dynamic>).length,
          (index) => Prefecture.fromJson(
            (j['prefectures'] as List<dynamic>)[index] as Map<String, dynamic>,
          ),
        ),
        regions = List<Region>.generate(
          (j['regions'] as List<dynamic>).length,
          (index) => Region.fromJson(
              (j['regions'] as List<dynamic>)[index] as Map<String, dynamic>),
        ),
        cities = (j['cities'] == null)
            ? null
            : List<City>.generate(
                (j['cities'] as List<dynamic>).length,
                (index) => City.fromJson((j['cities'] as List<dynamic>)[index]
                    as Map<String, dynamic>),
              ),
        stations = (j['stations'] == null)
            ? null
            : List<Station>.generate(
                (j['stations'] as List<dynamic>).length,
                (i) => Station.fromJson((j['stations'] as List<dynamic>)[i]
                    as Map<String, dynamic>),
              );

  /// 最大震度 `1`,`2`,`3`,`4`,`5-`,`5+`,`6-`,`6+`,`7`で記載する
  final String maxInt;

  /// 最大長周期地震動階級、`0`,`1`,`2`,`3`,`4`で記載する
  /// VXSE62時のみ
  final String? maxLpgmInt;

  /// 長周期地震動に関する観測情報の種類、1, 2, 3, 4 で記載する
  /// [#2-3-lpgmCategory](https://dmdata.jp/doc/reference/conversion/json/schema/earthquake-information/#2-3-lpgmcategory)
  /// VXSE62時のみ
  final String? lpgmCategory;

  /// 都道府県内における最大震度
  /// [#2.4.prefectures](https://dmdata.jp/doc/reference/conversion/json/schema/earthquake-information/#2-4-prefectures)
  final List<Prefecture> prefectures;

  /// 一次細分化地域内における最大震度
  /// [#2.5.region](https://dmdata.jp/doc/reference/conversion/json/schema/earthquake-information/#2-5-region)
  final List<Region> regions;

  /// 市区町村における最大震度
  /// [#2.6.city](https://dmdata.jp/doc/reference/conversion/json/schema/earthquake-information/#2-6-city)
  /// VXSE62時のみ出現
  final List<City>? cities;

  /// 観測点における震度
  /// [#2.7.stations](https://dmdata.jp/doc/reference/conversion/json/schema/earthquake-information/#2-7-stations)
  final List<Station>? stations;
}

class Prefecture {
  Prefecture({
    required this.code,
    required this.name,
    required this.maxInt,
    required this.maxLpgmInt,
    required this.revise,
  });
  Prefecture.fromJson(Map<String, dynamic> j)
      : code = int.parse(j['code'].toString()),
        name = j['name'].toString(),
        maxInt = j['maxInt'].toString(),
        maxLpgmInt = j['maxLpgmInt'].toString(),
        revise = (j['revise'] == null)
            ? null
            : (j['revise'] == '追加')
                ? Revise.add
                : Revise.up;

  /// ## 都道府県コード
  /// コードは、気象庁防災情報XMLフォーマット コード表 地震火山関連コード表 による
  final int code;

  /// ## 都道府県名
  final String name;

  /// ## その都道府県における最大震度
  /// `1`,`2`,`3`,`4`,`5-`,`5+`,`6-`,`6+`,`7`で記載する
  final String? maxInt;

  /// ## その都道府県における最大長周期地震動階級
  /// `0`,`1`,`2`,`3`,`4`で記載する
  /// VXSE62時のみ出現
  final String maxLpgmInt;

  /// ## その都道府県における最大震度が続報で変化した場合に記載する。
  /// 取りうる値は`上方修正`又は`追加`
  /// VXSE53、VXSE62時で、続報で震度変化があれば出現
  final Revise? revise;
}

class Region {
  Region({
    required this.code,
    required this.name,
    required this.maxInt,
    required this.maxLpgmInt,
    required this.revise,
  });
  Region.fromJson(Map<String, dynamic> j)
      : code = int.parse(j['code'].toString()),
        name = j['name'].toString(),
        maxInt = j['maxInt'].toString(),
        maxLpgmInt = j['maxLpgmInt'].toString(),
        revise = (j['revise'] == null)
            ? null
            : (j['revise'] == '追加')
                ? Revise.add
                : Revise.up;

  /// ## 一次細分化地域コード
  /// コードは、気象庁防災情報XMLフォーマット コード表 地震火山関連コード表 による
  final int code;

  /// ## 一次細分化地域名
  final String name;

  /// ## その一次細分化地域における最大震度
  /// `1`,`2`,`3`,`4`,`5-`,`5+`,`6-`,`6+`,`7`で記載する
  final String? maxInt;

  /// ## その一次細分化地域における最大長周期地震動階級
  /// `0`,`1`,`2`,`3`,`4`で記載する
  /// VXSE62時のみ出現
  final String maxLpgmInt;

  /// ## その一次細分化地域における最大震度が続報で変化した場合に記載する。
  /// 取りうる値は`上方修正`又は`追加`
  /// VXSE53、VXSE62時で、続報で震度変化があれば出現
  final Revise? revise;
}

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
                  j['prePeriods'][i] as Map<String, dynamic>,
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

class SVA {
  SVA({
    required this.unit,
    required this.value,
  });
  SVA.fromJson(Map<String, dynamic> j)
      : unit = j['unit'].toString(),
        value = double.parse(j['value'].toString());

  /// 絶対速度応答スペクトル情報の単位。`cm/s`で固定
  final String unit;

  /// 絶対速度応答スペクトルの1.6秒～7.8秒周期帯における最大値を記載する
  final double value;
}

class PrePeriod {
  PrePeriod({
    required this.periodicBand,
    required this.lpgmInt,
    required this.sva,
  });
  PrePeriod.fromJson(Map<String, dynamic> j)
      : periodicBand =
            PeriodicBand.fromJson(j['periodicBand'] as Map<String, dynamic>),
        lpgmInt = j['lpgmInt'].toString(),
        sva = SVA.fromJson(j['sva'] as Map<String, dynamic>);

  /// ## 対象とする周期帯を記載する
  final PeriodicBand periodicBand;

  /// ## 対象とする周期帯における長周期地震動階級`0`,`1`,`2`,`3`,`4`で記載する
  final String lpgmInt;

  /// ## 対象とする周期帯における絶対応答スペクトルを記載する
  final SVA sva;
}

class PeriodicBand {
  PeriodicBand({
    required this.unit,
    required this.value,
  });
  PeriodicBand.fromJson(Map<String, dynamic> j)
      : unit = j['unit'].toString(),
        value = int.parse(j['value'].toString());

  /// 対象とする周期帯情報の単位。
  /// `秒台`で固定
  final String unit;

  /// 対象とする周期帯の秒数を記載する、1秒～7秒の範囲
  final int value;
}

enum Revise {
  up,
  add,
}
