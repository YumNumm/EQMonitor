import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_sort_by.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_sort_selection.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/sort_order.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('EarthquakeSortSelection.selecting', () {
    test('同じ項目を選ぶと並び順を入れ替える', () {
      const current = EarthquakeSortSelection(
        sortBy: EarthquakeSortBy.eventId,
        sortOrder: SortOrder.desc,
      );

      final next = current.selecting(EarthquakeSortBy.eventId);

      expect(next.sortBy, EarthquakeSortBy.eventId);
      expect(next.sortOrder, SortOrder.asc);
    });

    test('別項目を選ぶと降順を初期値にする', () {
      const current = EarthquakeSortSelection(
        sortBy: EarthquakeSortBy.eventId,
        sortOrder: SortOrder.asc,
      );

      final next = current.selecting(EarthquakeSortBy.magnitude);

      expect(next.sortBy, EarthquakeSortBy.magnitude);
      expect(next.sortOrder, SortOrder.desc);
    });

    test('深さを選ぶと昇順を初期値にする', () {
      const current = EarthquakeSortSelection(
        sortBy: EarthquakeSortBy.maxIntensity,
        sortOrder: SortOrder.desc,
      );

      final next = current.selecting(EarthquakeSortBy.depth);

      expect(next.sortBy, EarthquakeSortBy.depth);
      expect(next.sortOrder, SortOrder.asc);
    });
  });
}
