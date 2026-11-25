import 'dart:typed_data';

import 'package:jma_eew_xml/src/jma_eew_xml_exception.dart';
import 'package:jma_eew_xml/src/parser/jma_xml_tag.dart';
import 'package:jma_eew_xml/src/parser/jma_xml_text_decoder.dart';

/// 要素の位置だけを記録した木。文字列は値を読むときに切り出す。
final class JmaXmlTree(
  final String source,
  final Int32List _nodes,
  final int root,
) {
  static const stride = 10;
  static const tagOffset = 0;
  static const firstChildOffset = 1;
  static const lastChildOffset = 2;
  static const nextSiblingOffset = 3;
  static const nameStartOffset = 4;
  static const nameEndOffset = 5;
  static const attributeStartOffset = 6;
  static const attributeEndOffset = 7;
  static const contentStartOffset = 8;
  static const contentEndOffset = 9;

  static const _decoder = JmaXmlTextDecoder();

  JmaXmlTag tag(int node) => JmaXmlTag.values[_nodes[node * stride]];

  int firstChild(int node) => _nodes[node * stride + firstChildOffset];

  int nextSibling(int node) => _nodes[node * stride + nextSiblingOffset];

  int contentStart(int node) => _nodes[node * stride + contentStartOffset];

  int contentEnd(int node) => _nodes[node * stride + contentEndOffset];

  int child(int node, JmaXmlTag tag) {
    final index = tag.index;
    for (var c = firstChild(node); c >= 0; c = nextSibling(c)) {
      if (_nodes[c * stride] == index) {
        return c;
      }
    }
    return -1;
  }

  String text(int node) => _decoder.decode(
    source,
    _nodes[node * stride + contentStartOffset],
    _nodes[node * stride + contentEndOffset],
  );

  String? attribute(int node, String name) {
    final base = node * stride;
    final end = _nodes[base + attributeEndOffset];
    var i = _nodes[base + attributeStartOffset];
    while (i < end) {
      while (i < end && JmaXmlTextDecoder.isWhitespace(source.codeUnitAt(i))) {
        i++;
      }
      final nameStart = i;
      while (i < end) {
        final c = source.codeUnitAt(i);
        if (c == JmaXmlTextDecoder.equals ||
            JmaXmlTextDecoder.isWhitespace(c)) {
          break;
        }
        i++;
      }
      final nameEnd = i;
      while (i < end && source.codeUnitAt(i) != JmaXmlTextDecoder.equals) {
        i++;
      }
      i++;
      while (i < end && JmaXmlTextDecoder.isWhitespace(source.codeUnitAt(i))) {
        i++;
      }
      if (i >= end) {
        return null;
      }
      final quote = source.codeUnitAt(i);
      final valueStart = i + 1;
      final valueEnd = source.indexOf(String.fromCharCode(quote), valueStart);
      if (valueEnd < 0 || valueEnd > end) {
        return null;
      }
      if (nameEnd - nameStart == name.length &&
          source.startsWith(name, nameStart)) {
        return _decoder.decode(source, valueStart, valueEnd);
      }
      i = valueEnd + 1;
    }
    return null;
  }
}

/// 気象庁防災情報 XML（UTF-8、DTD なし）を前提にした最小限の字句解析で [JmaXmlTree] を作る。
/// 実体の定義を持ち込ませないため、DOCTYPE は受け付けない。
final class const JmaXmlTreeBuilder() {
  static const _gt = 0x3E;
  static const _slash = 0x2F;
  static const _question = 0x3F;
  static const _exclamation = 0x21;
  static const _colon = 0x3A;
  static const _doubleQuote = 0x22;
  static const _singleQuote = 0x27;
  static const _byteOrderMark = 0xFEFF;
  static const _maxDepth = 128;

