import 'package:shake_detection_engine/shake_detection_engine.dart';
import 'package:shake_eew_correlator/shake_eew_correlator.dart';

/// デバッグ表示用の、端末内の揺れ検知の現在の状態。
final class const ShakeDetectionDebugReport({
  required final bool isEnabled,

  /// 最新フレームの観測時刻。検知していない場合は `null`。
  required final DateTime? observedAt,
  required final DateTime? coldStartAt,

  /// 平常値の算出に使えた過去フレームの数。0 の場合は固定値で代用している。
  required final int? baselineFrameCount,
  required final bool isHistoryRebuilt,

  /// 走時表を読み込み、EEW との結合を判定できる状態かどうか。
  required final bool isCorrelatorReady,

  /// 結合判定の対象にした EEW の数。
  required final int eewCount,
  required final List<ShakeDetectionDebugEvent> events,
});

final class const ShakeDetectionDebugEvent({
  required final ShakeEventSnapshot snapshot,

  /// 対象の EEW ごとの結合判定の結果。
  required final List<CorrelationCandidate> candidates,

  /// 結合した EEW のイベント ID。結合していない場合は `null`。
  required final String? correlatedEewEventId,
});
