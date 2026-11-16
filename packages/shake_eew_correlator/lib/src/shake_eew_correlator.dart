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

  CorrelationCandidate check({
    required CorrelationEew eew,
    required ShakeObservation shake,
  }) {
    final shakeMs = shake.createdAt.millisecondsSinceEpoch;
    final originMs = eew.originTime.millisecondsSinceEpoch;
    final extraMs = config.sWaveExtra.inMilliseconds;

    var timeDiffTotal = 0.0;
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
      timeDiffTotal += (shakeMs - sArrivalMs) / 1000;

      final isWithinTimeWindow =
          shakeMs >= pArrivalMs &&
          (shake.isBootstrap || shakeMs <= sArrivalMs + extraMs);
      final observed = point.intensity;
      if (!isWithinTimeWindow || observed == null) {
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
      final intensityDiff = (observed - predicted).abs();
      intensityDiffTotal += intensityDiff;
      if (intensityDiff <= config.intensityTolerance) {
        matchedCount += 1;
      }
    }

    final score = eligibleCount == 0 ? 0.0 : matchedCount / eligibleCount;
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
