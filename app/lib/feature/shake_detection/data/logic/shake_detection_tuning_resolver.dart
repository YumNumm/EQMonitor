import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_tuning.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shake_detection_engine/shake_detection_engine.dart';
import 'package:shake_eew_correlator/shake_eew_correlator.dart';

part 'shake_detection_tuning_resolver.g.dart';

@riverpod
ShakeDetectionTuningResolver shakeDetectionTuningResolver(Ref ref) =>
    const ShakeDetectionTuningResolver();

class const ShakeDetectionTuningResolver() {
  static const _parameters = ShakeDetectionParameters();
  static const _correlation = CorrelationConfig();
  static const _request = ShakeDetectionDefaults();

  double defaultValue(ShakeDetectionTunable tunable) => switch (tunable) {
    .maxSearchDistance => _parameters.maxSearchDistance,
    .peakWeightDistance => _parameters.peakWeightDistance,
    .maxNearPoints => _parameters.maxNearPoints.toDouble(),
    .isolatedThreshold => _parameters.isolatedThreshold,
    .isolatedDetectionDiff => _parameters.isolatedDetectionDiff,
    .minDetectionDiff => _parameters.minDetectionDiff,
    .scoreThresholdRatio => _parameters.scoreThresholdRatio,
    .scoreIntensityOffset => _parameters.scoreIntensityOffset,
    .noChangePenaltyFactor => _parameters.noChangePenaltyFactor,
    .weakerConfirmPointCount => _parameters.weakerConfirmPointCount.toDouble(),
    .weakConfirmPointCount => _parameters.weakConfirmPointCount.toDouble(),
    .weakerMergeDistance => _parameters.weakerMergeDistance,
    .weakMergeDistance => _parameters.weakMergeDistance,
    .mediumMergeDistance => _parameters.mediumMergeDistance,
    .strongMergeDistance => _parameters.strongMergeDistance,
    .strongerMergeDistance => _parameters.strongerMergeDistance,
    .weakerSeconds => _parameters.weakerSeconds.toDouble(),
    .weakSeconds => _parameters.weakSeconds.toDouble(),
    .mediumSeconds => _parameters.mediumSeconds.toDouble(),
    .strongSeconds => _parameters.strongSeconds.toDouble(),
    .strongerSeconds => _parameters.strongerSeconds.toDouble(),
    .fallbackBaseline => _request.fallbackBaseline,
    .backfillSeconds => _request.backfillSeconds.toDouble(),
    .correlationIntensityTolerance => _correlation.intensityTolerance,
    .correlationMinMatchRatio => _correlation.minMatchRatio,
    .correlationPWaveMarginSeconds =>
      _correlation.pWaveMargin.inSeconds.toDouble(),
    .correlationSWaveExtraSeconds =>
      _correlation.sWaveExtra.inSeconds.toDouble(),
  };

  double value(ShakeDetectionTunable tunable, Map<String, double> overrides) =>
      overrides[tunable.name] ?? defaultValue(tunable);

  ShakeDetectionTuning resolve(Map<String, double> overrides) {
    double read(ShakeDetectionTunable tunable) => value(tunable, overrides);
    int readInt(ShakeDetectionTunable tunable) => read(tunable).round();

    return ShakeDetectionTuning(
      parameters: ShakeDetectionParameters(
        maxSearchDistance: read(.maxSearchDistance),
        peakWeightDistance: read(.peakWeightDistance),
        maxNearPoints: readInt(.maxNearPoints),
        isolatedThreshold: read(.isolatedThreshold),
        isolatedDetectionDiff: read(.isolatedDetectionDiff),
        minDetectionDiff: read(.minDetectionDiff),
        scoreThresholdRatio: read(.scoreThresholdRatio),
        scoreIntensityOffset: read(.scoreIntensityOffset),
        noChangePenaltyFactor: read(.noChangePenaltyFactor),
        weakerConfirmPointCount: readInt(.weakerConfirmPointCount),
        weakConfirmPointCount: readInt(.weakConfirmPointCount),
        weakerMergeDistance: read(.weakerMergeDistance),
        weakMergeDistance: read(.weakMergeDistance),
        mediumMergeDistance: read(.mediumMergeDistance),
        strongMergeDistance: read(.strongMergeDistance),
        strongerMergeDistance: read(.strongerMergeDistance),
        weakerSeconds: readInt(.weakerSeconds),
        weakSeconds: readInt(.weakSeconds),
        mediumSeconds: readInt(.mediumSeconds),
        strongSeconds: readInt(.strongSeconds),
        strongerSeconds: readInt(.strongerSeconds),
      ),
      fallbackBaseline: read(.fallbackBaseline),
      backfillSeconds: readInt(.backfillSeconds),
      correlation: CorrelationConfig(
        intensityTolerance: read(.correlationIntensityTolerance),
        minMatchRatio: read(.correlationMinMatchRatio),
        pWaveMargin: Duration(seconds: readInt(.correlationPWaveMarginSeconds)),
        sWaveExtra: Duration(seconds: readInt(.correlationSWaveExtraSeconds)),
      ),
    );
  }
}
