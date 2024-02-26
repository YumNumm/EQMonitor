import 'package:eqmonitor/feature/home/features/kmoni_observation_points/model/kmoni_observation_point.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'kmoni_view_model_state.freezed.dart';

@freezed
class KmoniViewModelState with _$KmoniViewModelState {
  const factory KmoniViewModelState({
    /// 初期化済みかどうか
    required bool isInitialized,
    required DateTime? lastUpdatedAt,

    /// 現在時刻からの遅延
    required Duration? delay,
    required KmoniStatus status,
    required List<AnalyzedKmoniObservationPoint>? analyzedPoints,

    /// 遅延調整中かどうか
    required bool isDelayAdjusting,
  }) = _KmoniViewModelState;
}

enum KmoniStatus {
  /// リアルタイム
  realtime,

  /// 遅延
  delay,

  /// プレイバック
  playback,

  /// 未取得
  none,

  /// 停止中
  stopped,
}
