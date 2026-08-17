import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_warning_overlay_display_model.dart';
import 'package:eqmonitor/feature/eew/data/notifier/eew_warning_overlay_simulation_notifier.dart';
import 'package:eqmonitor/feature/eew/data/provider/eew_warning_overlay_display_provider.dart';
import 'package:eqmonitor/feature/eew/data/provider/eew_warning_overlay_effective_display_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final mutableRealDisplayProvider =
    NotifierProvider<MutableRealDisplay, EewWarningOverlayDisplayModel?>(
      MutableRealDisplay.new,
    );

final class MutableRealDisplay
    extends Notifier<EewWarningOverlayDisplayModel?> {
  new([this.initial]);

  final EewWarningOverlayDisplayModel? initial;

  @override
  EewWarningOverlayDisplayModel? build() => initial;

  void publish(EewWarningOverlayDisplayModel? model) => state = model;
}

ProviderContainer simulationContainer({
  EewWarningOverlayDisplayModel? real,
  MutableRealDisplay? realNotifier,
}) => ProviderContainer(
  overrides: [
    mutableRealDisplayProvider.overrideWith(
      () => realNotifier ?? MutableRealDisplay(real),
    ),
    eewWarningOverlayDisplayProvider.overrideWith(
      (ref) => ref.watch(mutableRealDisplayProvider),
    ),
  ],
);

EewWarningOverlayDisplayModel realDisplayModel({required String eventId}) =>
    EewWarningOverlayDisplayModel(
      source: EewWarningOverlaySource.real,
      eventIds: [eventId],
      representativeEventId: eventId,
      serialNo: 1,
      alertCount: 1,
      reportLabel: '第1報',
      hypocenterHeadline: '実震源で地震',
      strongMotionHeadline: '実地域で強い揺れ',
      currentRegionName: '実地域',
      localIntensity: JmaIntensity.fiveLower,
      localIntensityIsOver: false,
      arrivalState: EewWarningArrivalState.unknown,
      secondsUntilArrival: null,
      hypocenterName: '実震源',
      magnitude: 5,
      depth: 10,
    );

void main() {
  test('startは設定に依存しない固定訓練モデルを公開する', () {
    final container = simulationContainer(real: null);
    addTearDown(container.dispose);

    container.read(eewWarningOverlaySimulationProvider.notifier).start();
    final model = container.read(eewWarningOverlaySimulationProvider);

    expect(
      model,
      const EewWarningOverlayDisplayModel(
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
      ),
    );
  });

  test('stopは訓練モデルを消す', () {
    final container = simulationContainer(real: null);
    addTearDown(container.dispose);
    final notifier = container.read(
      eewWarningOverlaySimulationProvider.notifier,
    );

    notifier.start();
    notifier.stop();

    expect(container.read(eewWarningOverlaySimulationProvider), isNull);
  });

  test('実警報が訓練を破棄し終了後も訓練へ戻らない', () async {
    final real = MutableRealDisplay();
    final container = simulationContainer(realNotifier: real);
    addTearDown(container.dispose);
    final effectiveSubscription = container.listen(
      eewWarningOverlayEffectiveDisplayProvider,
      (_, _) {},
    );
    addTearDown(effectiveSubscription.close);

    container.read(eewWarningOverlaySimulationProvider.notifier).start();
    expect(
      container.read(eewWarningOverlayEffectiveDisplayProvider)?.source,
      EewWarningOverlaySource.simulation,
    );

    real.publish(realDisplayModel(eventId: 'real-event'));
    await container.pump();
    expect(
      container.read(eewWarningOverlayEffectiveDisplayProvider)?.source,
      EewWarningOverlaySource.real,
    );
    expect(container.read(eewWarningOverlaySimulationProvider), isNull);

    real.publish(null);
    await container.pump();
    expect(container.read(eewWarningOverlayEffectiveDisplayProvider), isNull);
  });

  test('実警報中のstartは訓練を開始しない', () {
    final container = simulationContainer(
      real: realDisplayModel(eventId: 'real-event'),
    );
    addTearDown(container.dispose);

    container.read(eewWarningOverlaySimulationProvider.notifier).start();

    expect(container.read(eewWarningOverlaySimulationProvider), isNull);
    expect(
      container.read(eewWarningOverlayEffectiveDisplayProvider)?.source,
      EewWarningOverlaySource.real,
    );
  });
}
