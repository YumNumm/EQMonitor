import 'package:collection/collection.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'eew_report_history_merger.g.dart';

@riverpod
EewReportHistoryMerger eewReportHistoryMerger(Ref ref) =>
    const EewReportHistoryMerger();

class const EewReportHistoryMerger() {
  List<EewTelegramItem> merge({
    required String eventId,
    required Iterable<EewTelegramItem> reports,
  }) {
    final reportsBySerial = <int, EewTelegramItem>{};
    for (final report in reports) {
      if (report.eventId != eventId) {
        continue;
      }
      final previous = reportsBySerial[report.serialNo];
      if (previous == null ||
          !report.reportTime.isBefore(previous.reportTime)) {
        reportsBySerial[report.serialNo] = report;
      }
    }
    return reportsBySerial.values.sortedBy<num>((report) => report.serialNo);
  }
}
