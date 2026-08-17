import 'package:eqmonitor/feature/live_monitor/data/logic/live_monitor_publication_time_formatter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const formatter = LiveMonitorPublicationTimeFormatter();

  test('24時間を超えても累積時間と2桁分で表示する', () {
    final reportedAt = DateTime(2026, 7, 26, 12, 3);
    final now = DateTime(2026, 7, 27, 17, 10);

    expect(
      formatter.format(reportedAt: reportedAt, now: now),
      '2026/07/26 12:03 発表 (29時間07分前)',
    );
  });

  test('端末時刻より未来なら経過時間を0へ丸める', () {
    final reportedAt = DateTime(2026, 7, 27, 17, 11);
    final now = DateTime(2026, 7, 27, 17, 10);

    expect(
      formatter.format(reportedAt: reportedAt, now: now),
      '2026/07/27 17:11 発表 (0時間00分前)',
    );
  });
}
