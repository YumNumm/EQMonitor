import 'dart:async';

import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/telegram/telegram_info_type.dart';
import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/core/provider/time_ticker.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_warning_overlay_candidate.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_warning_overlay_display_model.dart';
import 'package:eqmonitor/feature/eew/data/provider/eew_warning_overlay_candidate_provider.dart';
import 'package:eqmonitor/feature/eew/data/provider/eew_warning_overlay_display_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

EewWarningOverlayCandidate _candidate() => EewWarningOverlayCandidate(
  event: EewTelegramItem(
    eventId: 'event',
    status: TelegramStatus.normal,
    infoType: TelegramInfoType.publication,
    serialNo: 1,
    isCanceled: false,
    isLastInfo: false,
    reportTime: DateTime.utc(2026, 7, 25, 11, 59),
    isPlum: false,
    isWarning: true,
    warning: const EewWarningInfo(zones: [], prefectures: [], regions: []),
  ),
  warningAreaCode: '100',
  warningAreaName: '警報判定区域',
  forecastAreaName: '震度予報区域',
  localForecastRegion: EewForecastRegionInfo(
    code: '200',
    name: '震度予報区域',
    isPlum: false,
    isWarning: true,
    intensity: JmaIntensity.sixUpper,
    intensityIsOver: false,
    arrivalTime: DateTime.utc(2026, 7, 25, 12, 0, 10),
  ),
);

void main() {
  test('ticker更新で到達秒数と代表を再計算する', () async {
    final ticker = StreamController<DateTime>.broadcast();
    addTearDown(ticker.close);
    final container = ProviderContainer(
      overrides: [
        eewWarningOverlayCandidatesProvider.overrideWithValue([_candidate()]),
        timeTickerProvider().overrideWith((ref) => ticker.stream),
      ],
    );
    addTearDown(container.dispose);
    final subscription = container.listen(
      eewWarningOverlayDisplayProvider,
      (_, _) {},
    );
    addTearDown(subscription.close);

    ticker.add(DateTime.utc(2026, 7, 25, 12));
    await container.pump();
    expect(
      container.read(eewWarningOverlayDisplayProvider)?.secondsUntilArrival,
      10,
    );

    ticker.add(DateTime.utc(2026, 7, 25, 12, 0, 10));
    await container.pump();
    expect(
      container.read(eewWarningOverlayDisplayProvider)?.arrivalState,
      EewWarningArrivalState.arrived,
    );
  });

  test('候補が空なら表示しない', () {
    final container = ProviderContainer(
      overrides: [
        eewWarningOverlayCandidatesProvider.overrideWithValue(const []),
      ],
    );
    addTearDown(container.dispose);

    expect(container.read(eewWarningOverlayDisplayProvider), isNull);
  });
}
