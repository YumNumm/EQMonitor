import 'package:eqmonitor/feature/intensity_history/data/notifier/intensity_history_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  group('IntensityHistoryController', () {
    test('初期状態は市区町村未選択である', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final state = container.read(intensityHistoryControllerProvider);
      expect(state.selectedCity, isNull);
    });

    test('selectCity で市区町村を選択する', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      container
          .read(intensityHistoryControllerProvider.notifier)
          .selectCity(
            code: '0410000',
            name: '仙台市',
            prefectureName: '宮城県',
          );

      final selectedCity = container
          .read(intensityHistoryControllerProvider)
          .selectedCity;
      expect(selectedCity?.code, '0410000');
      expect(selectedCity?.name, '仙台市');
      expect(selectedCity?.prefectureName, '宮城県');
    });

    test('selectCity を複数回呼ぶと最後の市区町村に更新される', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(
        intensityHistoryControllerProvider.notifier,
      );
      notifier.selectCity(
        code: '0410000',
        name: '仙台市',
        prefectureName: '宮城県',
      );
      notifier.selectCity(
        code: '0110100',
        name: '札幌市中央区',
        prefectureName: '北海道',
      );

      final selectedCity = container
          .read(intensityHistoryControllerProvider)
          .selectedCity;
      expect(selectedCity?.code, '0110100');
      expect(selectedCity?.prefectureName, '北海道');
    });

    test('deselectCity で選択を解除する', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(
        intensityHistoryControllerProvider.notifier,
      );
      notifier.selectCity(
        code: '0410000',
        name: '仙台市',
        prefectureName: '宮城県',
      );
      notifier.deselectCity();

      expect(
        container.read(intensityHistoryControllerProvider).selectedCity,
        isNull,
      );
    });

    test('未選択で deselectCity を呼んでも状態は変わらない', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final before = container.read(intensityHistoryControllerProvider);
      container
          .read(intensityHistoryControllerProvider.notifier)
          .deselectCity();

      expect(container.read(intensityHistoryControllerProvider), before);
    });
  });
}
