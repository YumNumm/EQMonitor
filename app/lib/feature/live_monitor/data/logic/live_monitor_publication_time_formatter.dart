import 'package:eqmonitor/core/util/date_time_format.dart';

class LiveMonitorPublicationTimeFormatter {
  const new();

  String format({required DateTime reportedAt, required DateTime now}) {
    final rawElapsed = now.toUtc().difference(reportedAt.toUtc());
    final elapsed = rawElapsed.isNegative ? Duration.zero : rawElapsed;
    final minutes = elapsed.inMinutes.remainder(60).toString().padLeft(2, '0');
    return '${reportedAt.formatWithTz(DateTimeFormat.yearMonthDayHourMinute)} '
        '発表 (${elapsed.inHours}時間$minutes分前)';
  }
}
