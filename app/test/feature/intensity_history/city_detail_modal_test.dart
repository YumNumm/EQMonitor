import 'package:dio/dio.dart';
import 'package:eqmonitor/core/provider/shared_preferences.dart' as app_prefs;
import 'package:eqmonitor/feature/intensity_history/data/model/city_intensity_page.dart';
import 'package:eqmonitor/feature/intensity_history/data/notifier/city_intensity_list_data_source.dart';
import 'package:eqmonitor/feature/intensity_history/data/repository/intensity_highest_repository.dart';
import 'package:eqmonitor/feature/intensity_history/ui/components/city_detail_modal.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// モーダルを pump するための足場。
///
/// [showCityDetailModal] は `showModalBottomSheet` を直接呼ぶため、
/// モーダル本体を Widget として直接ビルドするヘルパーを使う。
class _ModalWrapper extends ConsumerWidget {
  const _ModalWrapper({required this.cityCode, required this.cityName});

  final String cityCode;
  final String cityName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: () =>
          showCityDetailModal(context, cityCode: cityCode, cityName: cityName),
      child: const Text('open'),
    );
  }
}

class _FakeEmptyRepository extends IntensityHighestRepository {
  _FakeEmptyRepository() : super(earthquake: api.ApiClient(Dio()).earthquake);

  @override
  Future<CityIntensityPage> fetchCityIntensityList({
    required String cityCode,
    required int limit,
    String? cursor,
  }) async => const CityIntensityPage(items: [], nextToken: null);
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('市区町村名がモーダルに表示される', (tester) async {
    // モーダルのスケルトンリストが収まるよう画面サイズを広くする。
    await tester.binding.setSurfaceSize(const Size(800, 1200));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    SharedPreferences.setMockInitialValues({});
    final preferences = await SharedPreferences.getInstance();

    final container = ProviderContainer(
      overrides: [
        app_prefs.sharedPreferencesProvider.overrideWithValue(
          app_prefs.SharedPreferencesAsync(preferences),
        ),
        cityIntensityListDataSourceProvider('city-1').overrideWith(
          (ref) async => CityIntensityListDataSource(
            repository: _FakeEmptyRepository(),
            cityCode: 'city-1',
          ),
        ),
      ],
    );
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(
          home: Scaffold(
            body: _ModalWrapper(
              cityCode: 'city-1',
              cityName: '仙台市',
            ),
          ),
        ),
      ),
    );

    // ボタンをタップしてモーダルを開く
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    // 市区町村名が表示されていることを確認
    expect(find.text('仙台市'), findsOneWidget);
  });
}
