import 'comments.dart';
import 'earthquake.dart';
import 'intensity.dart';

/// ## Schema earthquake-information v1.1.0
/// ### 対象とするXML電文
/// - 震度速報 (VXSE51)
/// - 震源に関する情報 (VXSE52)
/// - 震源・震度に関する情報 (VXSE53)
/// - 長周期地震動に関する情報 (VXSE62)
/// - 地震・津波に関するお知らせ (VZSE40)
// ignore_for_file: lines_longer_than_80_chars
class EarthquakeInformation {
  EarthquakeInformation({
    required this.earthquake,
    required this.intensity,
    required this.text,
    required this.comments,
  });
  EarthquakeInformation.fromJson(Map<String, dynamic> j)
      : earthquake = (j['earthquake'].toString() == 'null')
            ? null
            : EarthQuakeInformationComponent.fromJson(
                j['earthquake'] as Map<String, dynamic>,
              ),
        intensity = (j['intensity'].toString() == 'null')
            ? null
            : Intensity.fromJson(j['intensity'] as Map<String, dynamic>),
        text = (j['text'] == null) ? null : j['text'].toString(),
        comments = (j['comments'].toString() == 'null')
            ? null
            : Comments.fromJson(j['comments'] as Map<String, dynamic>);

  /// ### VXSE52、VXSE53、VXSE62時に出現
  /// 取消時には出現しない
  final EarthQuakeInformationComponent? earthquake;

  /// ### VXSE51、VXSE53、VXSE62時に出現
  /// 震度データがない場合や取消時には出現しない
  final Intensity? intensity;

  /// ### VZSE40時・取消時の理由や、その他の追記事項がある場合に出現
  final String? text;

  /// ### 付加的な情報を文章形式で提供する
  /// [#4.comments](https://dmdata.jp/doc/reference/conversion/json/schema/earthquake-information#4-comments)
  final Comments? comments;
}
