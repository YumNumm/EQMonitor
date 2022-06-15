import 'package:eqmonitor/model/eq_history_content.model.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'line_notify.state.freezed.dart';

@freezed
class LineNotifyState with _$LineNotifyState {
  const factory LineNotifyState({
    @Default(null) String? token,
    @Default(false) bool hasToken,
  }) = _LineNotifyState;
}
