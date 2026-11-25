import 'package:jma_eew_xml/src/jma_eew_xml_exception.dart';
import 'package:jma_eew_xml/src/model/jma_eew_enums.dart';
import 'package:jma_eew_xml/src/model/jma_eew_telegram.dart';
import 'package:jma_eew_xml/src/model/jma_eew_warning.dart';
import 'package:jma_eew_xml/src/parser/jma_eew_earthquake_reader.dart';
import 'package:jma_eew_xml/src/parser/jma_eew_headline_reader.dart';
import 'package:jma_eew_xml/src/parser/jma_eew_intensity_forecast_reader.dart';
import 'package:jma_eew_xml/src/parser/jma_xml_reader.dart';
import 'package:jma_eew_xml/src/parser/jma_xml_tag.dart';
import 'package:jma_eew_xml/src/parser/jma_xml_tree.dart';

/// 緊急地震速報（警報）・（予報）・（地震動予報）の電文を読む。
///
/// 要素は名前空間の接頭辞を除いた名前で照合し、子要素の順序には依存しない。
final class const JmaEewXmlParser() {
  static const _treeBuilder = JmaXmlTreeBuilder();

  JmaEewTelegram parse(String xml) {
    final tree = _treeBuilder.build(xml);
    final reader = JmaXmlReader(tree);
    final root = tree.root;
    if (tree.tag(root) != JmaXmlTag.report) {
      throw const JmaEewXmlStructureException('ルート要素が Report ではありません');
    }
    final control = reader.requireChild(root, JmaXmlTag.control);
    final head = reader.requireChild(root, JmaXmlTag.head);
    final body = reader.requireChild(root, JmaXmlTag.body);

    final title = reader.requireText(control, JmaXmlTag.title);
    final kind =
        JmaEewTelegramKind.fromTitle(title) ??
        (throw JmaEewXmlUnsupportedTitleException(title));
    final statusLabel = reader.requireText(control, JmaXmlTag.status);
    final infoTypeLabel = reader.requireText(head, JmaXmlTag.infoType);
    final headline = tree.child(head, JmaXmlTag.headline);
    final earthquake = tree.child(body, JmaXmlTag.earthquake);
    final intensity = tree.child(body, JmaXmlTag.intensity);
    final forecast = intensity < 0
        ? -1
        : tree.child(intensity, JmaXmlTag.forecast);
    final comments = tree.child(body, JmaXmlTag.comments);
    final warningComment = comments < 0
        ? -1
        : tree.child(comments, JmaXmlTag.warningComment);

    return JmaEewTelegram(
      kind: kind,
      status:
          JmaTelegramStatus.fromLabel(statusLabel) ??
          (throw JmaEewXmlStructureException(
            'Status 要素の値を読めません: $statusLabel',
          )),
      editorialOffice: reader.requireText(control, JmaXmlTag.editorialOffice),
      dateTime: reader.requireDateTime(control, JmaXmlTag.dateTime),
      reportDateTime: reader.requireDateTime(head, JmaXmlTag.reportDateTime),
      targetDateTime: reader.optionalDateTime(head, JmaXmlTag.targetDateTime),
      eventId: reader.requireText(head, JmaXmlTag.eventId),
      infoType:
          JmaInfoType.fromLabel(infoTypeLabel) ??
          (throw JmaEewXmlStructureException(
            'InfoType 要素の値を読めません: $infoTypeLabel',
          )),
      serial: reader.requireInt(head, JmaXmlTag.serial),
      headlineText: headline < 0
          ? null
          : reader.nonEmptyText(headline, JmaXmlTag.text),
      warningItems: headline < 0
          ? const []
          : JmaEewHeadlineReader(reader).readWarningItems(headline),
      earthquake: earthquake < 0
          ? null
          : JmaEewEarthquakeReader(reader).read(earthquake),
      intensityForecast: forecast < 0
          ? null
          : JmaEewIntensityForecastReader(reader).read(forecast),
      text: reader.nonEmptyText(body, JmaXmlTag.text),
      warningComment: warningComment < 0
          ? null
          : JmaEewWarningComment(
              text: reader.optionalText(warningComment, JmaXmlTag.text) ?? '',
              codes:
                  reader
                      .nonEmptyText(warningComment, JmaXmlTag.code)
                      ?.split(RegExp(r'\s+')) ??
                  const [],
            ),
      nextAdvisory: reader.nonEmptyText(body, JmaXmlTag.nextAdvisory),
    );
  }
}
