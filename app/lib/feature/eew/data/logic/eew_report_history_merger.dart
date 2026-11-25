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
    final reportsByKey = <EewTelegramKey, EewTelegramItem>{};
    for (final report in reports) {
      if (report.eventId != eventId) {
        continue;
      }
      final previous = reportsByKey[report.key];
      if (previous == null ||
          !report.reportTime.isBefore(previous.reportTime)) {
        reportsByKey[report.key] = report;
      }
    }
    return reportsByKey.values.sorted((a, b) => a.compareReportOrder(b));
  }
}
