import 'package:eqmonitor/core/model/telegram/telegram_type.dart';
import 'package:eqmonitor/feature/tsunami/data/logic/tracked_tsunami_timeline_to_public_mapper.dart';
import 'package:eqmonitor/feature/tsunami/data/model/tracking/tracked_region.dart';
import 'package:eqmonitor/feature/tsunami/data/model/tracking/tracked_tsunami_timeline.dart';
import 'package:eqmonitor/feature/tsunami/data/model/tracking/tracked_value.dart';
import 'package:eqmonitor/feature/tsunami/data/model/tsunami_forecast_max_height.dart';
import 'package:eqmonitor/feature/tsunami/data/model/tsunami_telegram_meta.dart';
import 'package:eqmonitor/feature/tsunami/data/model/value/qualitative_height.dart';
import 'package:eqmonitor/feature/tsunami/data/model/value/revise.dart';
import 'package:eqmonitor/feature/tsunami/data/model/value/tsunami_warning_kind.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // 電文メタを組み立てるヘルパ（テスト内ローカル関数）
  TsunamiTelegramMeta meta(String id, {required DateTime publishedAt}) =>
      TsunamiTelegramMeta(
        telegramId: id,
        type: TelegramType.vtse41,
        serialNo: 1,
        title: 'title-$id',
        headline: null,
        publishedAt: publishedAt,
        reportedAt: publishedAt,
        targetedAt: null,
        revokedAt: null,
        infoKind: 'k',
      );

  test('kind の変化点が電文メタと結合されて公開型になる', () {
    final tracked = TrackedTsunamiTimeline(
      telegrams: [meta('t1', publishedAt: DateTime(2026, 1, 15))],
      regions: [
        const TrackedRegion(
          code: '100',
          name: '宮城',
          kind: [
            TrackedValue(value: TsunamiWarningKind.warning, telegramId: 't1'),
          ],
          lastKind: [],
          forecastFirstHeight: [],
          forecastMaxHeight: [],
          estimationFirstHeight: [],
          estimationMaxHeight: [],
          stations: [],
        ),
      ],
      offshoreStations: const [],
    );

    final public = tracked.toPublic();

    final region = public.regions.single;
    expect(region.code, '100');
    expect(region.kind.single.kind, TsunamiWarningKind.warning);
    expect(region.kind.single.telegramId, 't1');
    expect(region.kind.single.title, 'title-t1');
  });

  test('multi-field concern (forecastMaxHeight) が値・メタともに結合される', () {
    final publishedAt = DateTime(2026, 1, 15, 3);
    final tracked = TrackedTsunamiTimeline(
      telegrams: [meta('t9', publishedAt: publishedAt)],
      regions: [
        const TrackedRegion(
          code: '100',
          name: '宮城',
          kind: [],
          lastKind: [],
          forecastFirstHeight: [],
          forecastMaxHeight: [
            TrackedValue(
              value: TsunamiForecastMaxHeight(
                value: 5,
                isOver: true,
                qualitative: QualitativeHeight.high,
                isImportant: true,
                revise: Revise.update,
              ),
              telegramId: 't9',
            ),
          ],
          estimationFirstHeight: [],
          estimationMaxHeight: [],
          stations: [],
        ),
      ],
      offshoreStations: const [],
    );

    final entry = tracked.toPublic().regions.single.forecastMaxHeight.single;

    // 追跡項目フィールド
    expect(entry.value, 5.0);
    expect(entry.isOver, isTrue);
    expect(entry.qualitative, QualitativeHeight.high);
    expect(entry.isImportant, isTrue);
    expect(entry.revise, Revise.update);
    // 電文メタ
    expect(entry.telegramId, 't9');
    expect(entry.title, 'title-t9');
    expect(entry.publishedAt, publishedAt);
  });
}
