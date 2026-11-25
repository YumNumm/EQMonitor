import 'package:jma_eew_xml/src/jma_eew_xml_exception.dart';
import 'package:jma_eew_xml/src/model/jma_code_name.dart';
import 'package:jma_eew_xml/src/model/jma_eew_enums.dart';
import 'package:jma_eew_xml/src/model/jma_eew_warning.dart';
import 'package:jma_eew_xml/src/parser/jma_xml_reader.dart';
import 'package:jma_eew_xml/src/parser/jma_xml_tag.dart';

final class const JmaEewHeadlineReader(final JmaXmlReader reader) {
  List<JmaEewWarningItem> readWarningItems(int headline) {
    final tree = reader.tree;
    final items = <JmaEewWarningItem>[];
    for (
      var information = tree.firstChild(headline);
      information >= 0;
      information = tree.nextSibling(information)
    ) {
      if (tree.tag(information) != JmaXmlTag.information) {
        continue;
      }
      final type = tree.attribute(information, 'type') ?? '';
      final level =
          JmaEewWarningAreaLevel.fromInformationType(type) ??
          (throw JmaEewXmlStructureException(
            'Information 要素の type 属性を読めません: $type',
          ));
      for (
        var item = tree.firstChild(information);
        item >= 0;
        item = tree.nextSibling(item)
      ) {
        if (tree.tag(item) == JmaXmlTag.item) {
          items.add(readItem(item, level: level));
        }
      }
    }
    return items;
  }

  JmaEewWarningItem readItem(
    int item, {
    required JmaEewWarningAreaLevel level,
  }) {
    final tree = reader.tree;
    final areas = <JmaCodeName>[];
    final areasNode = reader.requireChild(item, JmaXmlTag.areas);
    for (
      var area = tree.firstChild(areasNode);
      area >= 0;
      area = tree.nextSibling(area)
    ) {
      if (tree.tag(area) == JmaXmlTag.area) {
        areas.add(reader.requireCodeName(area));
      }
    }
    return JmaEewWarningItem(
      level: level,
      kind: reader.requireCodeName(reader.requireChild(item, JmaXmlTag.kind)),
      lastKind: reader.requireCodeName(
        reader.requireChild(item, JmaXmlTag.lastKind),
      ),
      areas: areas,
    );
  }
}
