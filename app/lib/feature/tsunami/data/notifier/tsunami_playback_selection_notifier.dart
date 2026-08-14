import 'package:eqmonitor/feature/tsunami/data/model/tsunami_playback_selection_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'tsunami_playback_selection_notifier.g.dart';

@riverpod
class TsunamiPlaybackSelection extends _$TsunamiPlaybackSelection {
  @override
  TsunamiPlaybackSelectionState build() =>
      const TsunamiPlaybackSelectionState();

  void selectIndex(int? index) {
    state = state.copyWith(selectedIndex: index);
  }

  void stepForward(int maxIndex) {
    final current = state.selectedIndex;
    if (current == null) {
      return;
    }
    if (current >= maxIndex) {
      state = state.copyWith(selectedIndex: null);
      return;
    }
    state = state.copyWith(selectedIndex: current + 1);
  }

  void stepBackward(int maxIndex) {
    final current = state.selectedIndex;
    if (current == null) {
      state = state.copyWith(selectedIndex: maxIndex - 1);
      return;
    }
    if (current <= 0) {
      return;
    }
    state = state.copyWith(selectedIndex: current - 1);
  }

  void resetToLatest() {
    state = state.copyWith(selectedIndex: null);
  }

  void toggleExpanded() {
    state = state.copyWith(isExpanded: !state.isExpanded);
  }
}
