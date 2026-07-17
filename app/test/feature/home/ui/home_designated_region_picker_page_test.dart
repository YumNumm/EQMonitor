import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_sort_by.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/sort_order.dart';
import 'package:eqmonitor/feature/home/ui/page/home_designated_region_picker_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// 「指定地域を選択」ページが、選択中の種別に応じた
/// [EarthquakeHistoryParameter] を返すことを検証する。
///
/// 以前は種別に関わらず常に `.city()` を生成していたため、
/// 都道府県コード (2桁) が cityCode として保存され
/// `Exception: Region not found` の原因となっていた。
void main() {
  Future<EarthquakeHistoryParameter?> pickWith(
    WidgetTester tester,
    EarthquakeHistoryParameter initialParameter,
  ) async {
    EarthquakeHistoryParameter? result;
    var picked = false;

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Builder(
            builder: (context) => Scaffold(
              body: Center(
                child: ElevatedButton(
                  onPressed: () async {
                    result = await HomeDesignatedRegionPickerPage.show(
                      context,
                      initialParameter: initialParameter,
                    );
                    picked = true;
                  },
                  child: const Text('open'),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('open'));
    // 画面遷移アニメーション完了(無限スピナーがあるため pumpAndSettle は使わない)
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    await tester.tap(find.text('決定'));
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    expect(picked, isTrue, reason: 'ページが結果を返して閉じるべき');
    return result;
  }

  testWidgets('都道府県を初期選択して決定すると Prefecture パラメータを返す', (tester) async {
    final result = await pickWith(
      tester,
      const EarthquakeHistoryParameter.prefecture(
        sortBy: EarthquakeSortBy.eventId,
        sortOrder: SortOrder.desc,
        prefectureCode: '14',
      ),
    );

    expect(result, isA<EarthquakeHistoryParameterPrefecture>());
    expect(
      (result as EarthquakeHistoryParameterPrefecture).prefectureCode,
      equals('14'),
    );
  });

  testWidgets('市区町村を初期選択して決定すると City パラメータを返す', (tester) async {
    final result = await pickWith(
      tester,
      const EarthquakeHistoryParameter.city(
        sortBy: EarthquakeSortBy.eventId,
        sortOrder: SortOrder.desc,
        cityCode: '1410000',
      ),
    );

    expect(result, isA<EarthquakeHistoryParameterCity>());
    expect(
      (result as EarthquakeHistoryParameterCity).cityCode,
      equals('1410000'),
    );
  });
}
