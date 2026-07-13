import 'package:nied_api_client/src/hinet/jmalist/model/hinet_jmalist_event.dart';

/// [HinetJmalistParser.parse] の結果。
///
/// [skippedLineCount] は FAR FIELD 行・欠測により復元不能な行の合計件数。
class HinetJmalistParseResult {
  const HinetJmalistParseResult({
    required this.events,
    required this.skippedLineCount,
  });

  final List<HinetJmalistEvent> events;
  final int skippedLineCount;
}

/// Hi-net `jmalist.php` が返す `<pre>` 内プレーンテキスト表のパーサー。
///
/// 1行の書式(空白区切り、M2列は欠測すると列ごと消える):
/// `日付 時刻 時刻誤差 緯度 緯度誤差 経度 経度誤差 深さ M1 [M2+flag] 震央地名(英語) 品質コード`
///
/// 日付・時刻は JST で出力されるため、[HinetJmalistEvent.originTime] へ
/// 格納する前に UTC(-9h)へ変換する。
class HinetJmalistParser {
  const HinetJmalistParser();

  static const _jstOffset = Duration(hours: 9);

  HinetJmalistParseResult parse(String content) {
    final events = <HinetJmalistEvent>[];
    var skippedLineCount = 0;

    for (final rawLine in content.split('\n')) {
      final line = rawLine.trim();
      if (line.isEmpty || line.startsWith('#')) {
        continue;
      }
      if (line.contains('FAR FIELD')) {
        skippedLineCount++;
        continue;
      }

      final event = _parseLine(line);
      if (event == null) {
        skippedLineCount++;
        continue;
      }
      events.add(event);
    }

    return HinetJmalistParseResult(
      events: events,
      skippedLineCount: skippedLineCount,
    );
  }

  HinetJmalistEvent? _parseLine(String line) {
    final tokens = line.split(RegExp(r'\s+'));
    if (tokens.length < 11) {
      return null;
    }

    try {
      final originTimeJst = DateTime.parse('${tokens[0]}T${tokens[1]}Z');
      final magnitude2Token = tokens[9];
      final qualityCode = tokens.last;
      final hasMagnitude2 = _looksLikeMagnitude2Token(magnitude2Token);
      final regionStartIndex = hasMagnitude2 ? 10 : 9;
      final regionEndIndex = tokens.length - 1;
      if (regionStartIndex >= regionEndIndex ||
          qualityCode.length != 1 ||
          !_isAsciiLetter(qualityCode.codeUnitAt(0))) {
        return null;
      }

      final magnitude2 = hasMagnitude2
          ? double.parse(_magnitude2Value(magnitude2Token))
          : null;
      final magnitudeFlag = hasMagnitude2
          ? _magnitude2Flag(magnitude2Token)
          : null;

      return HinetJmalistEvent(
        originTime: originTimeJst.subtract(_jstOffset),
        timeError: double.parse(tokens[2]),
        latitude: double.parse(tokens[3]),
        latitudeError: double.parse(tokens[4]),
        longitude: double.parse(tokens[5]),
        longitudeError: double.parse(tokens[6]),
        depthKm: double.parse(tokens[7]),
        magnitude1: double.parse(tokens[8]),
        magnitude2: magnitude2,
        magnitudeFlag: magnitudeFlag,
        regionNameEn: tokens.sublist(regionStartIndex, regionEndIndex).join(' '),
        qualityCode: qualityCode,
      );
    } on FormatException {
      return null;
    }
  }

  bool _looksLikeMagnitude2Token(String token) {
    if (token.isEmpty) {
      return false;
    }
    return double.tryParse(_magnitude2Value(token)) != null;
  }

  String _magnitude2Value(String token) {
    final lastCodeUnit = token.codeUnitAt(token.length - 1);
    final hasFlag = _isAsciiLetter(lastCodeUnit);
    return hasFlag ? token.substring(0, token.length - 1) : token;
  }

  String? _magnitude2Flag(String token) {
    final lastCodeUnit = token.codeUnitAt(token.length - 1);
    final hasFlag = _isAsciiLetter(lastCodeUnit);
    return hasFlag ? token.substring(token.length - 1) : null;
  }

  bool _isAsciiLetter(int codeUnit) =>
      (codeUnit >= 65 && codeUnit <= 90) || (codeUnit >= 97 && codeUnit <= 122);
}
