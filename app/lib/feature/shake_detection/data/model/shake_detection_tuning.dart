import 'package:shake_detection_engine/shake_detection_engine.dart';
import 'package:shake_eew_correlator/shake_eew_correlator.dart';

/// 変更可能な揺れ検知のパラメータ
enum ShakeDetectionTunable(final String label, {final bool isInteger = false}) {
  maxSearchDistance('近傍として扱う最大距離 (km)'),
  peakWeightDistance('重みが最大になる距離 (km)'),
  maxNearPoints('近傍観測点の最大数', isInteger: true),
  isolatedThreshold('離島とみなす近傍の重み合計'),
  isolatedDetectionDiff('離島の単独検知に必要な上昇量'),
  minDetectionDiff('反応とみなす最小の上昇量'),
  scoreThresholdRatio('検知スコアの閾値係数'),
  scoreIntensityOffset('スコア計算の上昇量オフセット'),
  noChangePenaltyFactor('無反応の近傍によるペナルティ係数'),
  weakerConfirmPointCount('Weaker の確定に必要な観測点数（超過）', isInteger: true),
  weakConfirmPointCount('Weak の確定に必要な観測点数（超過）', isInteger: true),
  weakerMergeDistance('統合距離 Weaker (km)'),
  weakMergeDistance('統合距離 Weak (km)'),
  mediumMergeDistance('統合距離 Medium (km)'),
  strongMergeDistance('統合距離 Strong (km)'),
  strongerMergeDistance('統合距離 Stronger (km)'),
  weakerSeconds('有効時間 Weaker (秒)', isInteger: true),
  weakSeconds('有効時間 Weak (秒)', isInteger: true),
  mediumSeconds('有効時間 Medium (秒)', isInteger: true),
  strongSeconds('有効時間 Strong (秒)', isInteger: true),
  strongerSeconds('有効時間 Stronger (秒)', isInteger: true),
  fallbackBaseline('過去フレームが無い場合の平常値'),
  backfillSeconds('履歴の作り直しに使う直近の秒数', isInteger: true),
  correlationIntensityTolerance('EEW 結合: 予測震度を上回ってよい幅'),
  correlationMinMatchRatio('EEW 結合: 一致とみなす観測点の割合'),
  correlationPWaveMarginSeconds('EEW 結合: P 波到達前の猶予 (秒)', isInteger: true),
  correlationSWaveExtraSeconds('EEW 結合: S 波到達後の猶予 (秒)', isInteger: true);

  String format(double value) =>
      isInteger ? value.round().toString() : value.toString();
}

/// 設定から解決した揺れ検知のパラメータ一式
final class const ShakeDetectionTuning({
  required final ShakeDetectionParameters parameters,
  required final double fallbackBaseline,
  required final int backfillSeconds,
  required final CorrelationConfig correlation,
});

/// エンジン・結合判定の外にある、検知の進め方の初期値
final class const ShakeDetectionDefaults({
  final double fallbackBaseline = 1,
  final int backfillSeconds = 10,
});
