import 'area.dart';
import 'comments.dart';
import 'earthquake.dart';
import 'intensity/intensity.dart';

/// 対象とするXML電文
/// - 緊急地震速報（警報） (VXSE43)
/// - 緊急地震速報（予報） (VXSE44)
/// - 緊急地震速報（地震動予報） (VXSE45)
/// - 緊急地震速報テスト (VXSE42)
class EEWInformation {
  EEWInformation({
    required this.isLastInfo,
    required this.isCanceled,
    required this.isWarning,
    required this.zones,
    required this.prefectures,
    required this.regions,
    required this.earthQuake,
    required this.intensity,
    required this.text,
    required this.comments,
  });

  factory EEWInformation.fromJson(Map<String, dynamic> j) {
    final zonesList = j['zones'] as List<dynamic>?;
    final prefecturesList = j['prefectures'] as List<dynamic>?;
    final regionsList = j['regions'] as List<dynamic>?;
    return EEWInformation(
      isLastInfo: j['isLastInfo'].toString() == 'true',
      isCanceled: j['isCanceled'].toString() == 'true',
      isWarning: j['isWarning'].toString() == 'true',
      zones: (zonesList == null)
          ? null
          : List<Area>.generate(
              zonesList.length,
              (index) =>
                  Area.fromJson(zonesList[index] as Map<String, dynamic>),
            ),
      prefectures: (prefecturesList == null)
          ? null
          : List<Area>.generate(
              prefecturesList.length,
              (index) =>
                  Area.fromJson(prefecturesList[index] as Map<String, dynamic>),
            ),
      regions: (regionsList == null)
          ? null
          : List<Area>.generate(
              regionsList.length,
              (index) =>
                  Area.fromJson(regionsList[index] as Map<String, dynamic>),
            ),
      earthQuake: (j['earthquake'] == null)
          ? null
          : EarthQuake.fromJson(j['earthquake'] as Map<String, dynamic>),
      intensity: (j['intensity'] == null)
          ? null
          : Intensity.fromJson(j['intensity'] as Map<String, dynamic>),
      text: j['text']?.toString(),
      comments: (j['comments'] == null)
          ? null
          : Comments.fromJson(j['comments'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'isLastInfo': isLastInfo.toString(),
        'isCanceled': isCanceled.toString(),
        'isWarning': isWarning.toString(),
        'zones': zones?.map((e) => e.toJson()).toList(),
        'prefectures': prefectures?.map((e) => e.toJson()).toList(),
        'regions': regions?.map((e) => e.toJson()).toList(),
        'earthquake': earthQuake?.toJson(),
        'intensity': intensity?.toJson(),
        'text': text,
        'comments': comments?.toJson(),
      };

  /// このイベントで最終の更新かどうかを識別する。
  /// 最終報・取り消し報の場合は、`true`となる
  final bool isLastInfo;

  /// 取り消し報かどうか
  final bool isCanceled;

  /// このイベントで緊急地震速報（警報）が発表されたか識別する、警報時の場合は`true`とする
  /// VXSE42時や取消時には出現しない
  final bool? isWarning;

  /// 警報発表の対象とする地方予報区を記載する #4.5.6. area
  /// VXSE43、VXSE45の場合、警報対象地方があれば出現
  final List<Area>? zones;

  /// 警報発表の対象とする府県予報区を記載する #4.5.6. area
  /// VXSE43、VXSE45の場合、警報対象地方があれば出現
  final List<Area>? prefectures;

  /// 警報発表の対象とする細分化地域を記載する #4.5.6. area
  /// VXSE43、VXSE45の場合、警報対象地方があれば出現
  final List<Area>? regions;

  /// 震源要素を記載する #7. earthquake
  /// VXSE42時や取消時には出現しない
  final EarthQuake? earthQuake;

  /// 震度予測・長周期地震動階級予測情報を記載する #8. intensity
  /// VXSE42時や予測未計算時、取消時には出現しない
  final Intensity? intensity;

  /// 自由形式で文章を記載する
  /// VXSE42時・取消時の理由や、その他の追記事項がある場合に出現
  final String? text;

  /// 付加的な情報を文章形式で提供する #10. comments
  /// 取消時や付加的な情報がない場合は出現しない
  final Comments? comments;
}
