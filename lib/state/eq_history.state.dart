import 'package:eqmonitor/model/eq_history_content.model.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'eq_history.state.freezed.dart';

@freezed
class EQHistoryState with _$EQHistoryState {
  const factory EQHistoryState({
    @Default(<EQHistoryContent>[]) List<EQHistoryContent> content,
    @Default(true) bool hasNext,
  }) = _EQHistoryState;
}
