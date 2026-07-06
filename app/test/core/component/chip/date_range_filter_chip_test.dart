import 'package:eqmonitor/core/component/chip/date_range_filter_chip.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DateRangeFilterChip.clampInitialDateRange', () {
    final min = DateRangeFilterChip.initialMin;
    final max = DateRangeFilterChip.initialMax;
    final midDate = DateTime(2020);
    final laterDate = DateTime(2022);

    test('min null → null', () {
      expect(DateRangeFilterChip.clampInitialDateRange(null, midDate), isNull);
    });

    test('max null → null', () {
      expect(DateRangeFilterChip.clampInitialDateRange(midDate, null), isNull);
    });

    test('both null → null', () {
      expect(DateRangeFilterChip.clampInitialDateRange(null, null), isNull);
    });

    test('normal range within bounds → returned as-is', () {
      final result = DateRangeFilterChip.clampInitialDateRange(
        midDate,
        laterDate,
      );
      expect(result, isNotNull);
      expect(result!.start, midDate);
      expect(result.end, laterDate);
    });

    test('min before firstDate → clamped to firstDate', () {
      final beforeMin = DateTime(1900);
      final result = DateRangeFilterChip.clampInitialDateRange(
        beforeMin,
        midDate,
      );
      expect(result, isNotNull);
      expect(result!.start, min);
      expect(result.end, midDate);
    });

    test('max after lastDate → clamped to lastDate', () {
      final afterMax = DateTime(2099);
      final result = DateRangeFilterChip.clampInitialDateRange(
        midDate,
        afterMax,
      );
      expect(result, isNotNull);
      expect(result!.start, midDate);
      expect(result.end, max);
    });

    test('inverted range after clamp → null (start > end prevention)', () {
      // end(=DateTime(1800)) is not clamped to firstDate — only values after
      // lastDate are clamped; start(=laterDate=2022) > end(1800) → null
      final result = DateRangeFilterChip.clampInitialDateRange(
        laterDate,
        DateTime(1800),
      );
      expect(result, isNull);
    });

    test('same date for start and end → allowed', () {
      final result = DateRangeFilterChip.clampInitialDateRange(
        midDate,
        midDate,
      );
      expect(result, isNotNull);
      expect(result!.start, midDate);
      expect(result.end, midDate);
    });
  });
}
