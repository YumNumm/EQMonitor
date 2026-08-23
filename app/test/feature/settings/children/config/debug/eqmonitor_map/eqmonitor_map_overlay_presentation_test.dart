// ignore_for_file: invalid_use_of_internal_member

import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/feature/earthquake_history/data/provider/latest_earthquake_overlay_provider.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/eqmonitor_map/eqmonitor_map_overlay_banner.dart';
import 'package:eqmonitor_map/eqmonitor_map.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

EarthquakeMapOverlaySnapshot _snapshot(String sourceId) =>
    createEarthquakeMapOverlaySnapshot(
      sourceId: sourceId,
      revision: 12,
      regionToCityZoom: 6,
      stationMinZoom: 6,
      regionStyles: const [],
      cityStyles: const [],
      stations: const [],
    );

LatestEarthquakeOverlayData _available(String eventId) =>
    LatestEarthquakeOverlayData(
      eventId: eventId,
      originTime: DateTime.utc(2026, 8, 23, 12, 34),
      telegramStatus: TelegramStatus.normal,
      availability: LatestEarthquakeOverlayAvailability.available,
      overlay: _snapshot(eventId),
    );

void main() {
  test('previous overlayを持つloadingでもoverlayをnullにして切替中を示す', () {
    final loading = const AsyncLoading<LatestEarthquakeOverlayData>()
        .copyWithPrevious(AsyncData(_available('A')));
    final presentation = EqmonitorMapOverlayPresentation.from(
      overlayState: loading,
      coverageSnapshot: null,
    );

    expect(presentation.overlay, isNull);
    expect(presentation.message, '最新の地震情報を取得中です');
    expect(presentation.eventIdLabel, '取得中');
  });

  test('previous overlayを持つerrorでもoverlayをnullにして例外全文を隠す', () {
    final error = AsyncError<LatestEarthquakeOverlayData>(
      Exception('非常に長い内部例外: secret-url-and-stack'),
      StackTrace.current,
    ).copyWithPrevious(AsyncData(_available('A')));
    final presentation = EqmonitorMapOverlayPresentation.from(
      overlayState: error,
      coverageSnapshot: null,
    );

    expect(presentation.overlay, isNull);
    expect(presentation.message, '最新の地震情報を取得できませんでした');
    expect(presentation.message, isNot(contains('secret-url')));
  });

  test('震度データなしはoverlayをnullにして専用状態を示す', () {
    const data = LatestEarthquakeOverlayData(
      eventId: 'A',
      originTime: null,
      telegramStatus: TelegramStatus.training,
      availability: LatestEarthquakeOverlayAvailability.noIntensity,
      overlay: null,
    );
    final presentation = EqmonitorMapOverlayPresentation.from(
      overlayState: const AsyncData(data),
      coverageSnapshot: null,
    );

    expect(presentation.overlay, isNull);
    expect(presentation.message, '震度データがありません');
    expect(presentation.statusLabel, '訓練');
  });

  test('current overlayのcoverage不完全をbannerへ明示する', () {
    final data = _available('A');
    final presentation = EqmonitorMapOverlayPresentation.from(
      overlayState: AsyncData(data),
      coverageSnapshot: (
        sourceId: 'A',
        revision: 12,
        coverage: const EarthquakeOverlayCoverage.incomplete(
          requestedTileCount: 4,
          readyTileCount: 3,
          missingOrInvalidCodeCount: 1,
        ),
      ),
    );

    expect(presentation.overlay, same(data.overlay));
    expect(presentation.message, '表示範囲の震度情報は不完全です');
  });

  test('旧sourceのcoverageをcurrent overlayへ適用しない', () {
    final presentation = EqmonitorMapOverlayPresentation.from(
      overlayState: AsyncData(_available('B')),
      coverageSnapshot: (
        sourceId: 'A',
        revision: 12,
        coverage: const EarthquakeOverlayCoverage.complete(
          requestedTileCount: 4,
        ),
      ),
    );

    expect(presentation.message, '表示範囲の震度情報を準備中です');
  });
}
