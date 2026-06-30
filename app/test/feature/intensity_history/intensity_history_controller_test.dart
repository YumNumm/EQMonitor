import 'package:eqmonitor/feature/intensity_history/data/model/intensity_history_state.dart';
import 'package:eqmonitor/feature/intensity_history/data/notifier/intensity_history_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  group('IntensityHistoryController', () {
    test('初期状態が Prefecture である', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final state = container.read(intensityHistoryControllerProvider);
      expect(state, isA<IntensityHistoryStatePrefecture>());
    });

    test('focusPrefecture で City 状態に遷移する', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      container
          .read(intensityHistoryControllerProvider.notifier)
          .focusPrefecture(code: '0100', name: '北海道');

      final state = container.read(intensityHistoryControllerProvider);
      expect(state, isA<IntensityHistoryStateCity>());
      final city = state as IntensityHistoryStateCity;
      expect(city.prefectureCode, '0100');
      expect(city.prefectureName, '北海道');
      expect(city.selectedCityCode, isNull);
      expect(city.selectedCityName, isNull);
    });

    test('backToPrefecture で Prefecture 状態に戻る', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      container
          .read(intensityHistoryControllerProvider.notifier)
          .focusPrefecture(code: '0100', name: '北海道');

      container
          .read(intensityHistoryControllerProvider.notifier)
          .backToPrefecture();

      final state = container.read(intensityHistoryControllerProvider);
      expect(state, isA<IntensityHistoryStatePrefecture>());
    });

    test('focusPrefecture を複数回呼ぶと最後の都道府県に更新される', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      container
          .read(intensityHistoryControllerProvider.notifier)
          .focusPrefecture(code: '0100', name: '北海道');

      container
          .read(intensityHistoryControllerProvider.notifier)
          .focusPrefecture(code: '0200', name: '青森県');

      final state = container.read(intensityHistoryControllerProvider);
      final city = state as IntensityHistoryStateCity;
      expect(city.prefectureCode, '0200');
      expect(city.prefectureName, '青森県');
    });

    test('focusPrefecture で市区町村も同時に選択できる', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      container
          .read(intensityHistoryControllerProvider.notifier)
          .focusPrefecture(
            code: '0400',
            name: '宮城県',
            selectedCityCode: '0410000',
            selectedCityName: '仙台市',
          );

      final state = container.read(intensityHistoryControllerProvider);
      final city = state as IntensityHistoryStateCity;
      expect(city.prefectureCode, '0400');
      expect(city.prefectureName, '宮城県');
      expect(city.selectedCityCode, '0410000');
      expect(city.selectedCityName, '仙台市');
    });

    test('selectCity でフォーカス中の市区町村を選択する', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      container
          .read(intensityHistoryControllerProvider.notifier)
          .focusPrefecture(code: '0400', name: '宮城県');
      container
          .read(intensityHistoryControllerProvider.notifier)
          .selectCity(code: '0410000', name: '仙台市');

      final state = container.read(intensityHistoryControllerProvider);
      final city = state as IntensityHistoryStateCity;
      expect(city.selectedCityCode, '0410000');
      expect(city.selectedCityName, '仙台市');
    });

    test('deselectCity で都道府県フォーカスを保ったまま市区町村選択を解除する', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      container
          .read(intensityHistoryControllerProvider.notifier)
          .focusPrefecture(
            code: '0400',
            name: '宮城県',
            selectedCityCode: '0410000',
            selectedCityName: '仙台市',
          );
      container
          .read(intensityHistoryControllerProvider.notifier)
          .deselectCity();

      final state = container.read(intensityHistoryControllerProvider);
      final city = state as IntensityHistoryStateCity;
      expect(city.prefectureCode, '0400');
      expect(city.prefectureName, '宮城県');
      expect(city.selectedCityCode, isNull);
      expect(city.selectedCityName, isNull);
    });
  });
}
