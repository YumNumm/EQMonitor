import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/feature/eew/data/logic/eew_warning_arrival_classifier.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_warning_overlay_candidate.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'eew_warning_representative_selector.g.dart';

@riverpod
EewWarningRepresentativeSelector eewWarningRepresentativeSelector(Ref ref) =>
    EewWarningRepresentativeSelector(
      arrivalClassifier: ref.watch(eewWarningArrivalClassifierProvider),
    );

class EewWarningRepresentativeSelector {
  new({
    EewWarningArrivalClassifier? arrivalClassifier,
  }) : _arrivalClassifier = arrivalClassifier ?? EewWarningArrivalClassifier();

  final EewWarningArrivalClassifier _arrivalClassifier;

  EewWarningOverlayCandidate? select({
    required List<EewWarningOverlayCandidate> candidates,
    required DateTime now,
  }) {
    if (candidates.isEmpty) {
      return null;
    }
    final sorted = [...candidates]
      ..sort((left, right) => compare(left: left, right: right, now: now));
    return sorted.first;
  }

  int compare({
    required EewWarningOverlayCandidate left,
    required EewWarningOverlayCandidate right,
    required DateTime now,
  }) {
    final arrivalComparison = _arrivalClassifier
        .classify(candidate: left, now: now)
        .index
        .compareTo(
          _arrivalClassifier.classify(candidate: right, now: now).index,
        );
    if (arrivalComparison != 0) {
      return arrivalComparison;
    }
    final intensityComparison =
        (right.localForecastRegion?.intensity ?? JmaIntensity.unknown)
            .orderIndex
            .compareTo(
              (left.localForecastRegion?.intensity ?? JmaIntensity.unknown)
                  .orderIndex,
            );
    if (intensityComparison != 0) {
      return intensityComparison;
    }
    final reportTimeComparison = right.event.reportTime.compareTo(
      left.event.reportTime,
    );
    if (reportTimeComparison != 0) {
      return reportTimeComparison;
    }
    return left.event.eventId.compareTo(right.event.eventId);
  }
}
