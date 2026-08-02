import 'package:collection/collection.dart';
import 'package:eqmonitor/core/component/error/error_card.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/eew/data/eew_alive_telegram.dart';
import 'package:eqmonitor/feature/home/data/model/home_configuration_model.dart';
import 'package:eqmonitor/feature/home/data/notifier/home_configuration_notifier.dart';
import 'package:eqmonitor/feature/home/data/notifier/eew_map_focus.dart';
import 'package:eqmonitor/feature/home/data/provider/map_camera_state_provider.dart';
import 'package:eqmonitor/feature/home/ui/component/map/home_map_controller_card.dart';
import 'package:eqmonitor/feature/home/ui/component/map/home_map_options.dart';
import 'package:eqmonitor/feature/home/ui/component/map/layer/eew_estimated_intensity_layer.dart';
import 'package:eqmonitor/feature/home/ui/component/map/layer/eew_hypocenter_layer.dart';
import 'package:eqmonitor/feature/home/ui/component/map/layer/eew_ps_wave_layer.dart';
import 'package:eqmonitor/feature/home/ui/component/map/layer/eew_warning_regions_layer.dart';
import 'package:eqmonitor/feature/home/ui/component/map/layer/home_map_label_layer.dart';
import 'package:eqmonitor/feature/home/ui/component/map/layer/kyoshin_monitor_observation_layer.dart';
import 'package:eqmonitor/feature/home/ui/component/map/layer/shake_detection_layer.dart';
import 'package:eqmonitor/feature/home/ui/component/map/modal/home_map_label_debug_modal.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/provider/kyoshin_monitor_settings.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/page/components/connection_status_card.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/page/components/kyoshin_monitor_status_card.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/ui/components/kyoshin_monitor_scale_card.dart';
import 'package:eqmonitor/feature/map/data/notifier/map_configuration_notifier.dart';
import 'package:eqmonitor/feature/map/ui/map_operation_queue_scope.dart';
import 'package:eqmonitor/feature/map/ui/maplibre_event_provider.dart';
import 'package:eqmonitor/feature/playback_mode/ui/playback_mode_modal.dart';
import 'package:eqmonitor/feature/settings/features/debug/debug_provider.dart';
import 'package:eqmonitor/feature/shake_detection/data/provider/shake_detection_merge_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';

class HomeMapView extends ConsumerWidget {
  const HomeMapView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapConfiguration = ref.watch(mapConfigurationProvider);
    final designSystem = context.designSystem;
    final colorTheme = designSystem.colorTheme;
    final spacing = designSystem.spacing;
    final typography = designSystem.typography;

    return switch (mapConfiguration) {
      AsyncData(:final value) when value.styleString != null => _MapContent(
        styleString: value.styleString!,
      ),
      AsyncError(:final error) => Center(child: ErrorCard(error: error)),
      _ => Center(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: spacing.xl,
            vertical: spacing.lg,
          ),
          decoration: BoxDecoration(
            color: colorTheme.surfaceContainerHigh.withValues(alpha: 0.92),
            borderRadius: BorderRadius.circular(designSystem.shape.card),
            border: Border.all(color: colorTheme.outlineVariant),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator.adaptive(),
              SizedBox(height: spacing.md),
              Text('地図を準備しています', style: typography.bodyMedium),
            ],
          ),
        ),
      ),
    };
  }
}

class _MapContent extends ConsumerWidget {
  const _MapContent({required this.styleString});

  final String styleString;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeAsync = ref.watch(homeConfigurationProvider);
    final mapSettings = homeAsync.value?.map ?? const HomeMapSettings();
    final showLocation = homeAsync.value?.common.showLocation ?? false;

    final mapOptions = homeMapOptionsFromSettings(
      context: context,
      styleString: styleString,
      map: mapSettings,
    );

    // テーマ/ダークモード変更で styleString が変わった場合も含め、
    // マップ設定が変わるたびに MapLibreMap を再生成する。
    final mapKey = Object.hash(
      styleString,
      mapSettings.maxZoom,
      mapSettings.lockBearing,
      mapSettings.defaultBounds,
      mapSettings.customBounds,
      showLocation,
    );

    return MapOperationQueueScope(
      child: MapLibreEventProvider(
        child: _MapLibreMapHost(
          key: ValueKey(mapKey),
          mapOptions: mapOptions,
          showLocation: showLocation,
          children: [
            Consumer(
              builder: (context, ref, _) {
                final fillMode = ref.watch(
                  homeConfigurationProvider.select(
                    (a) => a.value?.eew.fillMode ?? .intensity,
                  ),
                );
                final eews = ref.watch(eewAliveTelegramProvider) ?? [];
                final regions = eews
                    .map((eew) => eew.forecastIntensity?.regions)
                    .nonNulls
                    .flattened
                    .toList();
                return switch (fillMode) {
                  .intensity => EewEstimatedIntensityLayer(eewRegions: regions),
                  .warning => EewWarningRegionsLayer(eews: eews),
                  .none => const SizedBox.shrink(),
                };
              },
            ),
            const KyoshinMonitorObservationLayer(),
            Consumer(
              builder: (context, ref, _) {
                final eews = ref.watch(eewAliveTelegramProvider) ?? [];
                return EewPsWaveLayer(eews: eews);
              },
            ),
            Consumer(
              builder: (context, ref, _) => ShakeDetectionLayer(
                events: ref.watch(shakeDetectionVisibleProvider),
              ),
            ),
            Consumer(
              builder: (context, ref, _) => EewHypocenterLayer(
                eews: ref.watch(eewAliveTelegramProvider) ?? [],
              ),
            ),
            const HomeMapLabelLayer(),
            const SafeArea(child: _MapHeader()),
          ],
        ),
      ),
    );
  }
}

