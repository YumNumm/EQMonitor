import 'package:eqmonitor/feature/intensity_history/data/model/intensity_history_state.dart';
import 'package:eqmonitor/feature/intensity_history/data/notifier/intensity_history_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

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
  });
}
