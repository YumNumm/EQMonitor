import 'package:freezed_annotation/freezed_annotation.dart';

part 'kmoni_view_model_state.freezed.dart';

@freezed
class KmoniViewModelState with _$KmoniViewModelState {
  const factory KmoniViewModelState({
    /// 初期化済みかどうか
    required bool isInitialized,
    required DateTime? lastUpdatedAt,

    /// 現在時刻からの遅れ
    required Duration? delay,
  }) = _KmoniViewModelState;
}