/// [MapLibreMap] 本体を保持する Widget。
///
/// [ValueKey] による remount（設定トグル・スタイル変更等）が発生すると
/// この Widget 自体が unmount→remount されるため、`dispose()` で
/// [HomeMapCameraState] が保持する [MapController] を確実にクリアできる。
class _MapLibreMapHost extends ConsumerStatefulWidget {
  const _MapLibreMapHost({
    required this.mapOptions,
    required this.showLocation,
    required this.children,
    super.key,
  });

  final MapOptions mapOptions;
  final bool showLocation;
  final List<Widget> children;

  @override
  ConsumerState<_MapLibreMapHost> createState() => _MapLibreMapHostState();
}

class _MapLibreMapHostState extends ConsumerState<_MapLibreMapHost> {
  MapController? _controller;

  // dispose() は Element が unmount された後に呼ばれるため、その時点で
  // ref.read() を呼ぶと StateError になる。Element がactiveな間（build時）
  // に notifier への参照を取得し、フィールドへ保持しておく。
  late HomeMapCameraState _cameraNotifier;

  @override
  void dispose() {
    final controller = _controller;
    if (controller != null) {
      _cameraNotifier.clearController(controller: controller);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _cameraNotifier = ref.read(homeMapCameraStateProvider.notifier);
    return LayoutBuilder(
      builder: (context, constraints) => MapLibreMap(
        key: ValueKey(constraints.biggest),
        options: widget.mapOptions,
        onMapCreated: (controller) async {
          if (!mounted) {
            return;
          }
          _controller = controller;
          await ref
              .read(homeMapCameraStateProvider.notifier)
              .setController(
                controller: controller,
                viewportSize: constraints.biggest,
              );
          if (widget.showLocation) {
            await controller.enableLocation();
          }
        },
        onEvent: (event) {
          MapLibreEventProvider.maybeOf(context)?.emit(event);
          if (event is MapEventStartMoveCamera &&
              event.reason == CameraChangeReason.apiGesture) {
            ref.read(eewMapFocusProvider.notifier).clearFocus();
          }
        },
        children: widget.children,
      ),
    );
  }
}

class _MapHeader extends ConsumerWidget {
  const _MapHeader();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final useKmoni =
        ref.watch(
          kyoshinMonitorSettingsProvider.select((v) => v.value?.useKmoni),
        ) ??
        false;
    final showScale =
        ref.watch(
          kyoshinMonitorSettingsProvider.select((v) => v.value?.showScale),
        ) ??
        false;

    final kyoshinMonitorColumn = Column(
      key: const ValueKey('kyoshin_monitor_status_card'),
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        KyoshinMonitorStatusCard(
          onTap: () async => const HomeMapLayerRoute().push<void>(context),
        ),
        const ConnectionStatusCard(),
        if (showScale)
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: KyoshinMonitorScaleCard(),
          ),
      ],
    );

    final isDebug = ref.watch(debugProvider).value ?? false;
    final focus = ref.watch(eewMapFocusProvider);
    final hasAliveEew = (ref.watch(eewAliveTelegramProvider) ?? []).isNotEmpty;
    // カメラが実際に EEW へ寄せられている間だけ無効化する。
    // autoZoom 無効時や fit 対象が無い場合（PLUM 等）は明示操作を残す。
    final isLocationButtonEnabled =
        !hasAliveEew || !focus.isFocused || !focus.hasAppliedFocus;

    final controllerCard = HomeMapControllerCard(
      isLocationButtonEnabled: isLocationButtonEnabled,
      onLayerButtonTap: () async =>
          const HomeMapLayerRoute().push<void>(context),
      onLocationButtonTap: () =>
          ref.read(homeMapCameraStateProvider.notifier).returnToHome(),
      onLabelDebugButtonTap: isDebug
          ? () => HomeMapLabelDebugModal.show(context: context)
          : null,
      onDebugButtonTap: isDebug ? () => PlaybackModeModal.show(context) : null,
    );

    return Padding(
      padding: EdgeInsets.all(context.designSystem.spacing.sm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: useKmoni ? kyoshinMonitorColumn : const SizedBox.shrink(),
          ),
          const Column(),
          controllerCard,
        ],
      ),
    );
  }
}
