import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_sort_by.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('選択地域の観測震度は地域別APIのintensityソートに変換する', () {
    expect(
      EarthquakeSortBy.regionalIntensity.toApiIntensitySearchSortBy,
      api.IntensitySearchSortBy.intensity,
    );
  });

  test('選択地域の観測震度は全地震APIのソートに変換できない', () {
    expect(
      () => EarthquakeSortBy.regionalIntensity.toApiEarthquakeSortBy,
      throwsStateError,
    );
  });
}
