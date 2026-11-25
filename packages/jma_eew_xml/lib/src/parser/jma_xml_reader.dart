import 'package:jma_eew_xml/src/jma_eew_xml_exception.dart';
import 'package:jma_eew_xml/src/model/jma_code_name.dart';
import 'package:jma_eew_xml/src/parser/jma_date_time_parser.dart';
import 'package:jma_eew_xml/src/parser/jma_xml_tag.dart';
import 'package:jma_eew_xml/src/parser/jma_xml_tree.dart';

/// [JmaXmlTree] から値を読み、欠けている必須要素は [JmaEewXmlStructureException] にする。
final class const JmaXmlReader(final JmaXmlTree tree) {
  static const _dateTimeParser = JmaDateTimeParser();

  int requireChild(int node, JmaXmlTag tag) {
    final child = tree.child(node, tag);
    if (child < 0) {
      throw JmaEewXmlStructureException('${tag.localName} 要素がありません');
    }
    return child;
  }

  String? optionalText(int node, JmaXmlTag tag) {
    final child = tree.child(node, tag);
    return child < 0 ? null : tree.text(child);
  }

  String? nonEmptyText(int node, JmaXmlTag tag) {
    final text = optionalText(node, tag)?.trim();
    return text == null || text.isEmpty ? null : text;
  }

  String requireText(int node, JmaXmlTag tag) {
    final text = nonEmptyText(node, tag);
    if (text == null) {
      throw JmaEewXmlStructureException('${tag.localName} 要素の値がありません');
    }
    return text;
  }

  int? optionalInt(int node, JmaXmlTag tag) {
    final text = nonEmptyText(node, tag);
    if (text == null) {
      return null;
    }
    return int.tryParse(text) ??
        (throw JmaEewXmlStructureException(
          '${tag.localName} 要素の値が整数ではありません: $text',
        ));
  }

  int requireInt(int node, JmaXmlTag tag) =>
      optionalInt(node, tag) ??
      (throw JmaEewXmlStructureException('${tag.localName} 要素の値がありません'));

  int requireIntAttribute(int node, String name) {
    final value = tree.attribute(node, name)?.trim();
    final parsed = value == null ? null : int.tryParse(value);
    if (parsed == null) {
      throw JmaEewXmlStructureException('$name 属性の値が整数ではありません: $value');
    }
    return parsed;
  }

  DateTime? optionalDateTime(int node, JmaXmlTag tag) {
    final child = tree.child(node, tag);
    if (child < 0) {
      return null;
    }
    return _dateTimeParser.parse(
          tree.source,
          tree.contentStart(child),
          tree.contentEnd(child),
        ) ??
        (throw JmaEewXmlStructureException(
          '${tag.localName} 要素の日時を読めません: ${tree.text(child)}',
        ));
  }

  DateTime requireDateTime(int node, JmaXmlTag tag) =>
      optionalDateTime(node, tag) ??
      (throw JmaEewXmlStructureException('${tag.localName} 要素がありません'));

  JmaCodeName requireCodeName(int node) => JmaCodeName(
    code: requireText(node, JmaXmlTag.code),
    name: requireText(node, JmaXmlTag.name),
  );
}
