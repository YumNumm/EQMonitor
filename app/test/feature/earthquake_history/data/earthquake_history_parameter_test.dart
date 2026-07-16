import 'dart:convert';

import 'package:core/core.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_sort_by.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/sort_order.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const base = EarthquakeHistoryParameter.all(
    sortBy: EarthquakeSortBy.eventId,
    sortOrder: SortOrder.asc,
  );

  group('EarthquakeHistoryParameter — copyWith', () {
    test('震度フィルタを更新できる', () {
      final updated = base.copyWith(
        intensityGte: JmaIntensity.three,
        intensityLte: JmaIntensity.fiveLower,
      );
      expect(updated.intensityGte, JmaIntensity.three);
      expect(updated.intensityLte, JmaIntensity.fiveLower);
    });

    test('マグニチュードフィルタを更新できる', () {
      final updated = base.copyWith(magnitudeGte: 3.5, magnitudeLte: 7.5);
      expect(updated.magnitudeGte, 3.5);
      expect(updated.magnitudeLte, 7.5);
    });

    test('深さフィルタを更新できる', () {
      final updated = base.copyWith(depthGte: 20, depthLte: 100);
      expect(updated.depthGte, 20);
      expect(updated.depthLte, 100);
    });

    test('ステータスフィルタを更新できる', () {
      final updated = base.copyWith(
        statuses: [TelegramStatus.normal, TelegramStatus.test],
      );
      expect(updated.statuses, [TelegramStatus.normal, TelegramStatus.test]);
    });
  });

  group('EarthquakeHistoryParameter — JSON 文字列経由の往復', () {
    EarthquakeHistoryParameter roundTrip(EarthquakeHistoryParameter value) {
      return EarthquakeHistoryParameter.fromJson(
        jsonDecode(jsonEncode(value.toJson())) as Map<String, dynamic>,
      );
    }

    test('all variant でも往復できること', () {
      const original = EarthquakeHistoryParameter.all(
        sortBy: EarthquakeSortBy.eventId,
        sortOrder: SortOrder.desc,
        magnitudeGte: 3,
        magnitudeLte: 7,
        intensityGte: JmaIntensity.three,
        intensityLte: JmaIntensity.fiveUpper,
        statuses: [TelegramStatus.normal, TelegramStatus.training],
      );
      expect(roundTrip(original), original);
    });

    test('city variant でも往復できること', () {
      const original = EarthquakeHistoryParameter.city(
        sortBy: EarthquakeSortBy.maxIntensity,
        sortOrder: SortOrder.desc,
        cityCode: '13101',
        depthGte: 10,
        depthLte: 200,
        originTimeGte: Date(year: 2026, month: 1, day: 1),
        originTimeLte: Date(year: 2026, month: 12, day: 31),
      );
      expect(roundTrip(original), original);
    });

    test('prefecture variant でも往復できること', () {
      const original = EarthquakeHistoryParameter.prefecture(
        sortBy: EarthquakeSortBy.eventId,
        sortOrder: SortOrder.asc,
        prefectureCode: '13',
        intensityGte: JmaIntensity.two,
        intensityLte: JmaIntensity.seven,
      );
      expect(roundTrip(original), original);
    });
  });
}
