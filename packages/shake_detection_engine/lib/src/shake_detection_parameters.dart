import 'package:shake_detection_engine/src/shake_event_level.dart';

final class const ShakeDetectionParameters({
  final double maxSearchDistance = 60,
  final double peakWeightDistance = 14,
  final double isolatedThreshold = 1,
  final double isolatedDetectionDiff = 1.4,
  final double scoreThresholdRatio = 0.333333,
  final double scoreIntensityOffset = -0.8,
  final double minDetectionDiff = 0.2,
  final double noChangePenaltyFactor = 0.25,
  final int maxNearPoints = 50,
  final double strongerMergeDistance = 250,
  final double strongMergeDistance = 250,
  final double mediumMergeDistance = 180,
  final double weakMergeDistance = 130,
  final double weakerMergeDistance = 90,
  final int strongerSeconds = 80,
  final int strongSeconds = 70,
  final int mediumSeconds = 40,
  final int weakSeconds = 30,
  final int weakerSeconds = 20,
  final int weakerConfirmPointCount = 4,
  final int weakConfirmPointCount = 3,
}) {
  Duration lifetime(ShakeEventLevel level) => Duration(
    seconds: switch (level) {
      .stronger => strongerSeconds,
      .strong => strongSeconds,
      .medium => mediumSeconds,
      .weak => weakSeconds,
      .weaker => weakerSeconds,
    },
  );

  double mergeDistance(ShakeEventLevel level) => switch (level) {
    .stronger => strongerMergeDistance,
    .strong => strongMergeDistance,
    .medium => mediumMergeDistance,
    .weak => weakMergeDistance,
    .weaker => weakerMergeDistance,
  };

  /// 近すぎる観測点（生活振動の影響）と遠すぎる観測点（相関低下）の重みを下げる。
  double distanceWeight(double distance) {
    if (distance <= peakWeightDistance) {
      return distance / peakWeightDistance;
    }
    return (maxSearchDistance - distance) /
        (maxSearchDistance - peakWeightDistance);
  }
}