  JmaXmlTree build(String source) {
    const stride = JmaXmlTree.stride;
    final length = source.length;
    var nodes = Int32List(stride * 256);
    var count = 0;
    final stack = Int32List(_maxDepth);
    var depth = 0;
    var root = -1;
    var pos = length > 0 && source.codeUnitAt(0) == _byteOrderMark ? 1 : 0;

    while (true) {
      final lt = source.indexOf('<', pos);
      if (lt < 0) {
        break;
      }
      if (lt + 1 >= length) {
        throw JmaEewXmlSyntaxException(lt, 'タグが閉じていません');
      }
      final marker = source.codeUnitAt(lt + 1);
      if (marker == _slash) {
        if (depth == 0) {
          throw JmaEewXmlSyntaxException(lt, '対応する開始タグがありません');
        }
        final node = stack[--depth];
        final base = node * stride;
        final nameStart = nodes[base + JmaXmlTree.nameStartOffset];
        final nameLength = nodes[base + JmaXmlTree.nameEndOffset] - nameStart;
        var gt = lt + 2 + nameLength;
        if (gt > length ||
            !_regionEquals(source, nameStart, lt + 2, nameLength)) {
          throw JmaEewXmlSyntaxException(lt, '開始タグと終了タグの名前が一致しません');
        }
        while (gt < length &&
            JmaXmlTextDecoder.isWhitespace(source.codeUnitAt(gt))) {
          gt++;
        }
        if (gt >= length || source.codeUnitAt(gt) != _gt) {
          throw JmaEewXmlSyntaxException(lt, '開始タグと終了タグの名前が一致しません');
        }
        nodes[base + JmaXmlTree.contentEndOffset] = lt;
        pos = gt + 1;
        continue;
      }
      if (marker == _question) {
        final end = source.indexOf('?>', lt + 2);
        if (end < 0) {
          throw JmaEewXmlSyntaxException(lt, '処理命令が閉じていません');
        }
        pos = end + 2;
        continue;
      }
      if (marker == _exclamation) {
        if (source.startsWith('<!--', lt)) {
          final end = source.indexOf('-->', lt + 4);
          if (end < 0) {
            throw JmaEewXmlSyntaxException(lt, 'コメントが閉じていません');
          }
          pos = end + 3;
          continue;
        }
        if (source.startsWith('<![CDATA[', lt)) {
          final end = source.indexOf(']]>', lt + 9);
          if (end < 0) {
            throw JmaEewXmlSyntaxException(lt, 'CDATA が閉じていません');
          }
          pos = end + 3;
          continue;
        }
        throw JmaEewXmlSyntaxException(lt, 'DOCTYPE などの宣言は扱いません');
      }

      final nameStart = lt + 1;
      var i = nameStart;
      var localStart = nameStart;
      var hash = 0;
      while (i < length) {
        final c = source.codeUnitAt(i);
        if (c == _gt || c == _slash || JmaXmlTextDecoder.isWhitespace(c)) {
          break;
        }
        if (c == _colon) {
          localStart = i + 1;
          hash = 0;
        } else {
          hash = (hash * 31 + c) & JmaXmlTag.hashMask;
        }
        i++;
      }
      final nameEnd = i;
      if (nameEnd == nameStart) {
        throw JmaEewXmlSyntaxException(lt, '要素名がありません');
      }
      final attributeStart = i;
      if (i < length && source.codeUnitAt(i) != _gt) {
        var quote = 0;
        while (i < length) {
          final c = source.codeUnitAt(i);
          if (quote != 0) {
            if (c == quote) {
              quote = 0;
            }
          } else if (c == _doubleQuote || c == _singleQuote) {
            quote = c;
          } else if (c == _gt) {
            break;
          }
          i++;
        }
      }
      if (i >= length) {
        throw JmaEewXmlSyntaxException(lt, '開始タグが閉じていません');
      }
      final gt = i;
      final isEmptyElement = source.codeUnitAt(gt - 1) == _slash;

      if (count * stride + stride > nodes.length) {
        final grown = Int32List(nodes.length * 2)..setAll(0, nodes);
        nodes = grown;
      }
      final node = count++;
      final base = node * stride;
      nodes[base + JmaXmlTree.tagOffset] = JmaXmlTag.lookup(
        source,
        localStart,
        nameEnd,
        hash,
      ).index;
      nodes[base + JmaXmlTree.firstChildOffset] = -1;
      nodes[base + JmaXmlTree.lastChildOffset] = -1;
      nodes[base + JmaXmlTree.nextSiblingOffset] = -1;
      nodes[base + JmaXmlTree.nameStartOffset] = nameStart;
      nodes[base + JmaXmlTree.nameEndOffset] = nameEnd;
      nodes[base + JmaXmlTree.attributeStartOffset] = attributeStart;
      nodes[base + JmaXmlTree.attributeEndOffset] = isEmptyElement
          ? gt - 1
          : gt;
      nodes[base + JmaXmlTree.contentStartOffset] = gt + 1;
      nodes[base + JmaXmlTree.contentEndOffset] = gt + 1;

      if (depth == 0) {
        if (root >= 0) {
          throw JmaEewXmlSyntaxException(lt, 'ルート要素が複数あります');
        }
        root = node;
      } else {
        final parentBase = stack[depth - 1] * stride;
        final last = nodes[parentBase + JmaXmlTree.lastChildOffset];
        if (last < 0) {
          nodes[parentBase + JmaXmlTree.firstChildOffset] = node;
        } else {
          nodes[last * stride + JmaXmlTree.nextSiblingOffset] = node;
        }
        nodes[parentBase + JmaXmlTree.lastChildOffset] = node;
      }
      if (!isEmptyElement) {
        if (depth >= _maxDepth) {
          throw JmaEewXmlSyntaxException(lt, '要素の入れ子が深すぎます');
        }
        stack[depth++] = node;
      }
      pos = gt + 1;
    }

    if (depth != 0) {
      throw JmaEewXmlSyntaxException(length, '閉じていない要素があります');
    }
    if (root < 0) {
      throw JmaEewXmlSyntaxException(0, 'ルート要素がありません');
    }
    return JmaXmlTree(source, nodes, root);
  }

  static bool _regionEquals(String source, int a, int b, int length) {
    for (var k = 0; k < length; k++) {
      if (source.codeUnitAt(a + k) != source.codeUnitAt(b + k)) {
        return false;
      }
    }
    return true;
  }
}
