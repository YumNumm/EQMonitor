import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/feature/eew/data/logic/eew_warning_arrival_classifier.dart';
import 'package:eqmonitor/feature/eew/data/logic/eew_warning_representative_selector.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_warning_overlay_candidate.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_warning_overlay_display_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'eew_warning_display_model_builder.g.dart';

@riverpod
EewWarningDisplayModelBuilder eewWarningDisplayModelBuilder(Ref ref) =>
    EewWarningDisplayModelBuilder(
      arrivalClassifier: ref.watch(eewWarningArrivalClassifierProvider),
      representativeSelector: ref.watch(
        eewWarningRepresentativeSelectorProvider,
      ),
    );

class EewWarningDisplayModelBuilder {
  new({
    EewWarningArrivalClassifier? arrivalClassifier,
    EewWarningRepresentativeSelector? representativeSelector,
  }) : _arrivalClassifier = arrivalClassifier ?? EewWarningArrivalClassifier(),
       _representativeSelector =
           representativeSelector ?? EewWarningRepresentativeSelector();

  final EewWarningArrivalClassifier _arrivalClassifier;
  final EewWarningRepresentativeSelector _representativeSelector;

  EewWarningOverlayDisplayModel? build({
    required List<EewWarningOverlayCandidate> candidates,
    required DateTime now,
  }) {
    final representative = _representativeSelector.select(
      candidates: candidates,
      now: now,
    );
    if (representative == null) {
      return null;
    }

    final sortedCandidates = [...candidates]
      ..sort(
        (left, right) =>
            _representativeSelector.compare(left: left, right: right, now: now),
      );

    final zoneNamesByCode = <String, String>{};
    for (final candidate in sortedCandidates) {
      for (final zone
          in candidate.event.warning?.zones ?? const <EewWarningZoneInfo>[]) {
        zoneNamesByCode.putIfAbsent(zone.code, () => zone.name);
      }
    }
    final zoneCodes = zoneNamesByCode.keys.toList()..sort();
    final combinedZoneNames = zoneCodes
        .map((code) => zoneNamesByCode[code])
        .whereType<String>()
        .join(' ');

    final event = representative.event;
    final hypocenter = event.hypocenter;
    final isLevelMethod =
        event.accuracy?.epicenter == 1 && event.originTime == null;
    final preferredHypocenterName =
        hypocenter?.detailedName ?? hypocenter?.name;
    final visibleHypocenterName =
        event.isPlum ||
            isLevelMethod ||
            preferredHypocenterName == null ||
            preferredHypocenterName.isEmpty
        ? null
        : preferredHypocenterName;
    final arrivalState = _arrivalClassifier.classify(
      candidate: representative,
      now: now,
    );
    final localForecast = representative.localForecastRegion;

    return EewWarningOverlayDisplayModel(
      source: EewWarningOverlaySource.real,
      eventIds: sortedCandidates
          .map((candidate) => candidate.event.eventId)
          .toList(),
      representativeEventId: event.eventId,
      serialNo: event.serialNo,
      alertCount: candidates.length,
      reportLabel: '緊急地震速報（警報） 第${event.serialNo}報',
      hypocenterHeadline: visibleHypocenterName == null
          ? null
          : '$visibleHypocenterNameで地震',
      strongMotionHeadline: combinedZoneNames.isEmpty
          ? '強い揺れに警戒'
          : '$combinedZoneNamesで強い揺れ',
      currentRegionName:
          representative.forecastAreaName ?? representative.warningAreaName,
      localIntensity: localForecast?.intensity ?? JmaIntensity.unknown,
      localIntensityIsOver: localForecast?.intensityIsOver ?? false,
      arrivalState: arrivalState,
      secondsUntilArrival: arrivalState == EewWarningArrivalState.unarrived
          ? localForecast?.arrivalTime?.difference(now).inSeconds
          : null,
      hypocenterName: hypocenter?.name,
      magnitude: hypocenter?.magnitude,
      depth: hypocenter?.depth,
    );
  }
}
