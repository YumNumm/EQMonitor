import 'package:eqmonitor/feature/eew/data/model/eew_warning_overlay_display_model.dart';

class EewWarningOverlayArrivalFormatter {
  const EewWarningOverlayArrivalFormatter();

  String? format({
    required EewWarningArrivalState state,
    required int? secondsUntilArrival,
  }) => switch ((state, secondsUntilArrival)) {
    (EewWarningArrivalState.unarrived, final int seconds) => 'あと約${seconds}秒',
    (EewWarningArrivalState.arrived, _) => '到達と推定',
    _ => null,
  };
}
