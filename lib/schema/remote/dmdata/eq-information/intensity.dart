import 'earthquake-information/intensity/city.dart';
import 'earthquake-information/intensity/prefecture.dart';
import 'earthquake-information/intensity/region.dart';
import 'earthquake-information/intensity/station.dart';

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
        maxLpgmInt = j['maxLpgmInt']?.toString(),
        lpgmCategory = j['lpgmCategory']?.toString(),
        prefectures = List<Prefecture>.generate(
          (j['prefectures'] as List<dynamic>).length,
          (index) => Prefecture.fromJson(
            (j['prefectures'] as List<dynamic>)[index] as Map<String, dynamic>,
          ),
        ),
        regions = List<Region>.generate(
          (j['regions'] as List<dynamic>).length,
          (index) => Region.fromJson(
            (j['regions'] as List<dynamic>)[index] as Map<String, dynamic>,
          ),
        ),
        cities = (j['cities'] == null)
            ? null
            : List<City>.generate(
                (j['cities'] as List<dynamic>).length,
                (index) => City.fromJson(
                  (j['cities'] as List<dynamic>)[index] as Map<String, dynamic>,
                ),
              ),
        stations = (j['stations'] == null)
            ? null
            : List<Station>.generate(
                (j['stations'] as List<dynamic>).length,
                (i) => Station.fromJson(
                  (j['stations'] as List<dynamic>)[i] as Map<String, dynamic>,
                ),
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
