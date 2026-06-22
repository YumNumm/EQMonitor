import 'package:eqmonitor/feature/tsunami/data/model/tracking/tracked_tsunami_timeline.dart';
import 'package:eqmonitor/feature/tsunami/data/model/value/tsunami_warning_kind.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter_test/flutter_test.dart';

void main() {
  // 電文を組み立てるヘルパ（テスト内ローカル関数: トップレベル関数禁止のため）
  test('kind の変化点のみが記録される', () {
    api.LatestTelegram tg(String id, DateTime at) => api.LatestTelegram(
      id: id,
      type: api.TelegramType.vtse51,
      title: 't',
      editorialOffice: 'eo',
      publishingOffice: const ['po'],
      pressedAt: at,
      reportedAt: at,
      infoKind: 'k',
    );
    api.TsunamiState stateWithKind(api.TsunamiWarningKind kind) =>
        api.TsunamiState(
          id: 'x',
          eventIds: const ['e'],
          isActive: true,
          isCanceled: false,
          updatedAt: DateTime(2026),
          earthquakes: const [],
          latestTelegrams: const [],
          regions: [
            api.TsunamiRegion(
              code: '100',
              name: '宮城',
              kind: kind,
              lastKind: kind,
              stations: const [],
            ),
          ],
          offshoreStations: const [],
        );
    final response = api.TsunamiTelegramsResponse(
      telegrams: [
        api.TsunamiTelegramWithState(
          telegram: tg('t1', DateTime(2026, 1, 1, 0, 0)),
          state: stateWithKind(api.TsunamiWarningKind.warning),
        ),
        api.TsunamiTelegramWithState(
          telegram: tg('t2', DateTime(2026, 1, 1, 0, 5)),
          state: stateWithKind(api.TsunamiWarningKind.warning), // 変化なし
        ),
        api.TsunamiTelegramWithState(
          telegram: tg('t3', DateTime(2026, 1, 1, 0, 10)),
          state: stateWithKind(
            api.TsunamiWarningKind.majorWarning,
          ), // 変化
        ),
      ],
    );

    final timeline = response.toTrackedTimeline();

    expect(timeline.telegrams.map((e) => e.telegramId), ['t1', 't2', 't3']);
    final region = timeline.regions.single;
    expect(region.kind.map((e) => e.telegramId), ['t1', 't3']);
    expect(region.kind.map((e) => e.value), [
      TsunamiWarningKind.warning,
      TsunamiWarningKind.majorWarning,
    ]);
  });
}
