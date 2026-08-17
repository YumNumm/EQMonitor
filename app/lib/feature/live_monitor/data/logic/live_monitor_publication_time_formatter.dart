import 'package:intl/intl.dart';

class LiveMonitorPublicationTimeFormatter {
  const new();

  String format({required DateTime reportedAt, required DateTime now}) {
    final rawElapsed = now.toUtc().difference(reportedAt.toUtc());
    final elapsed = rawElapsed.isNegative ? Duration.zero : rawElapsed;
    final minutes = elapsed.inMinutes.remainder(60).toString().padLeft(2, '0');
    return '${DateFormat('yyyy/MM/dd HH:mm').format(reportedAt.toLocal())} '
        '発表 (${elapsed.inHours}時間$minutes分前)';
  }
}
