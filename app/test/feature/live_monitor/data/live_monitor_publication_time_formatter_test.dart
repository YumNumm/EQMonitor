import 'package:core/core.dart' as core;
import 'package:eqmonitor/feature/live_monitor/data/logic/live_monitor_publication_time_formatter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUpAll(core.initializeTimeZones);

  const formatter = LiveMonitorPublicationTimeFormatter();

  test('24時間を超えても累積時間と2桁分で表示する', () {
    final reportedAt = DateTime.utc(2026, 7, 26, 3, 3);
    final now = DateTime.utc(2026, 7, 27, 8, 10);

    expect(
      formatter.format(reportedAt: reportedAt, now: now),
      '2026/07/26 12:03 発表 (29時間07分前)',
    );
  });

  test('端末時刻より未来なら経過時間を0へ丸める', () {
    final reportedAt = DateTime.utc(2026, 7, 27, 8, 11);
    final now = DateTime.utc(2026, 7, 27, 8, 10);

    expect(
      formatter.format(reportedAt: reportedAt, now: now),
      '2026/07/27 17:11 発表 (0時間00分前)',
    );
  });

  test('UTC日付境界をTokyoの翌日として表示する', () {
    final reportedAt = DateTime.utc(2026, 8, 18, 15);

    expect(
      formatter.format(
        reportedAt: reportedAt,
        now: reportedAt.add(const Duration(minutes: 1)),
      ),
      '2026/08/19 00:00 発表 (0時間01分前)',
    );
  });
}
