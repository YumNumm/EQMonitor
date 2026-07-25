import 'package:eqmonitor/feature/eew/data/model/eew_warning_overlay_candidate.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_warning_overlay_display_model.dart';

class EewWarningArrivalClassifier {
  EewWarningArrivalState classify({
    required EewWarningOverlayCandidate candidate,
    required DateTime now,
  }) {
    final localForecast = candidate.localForecastRegion;
    if (localForecast?.isArrived == true) {
      return EewWarningArrivalState.arrived;
    }
    final arrivalTime = localForecast?.arrivalTime;
    if (arrivalTime == null) {
      return EewWarningArrivalState.unknown;
    }
    return arrivalTime.isAfter(now)
        ? EewWarningArrivalState.unarrived
        : EewWarningArrivalState.arrived;
  }
}
