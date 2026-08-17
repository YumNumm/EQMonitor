import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_sort_by.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/sort_order.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('isDefaultAll: 既定 All は true', () {
    expect(
      const EarthquakeHistoryParameter.all(
        sortBy: EarthquakeSortBy.eventId,
        sortOrder: SortOrder.desc,
      ).isDefaultAll,
      isTrue,
    );
  });

  test('isDefaultAll: magnitudeGte 付き All は false', () {
    expect(
      const EarthquakeHistoryParameter.all(
        sortBy: EarthquakeSortBy.eventId,
        sortOrder: SortOrder.desc,
        magnitudeGte: 5,
      ).isDefaultAll,
      isFalse,
    );
  });

  test('isDefaultAll: prefecture 検索は false', () {
    expect(
      const EarthquakeHistoryParameter.prefecture(
        sortBy: EarthquakeSortBy.eventId,
        sortOrder: SortOrder.desc,
        prefectureCode: '13',
      ).isDefaultAll,
      isFalse,
    );
  });
}
