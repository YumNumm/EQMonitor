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

  static final _lineRegExp = RegExp(
    r'^(\d{4}-\d{2}-\d{2})\s+(\d{2}:\d{2}:\d{2}\.\d{2})\s+'
    r'([\d.]+)\s+(-?[\d.]+)\s+([\d.]+)\s+(-?[\d.]+)\s+'
    r'([\d.]+)\s+([\d.]+)\s+([\d.]+)\s+'
    r'(?:([\d.]+)([A-Za-z]?)\s+)?'
    r'(.+?)\s+([A-Za-z])$',
  );

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
    final match = _lineRegExp.firstMatch(line);
    if (match == null) {
      return null;
    }

    try {
      final datePart = match.group(1)!;
      final timePart = match.group(2)!;
      final dateSegments = datePart.split('-').map(int.parse).toList();
      final timeSegments = timePart.split(':');
      final secondSegments = timeSegments[2].split('.');

      // jmalist.php の日時は JST のため、一旦 JST の壁時計値として
      // DateTime.utc に詰め、その後 9 時間分を差し引いて UTC に変換する。
      final originTimeJst = DateTime.utc(
        dateSegments[0],
        dateSegments[1],
        dateSegments[2],
        int.parse(timeSegments[0]),
        int.parse(timeSegments[1]),
        int.parse(secondSegments[0]),
        secondSegments.length > 1
            ? (double.parse('0.${secondSegments[1]}') * 1000).round()
            : 0,
      );
      final originTime = originTimeJst.subtract(_jstOffset);

      final magnitude2Str = match.group(10);
      final magnitudeFlag = match.group(11);

      return HinetJmalistEvent(
        originTime: originTime,
        timeError: double.parse(match.group(3)!),
        latitude: double.parse(match.group(4)!),
        latitudeError: double.parse(match.group(5)!),
        longitude: double.parse(match.group(6)!),
        longitudeError: double.parse(match.group(7)!),
        depthKm: double.parse(match.group(8)!),
        magnitude1: double.parse(match.group(9)!),
        magnitude2: magnitude2Str == null ? null : double.parse(magnitude2Str),
        magnitudeFlag: (magnitudeFlag == null || magnitudeFlag.isEmpty)
            ? null
            : magnitudeFlag,
        regionNameEn: match.group(12)!,
        qualityCode: match.group(13)!,
      );
    } on FormatException {
      return null;
    }
  }
}
