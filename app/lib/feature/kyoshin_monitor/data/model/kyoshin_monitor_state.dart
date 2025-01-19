import 'package:freezed_annotation/freezed_annotation.dart';

part 'kyoshin_monitor_state.freezed.dart';
part 'kyoshin_monitor_state.g.dart';

@freezed
class KyoshinMonitorState with _$KyoshinMonitorState {
  const factory KyoshinMonitorState({
    // 必要フィールドを定義
    required String title,
  }) = _KyoshinMonitorState;

  factory KyoshinMonitorState.fromJson(Map<String, dynamic> json) =>
    _$KyoshinMonitorStateFromJson(json);
}
