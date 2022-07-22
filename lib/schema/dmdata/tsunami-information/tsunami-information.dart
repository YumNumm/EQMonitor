import '../eq-information/earthquake.dart';
import 'comments/comments.dart';
import 'tsunami.dart';

/// 対象とするXML電文
/// - 津波警報・注意報・予報a (VTSE41)
/// - 津波情報a (VTSE51)
/// - 沖合の津波観測に関する情報 (VTSE52)

class TsunamiInformation {
  TsunamiInformation({
    required this.tsunami,
    required this.earthquakes,
    required this.text,
    required this.comments,
  });
  TsunamiInformation.fromJson(Map<String, dynamic> j)
      : tsunami = Tsunami.fromJson(j['tsunami'] as Map<String, dynamic>),
        earthquakes = (j['earthquakes'] == null)
            ? null
            : List<EarthQuakeInformationComponent>.generate(
                (j['earthquakes'] as List<dynamic>).length,
                (index) => EarthQuakeInformationComponent.fromJson(
                  (j['earthquakes'] as List<dynamic>)[index]
                      as Map<String, dynamic>,
                ),
              ),
        text = (j['text'] == null) ? null : j['text'].toString(),
        comments = (j['comments'] == null)
            ? null
            : Comments.fromJson(j['comments'] as Map<String, dynamic>);

  /// 津波情報
  final Tsunami tsunami;

  /// Earthquake component を配列に0個以上格納する
  final List<EarthQuakeInformationComponent>? earthquakes;

  /// 自由形式で文章を記載する
  /// 取消時の理由や、その他の追記事項がある場合に出現
  final String? text;

  /// 付加的な情報を文章形式で提供する #4. comments
  /// 取消時や付加的な情報がない場合は出現しない
  final Comments? comments;
}
