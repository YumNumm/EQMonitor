import 'package:core/core.dart' as core;
import 'package:eqmonitor/core/util/date_time_format.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:timezone/timezone.dart' as tz;

void main() {
  setUpAll(core.initializeTimeZones);

  group('DateTimeFormatting.formatWithTz', () {
    test('UTC 15:00 は Tokyo の翌日 00:00 になる', () {
      final value = DateTime.utc(2026, 8, 18, 15);

      expect(
        value.formatWithTz(DateTimeFormat.yearMonthDayHourMinuteSecond),
        '2026/08/19 00:00:00',
      );
    });

    test('同じ瞬間の UTC と端末 local は同じ文字列になる', () {
      final utc = DateTime.utc(2026, 8, 18, 15, 17, 30);

      expect(
        utc.formatWithTz(DateTimeFormat.yearMonthDayHourMinuteSecond),
        utc.toLocal().formatWithTz(
          DateTimeFormat.yearMonthDayHourMinuteSecond,
        ),
      );
    });

    test('別 timezone の TZDateTime も Tokyo 表示になる', () {
      final value = tz.TZDateTime(
        tz.getLocation('America/Los_Angeles'),
        2026,
        8,
        18,
        8,
      );

      expect(value.formatWithTz(DateTimeFormat.hourMinute), '00:00');
    });

    test('秒・ミリ秒・日本語年月日の形式を維持する', () {
      final value = DateTime.utc(2026, 8, 18, 15, 17, 30, 456);

      expect(
        value.formatWithTz(
          DateTimeFormat.yearMonthDayHourMinuteSecondMillisecond,
        ),
        '2026/08/19 00:17:30.456',
      );
      expect(
        value.formatWithTz(DateTimeFormat.yearMonthDayHourMinuteJapanese),
        '2026年08月19日 00:17',
      );
    });
  });

  group('DateTimeFormat', () {
    test('全形式がキャッシュ済み DateFormat を持つ', () {
      for (final format in DateTimeFormat.values) {
        expect(format.formatter, same(format.formatter));
      }
    });
  });

  group('DateTimeFormatting.tokyoDateTime', () {
    test('Tokyo の ISO 8601 表示に UTC offset を含む', () {
      final value = DateTime.utc(2026, 8, 18, 15).tokyoDateTime;

      expect(value.timeZoneOffset, const Duration(hours: 9));
      expect(value.toIso8601String(), contains('2026-08-19T00:00:00'));
    });
  });
}
