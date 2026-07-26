import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_warning_overlay_candidate.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'eew_warning_candidate_selector.g.dart';

@riverpod
EewWarningCandidateSelector eewWarningCandidateSelector(Ref ref) =>
    EewWarningCandidateSelector();

class EewWarningCandidateSelector {
  List<EewWarningOverlayCandidate> select({
    required List<EewTelegramItem> aliveEews,
    required String warningAreaCode,
    required String warningAreaName,
    required String? forecastAreaCode,
    required String? forecastAreaName,
  }) {
    final candidates = <EewWarningOverlayCandidate>[];
    for (final event in aliveEews) {
      final hasCurrentWarning = event.warning?.regions.any(
        (region) => region.code == warningAreaCode && region.hadWarning,
      );
      if (event.isWarning != true ||
          event.isCanceled ||
          hasCurrentWarning != true) {
        continue;
      }

      EewForecastRegionInfo? localForecastRegion;
      if (forecastAreaCode != null) {
        for (final region in event.forecastIntensity?.regions ?? const []) {
          if (region.code == forecastAreaCode) {
            localForecastRegion = region;
            break;
          }
        }
      }

      candidates.add(
        EewWarningOverlayCandidate(
          event: event,
          warningAreaCode: warningAreaCode,
          warningAreaName: warningAreaName,
          forecastAreaName: forecastAreaName,
          localForecastRegion: localForecastRegion,
        ),
      );
    }
    return candidates;
  }
}
