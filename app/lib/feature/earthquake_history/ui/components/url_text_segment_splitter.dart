/// テキスト中のプレーン部分 / URL 部分
sealed class UrlTextSegment {
  const UrlTextSegment();
}

final class PlainUrlTextSegment extends UrlTextSegment {
  const PlainUrlTextSegment({required this.text});

  final String text;
}

final class LinkUrlTextSegment extends UrlTextSegment {
  const LinkUrlTextSegment({required this.url});

  final String url;
}

/// 文字列から URL を検出してセグメントに分割する
class UrlTextSegmentSplitter {
  const UrlTextSegmentSplitter();

  static final _urlPattern = RegExp(
    r'https?://[^\s\u3000<>"{}|\\^`\[\]]+',
    caseSensitive: false,
  );

  static final _trailingPunctuation = RegExp(r'[.,;:!?、。\)）」』】]+$');

  List<UrlTextSegment> split({required String text}) {
    if (text.isEmpty) {
      return const [];
    }

    final segments = <UrlTextSegment>[];
    var start = 0;
    for (final match in _urlPattern.allMatches(text)) {
      if (match.start > start) {
        segments.add(
          PlainUrlTextSegment(text: text.substring(start, match.start)),
        );
      }

      final rawUrl = match.group(0) ?? '';
      final url = rawUrl.replaceFirst(_trailingPunctuation, '');
      if (url.isNotEmpty) {
        segments.add(LinkUrlTextSegment(url: url));
      }
      if (url.length < rawUrl.length) {
        segments.add(
          PlainUrlTextSegment(text: rawUrl.substring(url.length)),
        );
      }
      start = match.end;
    }

    if (start < text.length) {
      segments.add(PlainUrlTextSegment(text: text.substring(start)));
    }
    return segments;
  }
}
