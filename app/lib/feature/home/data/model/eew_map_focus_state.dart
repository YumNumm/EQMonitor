import 'package:eqmonitor/feature/home/data/model/eew_map_focus_grid_rect.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'eew_map_focus_state.freezed.dart';

/// EEW地図フォーカスの状態。
///
/// `applied*` はカメラ fit が **実際に完了した** 時点の対象を表す。
/// 変化検知のベースラインであり、fit が実行されなかった場合は進めない
/// （進めてしまうと、次回以降に変化なしと判定され再試行が失われる）。
@freezed
abstract class EewMapFocusState with _$EewMapFocusState {
  const factory EewMapFocusState({
    String? focusedEventId,
    @Default(false) bool isFocused,
    String? appliedEventId,
    ({double latitude, double longitude})? appliedHypocenter,
    EewMapFocusGridRect? appliedShakeRect,
    @Default({}) Map<String, EewMapFocusGridRect> shakeBoundsByEventId,
  }) = _EewMapFocusState;

  const EewMapFocusState._();

  /// 現在のフォーカス対象に対してカメラ fit が適用済みかどうか。
  bool get hasAppliedFocus =>
      focusedEventId != null && appliedEventId == focusedEventId;
}

@freezed
abstract class EewMapFocusDecision with _$EewMapFocusDecision {
  const factory EewMapFocusDecision({
    required EewMapFocusState state,
    required bool shouldFit,
    ({double latitude, double longitude})? targetHypocenter,
    EewMapFocusGridRect? targetShakeRect,
  }) = _EewMapFocusDecision;
}
