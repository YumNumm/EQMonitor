import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_sort_by.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/sort_order.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_data_source.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('isDefaultAllParameter: 既定 All は true', () {
    expect(
      isDefaultAllParameter(
        const EarthquakeHistoryParameter.all(
          sortBy: EarthquakeSortBy.eventId,
          sortOrder: SortOrder.desc,
        ),
      ),
      isTrue,
    );
  });

  test('isDefaultAllParameter: magnitudeGte 付き All は false', () {
    expect(
      isDefaultAllParameter(
        const EarthquakeHistoryParameter.all(
          sortBy: EarthquakeSortBy.eventId,
          sortOrder: SortOrder.desc,
          magnitudeGte: 5,
        ),
      ),
      isFalse,
    );
  });

  test('isDefaultAllParameter: prefecture 検索は false', () {
    expect(
      isDefaultAllParameter(
        const EarthquakeHistoryParameter.prefecture(
          sortBy: EarthquakeSortBy.eventId,
          sortOrder: SortOrder.desc,
          prefectureCode: '13',
        ),
      ),
      isFalse,
    );
  });
}
