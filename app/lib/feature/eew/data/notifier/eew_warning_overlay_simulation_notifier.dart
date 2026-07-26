import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_warning_overlay_display_model.dart';
import 'package:eqmonitor/feature/eew/data/provider/eew_warning_overlay_display_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'eew_warning_overlay_simulation_notifier.g.dart';

@riverpod
class EewWarningOverlaySimulation extends _$EewWarningOverlaySimulation {
  @override
  EewWarningOverlayDisplayModel? build() {
    ref.listen(eewWarningOverlayDisplayProvider, (_, real) {
      if (real != null) {
        state = null;
      }
    });
    return null;
  }

  void start() {
    if (ref.read(eewWarningOverlayDisplayProvider) != null) {
      return;
    }
    state = const EewWarningOverlayDisplayModel(
      source: EewWarningOverlaySource.simulation,
      eventIds: ['eew-warning-overlay-simulation'],
      representativeEventId: 'eew-warning-overlay-simulation',
      serialNo: 1,
      alertCount: 1,
      reportLabel: '訓練／シミュレーション',
      hypocenterHeadline: 'テスト震源で地震',
      strongMotionHeadline: 'テスト地域で強い揺れ',
      currentRegionName: 'テスト地域',
      localIntensity: JmaIntensity.sixLower,
      localIntensityIsOver: false,
      arrivalState: EewWarningArrivalState.unarrived,
      secondsUntilArrival: 10,
      hypocenterName: 'テスト震源',
      magnitude: null,
      depth: null,
    );
  }

  void stop() {
    state = null;
  }
}
