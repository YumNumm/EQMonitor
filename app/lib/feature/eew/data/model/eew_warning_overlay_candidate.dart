import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'eew_warning_overlay_candidate.freezed.dart';

@Freezed(toJson: false)
abstract class EewWarningOverlayCandidate with _$EewWarningOverlayCandidate {
  const factory({
    required EewTelegramItem event,
    required String warningAreaCode,
    required String warningAreaName,
    required String? forecastAreaName,
    required EewForecastRegionInfo? localForecastRegion,
  }) = _EewWarningOverlayCandidate;
}
