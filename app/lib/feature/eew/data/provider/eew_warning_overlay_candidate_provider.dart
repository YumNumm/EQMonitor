import 'package:eqmonitor/core/provider/clock/app_clock.dart';
import 'package:eqmonitor/feature/eew/data/eew_alive_telegram.dart';
import 'package:eqmonitor/feature/eew/data/logic/eew_warning_candidate_selector.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_warning_overlay_candidate.dart';
import 'package:eqmonitor/feature/eew/data/notifier/eew_warning_overlay_enabled_notifier.dart';
import 'package:eqmonitor/feature/location/data/location.dart';
import 'package:eqmonitor/feature/location/data/nearest_jma_feature.dart';
import 'package:lat_lng/lat_lng.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'eew_warning_overlay_candidate_provider.g.dart';

@riverpod
List<EewWarningOverlayCandidate> eewWarningOverlayCandidates(Ref ref) {
  if (!ref.watch(isRealtimeModeProvider)) {
    return const [];
  }
  final enabled = ref.watch(eewWarningOverlayEnabledProvider);
  final isEnabled = switch (enabled) {
    AsyncData(value: true) when !enabled.isLoading && !enabled.hasError => true,
    _ => false,
  };
  if (!isEnabled) {
    return const [];
  }
  final aliveEews = ref.watch(eewAliveTelegramProvider);
  if (aliveEews == null) {
    return const [];
  }
  final positionState = ref.watch(locationStreamProvider);
  final position = switch (positionState) {
    AsyncData(:final value)
        when !positionState.isLoading && !positionState.hasError =>
      value,
    _ => null,
  };
  if (position == null) {
    return const [];
  }

  final latLng = LatLng(position.latitude, position.longitude);
  final warningAreaState = ref.watch(
    jmaMapAreaForecastLocalEewInsideProvider(latLng),
  );
  final warningArea = switch (warningAreaState) {
    AsyncData(:final value)
        when !warningAreaState.isLoading && !warningAreaState.hasError =>
      value,
    _ => null,
  };
  final warningAreaProperty = warningArea?.property;
  if (warningAreaProperty == null) {
    return const [];
  }

  final forecastAreaState = ref.watch(
    jmaMapAreaForecastLocalEInsideProvider(latLng),
  );
  final forecastArea = switch (forecastAreaState) {
    AsyncData(:final value)
        when !forecastAreaState.isLoading && !forecastAreaState.hasError =>
      value,
    _ => null,
  };
  final forecastAreaProperty = forecastArea?.property;

  return ref
      .watch(eewWarningCandidateSelectorProvider)
      .select(
        aliveEews: aliveEews,
        warningAreaCode: warningAreaProperty.code,
        warningAreaName: warningAreaProperty.name,
        forecastAreaCode: forecastAreaProperty?.code,
        forecastAreaName: forecastAreaProperty?.name,
      );
}
