import 'package:nied_api_client/src/hinet/jmalist/parser/hinet_jmalist_parser.dart';
import 'package:test/test.dart';

const _sampleLine1 =
    '2026-06-02 11:08:33.99  0.07   36.571  0.18  137.868  0.29     7.7   1.0  1.6V        NORTHERN NAGANO PREF  k';
const _sampleLine2 =
    '2026-06-02 11:23:56.58  0.11   24.443  0.34  123.876  0.34     8.7   1.5              NEAR ISHIGAKIJIMA ISLAND  k';

void main() {
  group('HinetJmalistParser', () {
    const parser = HinetJmalistParser();

    test('M2とフラグ付きの行をパースできる', () {
      final result = parser.parse(_sampleLine1);

      expect(result.events, hasLength(1));
      expect(result.skippedLineCount, 0);

      final event = result.events.single;
      // Hi-net jmalist の時刻は JST のため、UTC へ変換(-9h)した値を期待する。
      expect(event.originTime, DateTime.utc(2026, 6, 2, 2, 8, 33, 990));
      expect(event.originTime.isUtc, isTrue);
      expect(event.timeError, 0.07);
      expect(event.latitude, 36.571);
      expect(event.latitudeError, 0.18);
      expect(event.longitude, 137.868);
      expect(event.longitudeError, 0.29);
      expect(event.depthKm, 7.7);
      expect(event.magnitude1, 1.0);
      expect(event.magnitude2, 1.6);
      expect(event.magnitudeFlag, 'V');
      expect(event.regionNameEn, 'NORTHERN NAGANO PREF');
      expect(event.qualityCode, 'k');
    });

    test('M2欠測行をパースできる(M2/flagはnull)', () {
      final result = parser.parse(_sampleLine2);

      expect(result.events, hasLength(1));
      final event = result.events.single;
      expect(event.magnitude1, 1.5);
      expect(event.magnitude2, isNull);
      expect(event.magnitudeFlag, isNull);
      expect(event.regionNameEn, 'NEAR ISHIGAKIJIMA ISLAND');
    });

    test('FAR FIELD行はスキップしてカウントする', () {
      const farFieldLine =
          '2026-06-03 00:00:00.00  0.10   10.000  0.20  140.000  0.30     100.0   5.0        FAR FIELD  k';
      final result = parser.parse('$_sampleLine1\n$farFieldLine');

      expect(result.events, hasLength(1));
      expect(result.skippedLineCount, 1);
    });

    test('パース不能行はスキップしてカウントする', () {
      final result = parser.parse('$_sampleLine1\nnot a valid line\n');

      expect(result.events, hasLength(1));
      expect(result.skippedLineCount, 1);
    });

    test('空行・コメント行は無視する(スキップカウントにも含めない)', () {
      final result = parser.parse('\n# comment\n$_sampleLine1\n\n');

      expect(result.events, hasLength(1));
      expect(result.skippedLineCount, 0);
    });

    test('大量空白を含む不正な近似行を正規表現バックトラックなしでスキップする', () {
      final longSpaces = List.filled(2000, ' ').join();
      final sampleLinePrefix = _sampleLine1.substring(
        0,
        _sampleLine1.length - 1,
      );
      final craftedLine = '$sampleLinePrefix${longSpaces}1';
      final result = parser.parse(craftedLine);

      expect(result.events, isEmpty);
      expect(result.skippedLineCount, 1);
    });
  });
}
