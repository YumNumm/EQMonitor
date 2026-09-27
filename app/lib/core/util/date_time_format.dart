import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;

enum DateTimeFormat(final String pattern) {
  yearMonthDay('yyyy/MM/dd'),
  yearMonthDayJapanese('yyyy年MM月dd日'),
  monthDay('MM/dd'),
  hourMinute('HH:mm'),
  hourMinuteSecond('HH:mm:ss'),
  monthDayHourMinute('MM/dd HH:mm'),
  monthDayHourMinuteSecond('MM/dd HH:mm:ss'),
  yearMonthDayHourMinute('yyyy/MM/dd HH:mm'),
  yearMonthDayHourMinuteJapanese('yyyy年MM月dd日 HH:mm'),
  yearMonthDayHourMinuteSecond('yyyy/MM/dd HH:mm:ss'),
  yearMonthDayHourMinuteSecondHyphen('yyyy-MM-dd HH:mm:ss'),
  yearMonthDayHourMinuteSecondMillisecond('yyyy/MM/dd HH:mm:ss.SSS'),
  ;

  static final _formatters = values
      .map((value) => DateFormat(value.pattern))
      .toList(growable: false);

  DateFormat get formatter => _formatters[index];
}

extension DateTimeFormatting on DateTime {
  static final _tokyo = tz.getLocation('Asia/Tokyo');

  tz.TZDateTime get tokyoDateTime => tz.TZDateTime.from(this, _tokyo);

  String formatWithTz(DateTimeFormat format) =>
      format.formatter.format(tokyoDateTime);
}
