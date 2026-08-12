import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_sort_by.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('EarthquakeSortBy.showsDateHeader', () {
    test('発生時刻ソートでは日付ヘッダーを表示する', () {
      expect(EarthquakeSortBy.eventId.showsDateHeader, isTrue);
    });

    test('発生時刻以外のソートでは日付ヘッダーを表示しない', () {
      final nonEventTimeSorts = EarthquakeSortBy.values.where(
        (sortBy) => sortBy != EarthquakeSortBy.eventId,
      );

      expect(
        nonEventTimeSorts.every((sortBy) => !sortBy.showsDateHeader),
        isTrue,
      );
    });
  });
}
