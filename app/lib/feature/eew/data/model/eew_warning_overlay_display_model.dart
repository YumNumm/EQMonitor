import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'eew_warning_overlay_display_model.freezed.dart';

enum EewWarningOverlaySource { real, simulation }

enum EewWarningArrivalState { unarrived, unknown, arrived }

@Freezed(toJson: false)
abstract class EewWarningOverlayDisplayModel
    with _$EewWarningOverlayDisplayModel {
  const factory EewWarningOverlayDisplayModel({
    required EewWarningOverlaySource source,
    required List<String> eventIds,
    required String representativeEventId,
    required int serialNo,
    required int alertCount,
    required String reportLabel,
    required String? hypocenterHeadline,
    required String strongMotionHeadline,
    required String currentRegionName,
    required JmaIntensity localIntensity,
    required bool localIntensityIsOver,
    required EewWarningArrivalState arrivalState,
    required int? secondsUntilArrival,
    required String? hypocenterName,
    required double? magnitude,
    required int? depth,
  }) = _EewWarningOverlayDisplayModel;
}
