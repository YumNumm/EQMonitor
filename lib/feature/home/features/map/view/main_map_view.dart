import 'dart:async';
import 'dart:convert';

import 'package:eqmonitor/core/provider/capture/intensity_icon_render.dart';
import 'package:eqmonitor/core/provider/map_style/map_style.dart';
import 'package:eqmonitor/feature/home/features/debugger/debugger_provider.dart';
import 'package:eqmonitor/feature/home/features/estimated_intensity/provider/estimated_intensity_provider.dart';
import 'package:eqmonitor/feature/home/features/map/viewmodel/main_map_viewmodel.dart';
import 'package:eqmonitor/feature/home/features/travel_time/provider/travel_time_provider.dart';
import 'package:eqmonitor/gen/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

class MainMapView extends HookConsumerWidget {
  const MainMapView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = useState(Theme.of(context).brightness == Brightness.dark);
    final mapStyle = ref.watch(mapStyleProvider);
    final stylePath = useState<String?>(null);
    final getStyleJsonFuture = useMemoized(
      () async {
        final path = await mapStyle.getStyle(isDark: isDark.value);
        stylePath.value = path;
      },
      [isDark.value],
    );
    useFuture(
      getStyleJsonFuture,
    );
    final cameraPosition = useState<String>('');

    final controller = useAnimationController(
      duration: const Duration(microseconds: 1000),
    );
    useAnimation(controller);
    useEffect(
      () {
        controller
          ..repeat()
          ..addListener(
            () => ref
                .read(mainMapViewModelProvider.notifier)
                .onTick(DateTime.now()),
          );
        return null;
      },
      [],
    );

    // 震央画像 / 震度アイコンの登録
    final images = (
      intenistyIcon: ref.watch(intensityIconRenderProvider),
      intensityIconFill: ref.watch(intensityIconFillRenderProvider),
      hypocenterIcon: ref.watch(hypocenterIconRenderProvider),
      hypocenterLowPreciseIcon:
          ref.watch(hypocenterLowPreciseIconRenderProvider),
    );
    final hasTravelTimeDepthMapValue = ref.watch(
      travelTimeDepthMapProvider
          .select((e) => e.valueOrNull?.isNotEmpty ?? false),
    );
    // 初回描画が終わるまで待つ
    if (stylePath.value == null ||
        images.hypocenterIcon == null ||
        images.hypocenterLowPreciseIcon == null ||
        !images.intenistyIcon.isAllRendered() ||
        !images.intensityIconFill.isAllRendered() ||
        !hasTravelTimeDepthMapValue) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      );
    }

    final mapController = useState<MaplibreMapController?>(null);

    useEffect(
      () {
        final dispatcher = SchedulerBinding.instance.platformDispatcher;
        dispatcher.onPlatformBrightnessChanged = () =>
            isDark.value = dispatcher.platformBrightness == Brightness.dark;
        return null;
      },
      [],
    );
    ref.watch(mainMapViewModelProvider);

    final map = RepaintBoundary(
      child: MaplibreMap(
        initialCameraPosition: const CameraPosition(
          target: LatLng(35.681236, 139.767125),
          zoom: 3,
        ),
        styleString: stylePath.value,
        onMapCreated: (controller) {
          mapController.value = controller;

          controller.addListener(
            () {
              final position = controller.cameraPosition;
              if (position != null) {
                cameraPosition.value =
                    const JsonEncoder.withIndent(' ').convert(position.toMap());
              }
            },
          );
        },
        onStyleLoadedCallback: () async {
          final controller = mapController.value;
          await controller?.setSymbolIconAllowOverlap(true);
          await controller?.setSymbolIconIgnorePlacement(true);
          final notifier = ref.read(mainMapViewModelProvider.notifier)
            ..registerMapController(
              controller!,
            );

          await Future.wait(
            [
              notifier.updateImage(
                name: 'hypocenter',
                bytes: images.hypocenterIcon!,
              ),
              notifier.updateImage(
                name: 'hypocenter-low-precise',
                bytes: images.hypocenterLowPreciseIcon!,
              ),
              for (final MapEntry(:key, :value) in images.intenistyIcon.entries)
                notifier.updateImage(
                  name: 'intensity-${key.type}',
                  bytes: value,
                ),
              for (final MapEntry(:key, :value)
                  in images.intensityIconFill.entries)
                notifier.updateImage(
                  name: 'intensity-fill-${key.type}',
                  bytes: value,
                ),
            ],
          );
          unawaited(
            [
              notifier.onMapControllerRegistered(),
              notifier.startUpdateEew(),
              notifier.moveCameraToDefaultPosition(
                bottom: 100,
                left: 10,
                right: 10,
              ),
            ].wait,
          );
        },
        rotateGesturesEnabled: false,
        tiltGesturesEnabled: false,
        trackCameraPosition: true,
      ),
    );
    return Stack(
      children: [
        map,
        if (ref
            .watch(debuggerProvider.select((value) => value.isDebugger))) ...[
          _MapDebugWidget(cameraPosition: cameraPosition),
        ],
      ],
    );
  }
}

class _MapDebugWidget extends HookConsumerWidget {
  const _MapDebugWidget({
    required this.cameraPosition,
  });

  final ValueNotifier<String> cameraPosition;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isExpanded = useState(false);
    if (!isExpanded.value) {
      return AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: FilledButton.tonalIcon(
              onPressed: () => isExpanded.value = true,
              label: const Text(
                'Debug',
                style: TextStyle(
                  fontFamily: FontFamily.jetBrainsMono,
                ),
              ),
              icon: const Icon(Icons.bug_report),
            ),
          ),
        ),
      );
    }
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: InkWell(
        onTap: () => isExpanded.value = false,
        child: Card(
          color: Theme.of(context).colorScheme.surface.withOpacity(0.8),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${cameraPosition.value}\n'
                  'EewEstimatedIntensity: ${ref.watch(estimatedIntensityProvider).firstOrNull}',
                  style: const TextStyle(
                    fontSize: 10,
                    fontFamily: FontFamily.jetBrainsMono,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
