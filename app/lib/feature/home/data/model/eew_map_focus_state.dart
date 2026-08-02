import 'package:eqmonitor/feature/home/data/model/eew_map_focus_grid_rect.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'eew_map_focus_state.freezed.dart';

@freezed
abstract class EewMapFocusState with _$EewMapFocusState {
  const factory EewMapFocusState({
    String? focusedEventId,
    @Default(false) bool isFocused,
    ({double latitude, double longitude})? focusedHypocenter,
    @Default({}) Map<String, EewMapFocusGridRect> shakeBoundsByEventId,
  }) = _EewMapFocusState;
}

@freezed
abstract class EewMapFocusDecision with _$EewMapFocusDecision {
  const factory EewMapFocusDecision({
    required EewMapFocusState state,
    required bool shouldFit,
  }) = _EewMapFocusDecision;
}
