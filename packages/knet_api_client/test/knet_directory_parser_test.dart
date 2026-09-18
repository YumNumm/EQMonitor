import 'dart:io';

import 'package:knet_api_client/knet_api_client.dart';
import 'package:test/test.dart';
import 'package:timezone/data/latest.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

String _fixture(String name) => File('test/fixtures/$name').readAsStringSync();

void main() {
  setUpAll(tz_data.initializeTimeZones);

  group('KnetDirectoryParser.parseYears', () {
    late String html;

    setUp(() {
      html = _fixture('zip_root.html');
    });

    test('1996〜2026 の年を昇順で返す', () {
      final years = KnetDirectoryParser.parseYears(html);
      expect(years.first, 1996);
      expect(years.last, 2026);
      expect(years, equals(List.generate(31, (i) => 1996 + i)));
    });

    test('親ディレクトリを除外する', () {
      final entries = KnetDirectoryParser.parseEntries(html);
      expect(entries.every((e) => !e.startsWith('/')), isTrue);
    });
  });

  group('KnetDirectoryParser.parseMonths', () {
    late String html;

    setUp(() {
      html = _fixture('zip_2024.html');
    });

    test('1〜12 の月を昇順で返す', () {
      final months = KnetDirectoryParser.parseMonths(html);
      expect(months, equals(List.generate(12, (i) => i + 1)));
    });
  });

  group('KnetDirectoryParser.parseRecords', () {
    late String html;

    setUp(() {
      html = _fixture('zip_2024_01.html');
    });

    test('先頭レコードが 2024-01-01 16:06:00', () {
      final records = KnetDirectoryParser.parseRecords(html);
      final first = records.first;
      expect(first, isA<tz.TZDateTime>());
      expect(first.location.name, 'Asia/Tokyo');
      expect(first.toUtc(), DateTime.utc(2024, 1, 1, 7, 6));
    });

    test('すべて 2024 年 1 月のレコードである', () {
      final records = KnetDirectoryParser.parseRecords(html);
      expect(records.every((dt) => dt.year == 2024 && dt.month == 1), isTrue);
    });

    test('レコード数が 1 件以上', () {
      final records = KnetDirectoryParser.parseRecords(html);
      expect(records, isNotEmpty);
    });

    test('不正なエントリを含む HTML でもクラッシュしない', () {
      const badHtml = '''
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN">
<html><body>
<ul>
<li><a href="/kyoshin/download/all/zip/2024/"> Parent Directory</a></li>
<li><a href="notadatetime/"> notadatetime/</a></li>
<li><a href="2024010116060X/"> 2024010116060X/</a></li>
<li><a href="20240101160600/"> 20240101160600/</a></li>
</ul>
</body></html>''';
      final records = KnetDirectoryParser.parseRecords(badHtml);
      expect(records, hasLength(1));
      expect(records.first.toUtc(), DateTime.utc(2024, 1, 1, 7, 6));
    });
  });

  group('KnetDirectoryParser.parseEntries', () {
    test('ファイルリンク（末尾スラッシュなし）を除外する', () {
      const html = '''
<ul>
<li><a href="/parent/"> Parent Directory</a></li>
<li><a href="dir/"> dir/</a></li>
<li><a href="file.csv"> file.csv</a></li>
</ul>''';
      final entries = KnetDirectoryParser.parseEntries(html);
      expect(entries, equals(['dir']));
    });

    test('空の HTML で空リストを返す', () {
      final entries = KnetDirectoryParser.parseEntries('<html></html>');
      expect(entries, isEmpty);
    });
  });
}
