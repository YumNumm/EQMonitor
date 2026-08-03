import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/feature/earthquake_history/data/logic/earthquake_activity_binner.dart';
import 'package:eqmonitor/feature/earthquake_history/data/logic/earthquake_activity_summary_builder.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_activity_bin_interval.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_activity_intensity_category.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_activity_query.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_magnitude.dart';
import 'package:flutter_test/flutter_test.dart';

import '../earthquake_activity_test_data.dart';

void main() {
  final baseTime = DateTime.utc(2026, 7, 1, 12);
  final query = EarthquakeActivityQuery(
    baseEventId: 'base',
    baseOriginTime: baseTime,
    latitude: 35,
    longitude: 139,
    depth: 40,
    beforeDays: 1,
    afterDays: 7,
    radiusKm: 25,
    depthOffsetKm: 20,
  );

  test('前後件数・最大震度・最大M・最終発生時刻を集計する', () {
    final before = testActivityEarthquake(
      eventId: 'before',
      originTime: baseTime.subtract(const Duration(hours: 1)),
      magnitude: const EarthquakeMagnitude.value(value: 4.5),
      maxIntensity: JmaIntensity.three,
    );
    final after = testActivityEarthquake(
      eventId: 'after',
      originTime: baseTime.add(const Duration(hours: 2)),
      magnitude: const EarthquakeMagnitude.value(value: 5.2),
      maxIntensity: JmaIntensity.fiveLower,
    );

    final summary = const EarthquakeActivitySummaryBuilder().build(
      items: [after, before],
      query: query,
    );

    expect(summary.beforeCount, 1);
    expect(summary.afterCount, 1);
    expect(summary.maxIntensity, JmaIntensity.fiveLower);
    expect(summary.maxMagnitude, const EarthquakeMagnitude.value(value: 5.2));
    expect(summary.latestOriginTime, after.originTime);
  });

  test('震度0・強弱不明・情報なしを失わず6時間ビンへ集計する', () {
    final items = [
      testActivityEarthquake(
        eventId: 'zero',
        originTime: DateTime.utc(2026, 7, 1, 13),
        maxIntensity: JmaIntensity.zero,
      ),
      testActivityEarthquake(
        eventId: 'five-unknown',
        originTime: DateTime.utc(2026, 7, 1, 14),
        maxIntensity: JmaIntensity.fiveUnknown,
      ),
      testActivityEarthquake(
        eventId: 'six-unknown',
        originTime: DateTime.utc(2026, 7, 1, 15),
        maxIntensity: JmaIntensity.sixUnknown,
      ),
      testActivityEarthquake(
        eventId: 'no-info',
        originTime: DateTime.utc(2026, 7, 1, 16),
      ),
    ];

    final bins = const EarthquakeActivityBinner().build(
      items: items,
      interval: EarthquakeActivityBinInterval.sixHours,
    );

    expect(bins, hasLength(1));
    expect(bins.single.start, DateTime.utc(2026, 7, 1, 12));
    expect(bins.single.counts[EarthquakeActivityIntensityCategory.zero], 1);
    expect(
      bins.single.counts[EarthquakeActivityIntensityCategory.fiveUnknown],
      1,
    );
    expect(
      bins.single.counts[EarthquakeActivityIntensityCategory.sixUnknown],
      1,
    );
    expect(
      bins.single.counts[EarthquakeActivityIntensityCategory.noInformation],
      1,
    );
    expect(bins.single.totalCount, items.length);
  });

  test('初期8日間には6時間間隔を自動選択する', () {
    expect(
      EarthquakeActivityBinInterval.forDuration(const Duration(days: 8)),
      EarthquakeActivityBinInterval.sixHours,
    );
  });
}
