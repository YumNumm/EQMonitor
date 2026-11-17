import 'package:shake_eew_correlator/src/correlation_models.dart';
import 'package:shake_eew_correlator/src/geo_distance.dart';
import 'package:shake_eew_correlator/src/intensity_estimator.dart';
import 'package:shake_eew_correlator/src/travel_time_table.dart';

final class const ShakeEewCorrelator({
  required final TravelTimeTable travelTimeTable,
  final CorrelationConfig config = const CorrelationConfig(),
  final GeoDistanceCalculator distance = const GeoDistanceCalculator(),
  final SiMidorikawaIntensityEstimator estimator =
      const SiMidorikawaIntensityEstimator(),
}) {
  /// 取消されていない EEW のうち、揺れ検知イベントと最もよく一致する 1 件を返す。
  ///
  /// どの EEW を対象にするか（発表からの経過時間や最終報の扱い）は
  /// 呼び出し側が [eews] を選別して決める。
  CorrelationCandidate? correlate({
    required Iterable<CorrelationEew> eews,
    required ShakeObservation shake,
  }) => selectBest([
    for (final eew in eews)
      if (!eew.isCancel) check(eew: eew, shake: shake),
  ]);

  /// 観測点ごとに、検知時刻が P 波到達から S 波到達後の猶予までに収まり、
  /// 観測震度が予測震度を許容差を超えて上回らないことを確かめる。
  /// 震度を観測できた観測点のうち、両方を満たす割合が基準以上であれば成立とする。
  ///
  /// 観測点はイベントの終了まで増え続けるため、時間条件はイベントの発生時刻
  /// ではなく観測点ごとの検知時刻で判定する。検知するのは初期微動であることが
  /// 多く、主要動の予測震度を大きく下回るため、下回る側は制限しない。
  CorrelationCandidate check({
    required CorrelationEew eew,
    required ShakeObservation shake,
  }) {
    final originMs = eew.originTime.millisecondsSinceEpoch;
    final marginMs = config.pWaveMargin.inMilliseconds;
    final extraMs = config.sWaveExtra.inMilliseconds;

    var timeDiffTotal = 0.0;
    var observedCount = 0;
    var eligibleCount = 0;
    var matchedCount = 0;
    var intensityDiffTotal = 0.0;
    for (final point in shake.points) {
      final travelTime = travelTimeTable.lookup(
        depth: eew.depth,
        distance: distance.epicentral(
          latitude1: eew.latitude,
          longitude1: eew.longitude,
          latitude2: point.latitude,
          longitude2: point.longitude,
        ),
      );
      final pArrivalMs = originMs + (travelTime.pSeconds * 1000).truncate();
      final sArrivalMs = originMs + (travelTime.sSeconds * 1000).truncate();
      final detectedMs = point.detectedAt.millisecondsSinceEpoch;
      timeDiffTotal += (detectedMs - sArrivalMs) / 1000;

      final isWithinTimeWindow =
          detectedMs >= pArrivalMs - marginMs &&
          (shake.isBootstrap || detectedMs <= sArrivalMs + extraMs);
      final observed = point.intensity;
      if (observed == null) {
        continue;
      }
      observedCount += 1;
      if (!isWithinTimeWindow) {
        continue;
      }
      eligibleCount += 1;
      final predicted = estimator.estimate(
        hypocenterLatitude: eew.latitude,
        hypocenterLongitude: eew.longitude,
        depth: eew.depth,
        magnitude: eew.magnitude,
        latitude: point.latitude,
        longitude: point.longitude,
        arv: point.arv,
      );
      final excess = observed - predicted;
      intensityDiffTotal += excess.abs();
      if (excess <= config.intensityTolerance) {
        matchedCount += 1;
      }
    }

    // 時間条件を満たす観測点だけを分母にすると、波面がイベントの一部に重なった
    // だけの別の EEW も成立してしまう。
    final score = observedCount == 0 ? 0.0 : matchedCount / observedCount;
    return CorrelationCandidate(
      eewEventId: eew.eventId,
      eewSerialNo: eew.serialNo,
      eewReportTime: eew.reportTime,
      shakeEventId: shake.eventId,
      isCorrelated: eligibleCount > 0 && score >= config.minMatchRatio,
      score: score,
      matchedPointCount: matchedCount,
      eligiblePointCount: eligibleCount,
      totalPointCount: shake.points.length,
      averageTimeDiff: shake.points.isEmpty
          ? null
          : timeDiffTotal / shake.points.length,
      averageIntensityDiff: eligibleCount == 0
          ? 0
          : intensityDiffTotal / eligibleCount,
    );
  }

  /// 成立した候補から入力順に依存せず最良の 1 件を選ぶ。
  CorrelationCandidate? selectBest(Iterable<CorrelationCandidate> candidates) {
    final correlated = candidates.where((e) => e.isCorrelated).toList()
      ..sort((a, b) {
        final byScore = b.score.compareTo(a.score);
        if (byScore != 0) {
          return byScore;
        }
        final byMatched = b.matchedPointCount.compareTo(a.matchedPointCount);
        if (byMatched != 0) {
          return byMatched;
        }
        final byTimeDiff = (a.averageTimeDiff ?? double.infinity)
            .abs()
            .compareTo((b.averageTimeDiff ?? double.infinity).abs());
        if (byTimeDiff != 0) {
          return byTimeDiff;
        }
        final byReportTime = b.eewReportTime.compareTo(a.eewReportTime);
        if (byReportTime != 0) {
          return byReportTime;
        }
        return a.eewEventId.compareTo(b.eewEventId);
      });
    return correlated.firstOrNull;
  }
}
