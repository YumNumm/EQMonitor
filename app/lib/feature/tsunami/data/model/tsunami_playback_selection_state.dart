import 'package:freezed_annotation/freezed_annotation.dart';

part 'tsunami_playback_selection_state.freezed.dart';

@freezed
abstract class TsunamiPlaybackSelectionState
    with _$TsunamiPlaybackSelectionState {
  const factory({
    @Default(null) int? selectedIndex,
    @Default(true) bool isExpanded,
  }) = _TsunamiPlaybackSelectionState;
}
