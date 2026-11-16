final class const CorrelationEew({
  required final String eventId,
  required final int serialNo,
  required final DateTime originTime,
  required final DateTime reportTime,
  required final double latitude,
  required final double longitude,
  required final double depth,
  required final double magnitude,
  required final bool isCancel,
});

final class const ShakeObservationPoint({
  required final double latitude,
  required final double longitude,
  required final double? intensity,
  required final double? arv,
});

final class const ShakeObservation({
  required final String eventId,
  required final DateTime createdAt,

  /// 平常値との差で検知したイベント。[createdAt] が揺れ始めより後になるため、
  /// 時間条件の上限を適用しない。
  required final bool isBootstrap,
  required final List<ShakeObservationPoint> points,
});

final class const CorrelationConfig({
  final double intensityTolerance = 1.5,
  final double minMatchRatio = 0.3,
  final Duration sWaveExtra = const Duration(seconds: 30),
});

final class const CorrelationCandidate({
  required final String eewEventId,
  required final int eewSerialNo,
  required final DateTime eewReportTime,
  required final String shakeEventId,
  required final bool isCorrelated,
  required final double score,
  required final int matchedPointCount,
  required final int eligiblePointCount,
  required final int totalPointCount,

  /// S 波到達時刻から検知時刻までの秒数の平均。観測点が無い場合は `null`。
  required final double? averageTimeDiff,
  required final double averageIntensityDiff,
});
