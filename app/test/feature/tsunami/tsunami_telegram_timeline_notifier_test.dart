import 'package:eqmonitor/feature/tsunami/data/model/timeline/tsunami_timeline.dart';
import 'package:eqmonitor/feature/tsunami/data/model/tracking/tracked_region.dart';
import 'package:eqmonitor/feature/tsunami/data/model/tracking/tracked_tsunami_timeline.dart';
import 'package:eqmonitor/feature/tsunami/data/model/tracking/tracked_value.dart';
import 'package:eqmonitor/feature/tsunami/data/model/tsunami_telegram_meta.dart';
import 'package:eqmonitor/feature/tsunami/data/model/value/tsunami_warning_kind.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('kind の変化点が電文メタと結合されて公開型になる', () {
    final meta = [
      TsunamiTelegramMeta(
        telegramId: 't1',
        serialNo: 1,
        title: 'T1',
        headline: null,
        publishedAt: DateTime(2026, 1, 1),
        reportedAt: DateTime(2026, 1, 1),
        targetedAt: null,
        revokedAt: null,
        infoKind: 'k',
      ),
    ];
    final tracked = TrackedTsunamiTimeline(
      telegrams: meta,
      regions: [
        TrackedRegion(
          code: '100',
          name: '宮城',
          kind: [
            const TrackedValue(
              value: TsunamiWarningKind.warning,
              telegramId: 't1',
            ),
          ],
          lastKind: const [],
          forecastFirstHeight: const [],
          forecastMaxHeight: const [],
          estimationFirstHeight: const [],
          estimationMaxHeight: const [],
          stations: const [],
        ),
      ],
      offshoreStations: const [],
    );

    final TsunamiTimeline public = tracked.toPublic();

    final region = public.regions.single;
    expect(region.code, '100');
    expect(region.kind.single.kind, TsunamiWarningKind.warning);
    expect(region.kind.single.telegramId, 't1');
    expect(region.kind.single.title, 'T1');
  });
}
