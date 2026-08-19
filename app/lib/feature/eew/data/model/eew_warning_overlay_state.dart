import 'package:eqmonitor/feature/eew/data/model/eew_warning_overlay_display_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'eew_warning_overlay_state.freezed.dart';

enum EewWarningOverlayMode { hidden, fullscreen, minimized }

@Freezed(toJson: false)
abstract class EewWarningOverlayState with _$EewWarningOverlayState {
  const factory({
    @Default(EewWarningOverlayMode.hidden) EewWarningOverlayMode mode,
    EewWarningOverlayDisplayModel? displayModel,
    @Default(<String>{}) Set<String> seenEventIds,
    @Default(<String>{}) Set<String> dismissedEventIds,
    @Default(false) bool simulationSessionActive,
  }) = _EewWarningOverlayState;
}
