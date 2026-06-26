import 'package:eqmonitor/feature/tsunami/data/notifier/tsunami_playback_selection_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod/riverpod.dart';

void main() {
  late ProviderContainer container;

  setUp(() {
    container = ProviderContainer();
  });

  tearDown(() {
    container.dispose();
  });

  group('TsunamiPlaybackSelectionNotifier', () {
    test('initial state has null selectedIndex and isExpanded true', () {
      final state = container.read(tsunamiPlaybackSelectionProvider);
      expect(state.selectedIndex, isNull);
      expect(state.isExpanded, isTrue);
    });

    test('selectIndex sets selectedIndex', () {
      final notifier = container.read(
        tsunamiPlaybackSelectionProvider.notifier,
      );
      notifier.selectIndex(3);
      final state = container.read(tsunamiPlaybackSelectionProvider);
      expect(state.selectedIndex, 3);
    });

    test('selectIndex with null resets to latest', () {
      final notifier = container.read(
        tsunamiPlaybackSelectionProvider.notifier,
      );
      notifier.selectIndex(3);
      notifier.selectIndex(null);
      final state = container.read(tsunamiPlaybackSelectionProvider);
      expect(state.selectedIndex, isNull);
    });

    test('stepForward increments index, clamped to maxIndex', () {
      final notifier = container.read(
        tsunamiPlaybackSelectionProvider.notifier,
      );
      // From null (latest = maxIndex), stepForward does nothing
      notifier.stepForward(5);
      expect(
        container.read(tsunamiPlaybackSelectionProvider).selectedIndex,
        isNull,
      );

      // From 2, stepForward goes to 3
      notifier.selectIndex(2);
      notifier.stepForward(5);
      expect(
        container.read(tsunamiPlaybackSelectionProvider).selectedIndex,
        3,
      );

      // At maxIndex, stepForward resets to null (latest)
      notifier.selectIndex(5);
      notifier.stepForward(5);
      expect(
        container.read(tsunamiPlaybackSelectionProvider).selectedIndex,
        isNull,
      );
    });

    test('stepBackward decrements index, stops at 0', () {
      final notifier = container.read(
        tsunamiPlaybackSelectionProvider.notifier,
      );
      // From null (latest), stepBackward goes to maxIndex - 1
      notifier.stepBackward(5);
      expect(
        container.read(tsunamiPlaybackSelectionProvider).selectedIndex,
        4,
      );

      // From 1, stepBackward goes to 0
      notifier.selectIndex(1);
      notifier.stepBackward(5);
      expect(
        container.read(tsunamiPlaybackSelectionProvider).selectedIndex,
        0,
      );

      // At 0, stepBackward stays at 0
      notifier.stepBackward(5);
      expect(
        container.read(tsunamiPlaybackSelectionProvider).selectedIndex,
        0,
      );
    });

    test('resetToLatest sets selectedIndex to null', () {
      final notifier = container.read(
        tsunamiPlaybackSelectionProvider.notifier,
      );
      notifier.selectIndex(3);
      notifier.resetToLatest();
      expect(
        container.read(tsunamiPlaybackSelectionProvider).selectedIndex,
        isNull,
      );
    });

    test('toggleExpanded flips isExpanded', () {
      final notifier = container.read(
        tsunamiPlaybackSelectionProvider.notifier,
      );
      expect(
        container.read(tsunamiPlaybackSelectionProvider).isExpanded,
        isTrue,
      );
      notifier.toggleExpanded();
      expect(
        container.read(tsunamiPlaybackSelectionProvider).isExpanded,
        isFalse,
      );
      notifier.toggleExpanded();
      expect(
        container.read(tsunamiPlaybackSelectionProvider).isExpanded,
        isTrue,
      );
    });
  });
}
