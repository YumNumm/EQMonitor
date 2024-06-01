import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:eqmonitor/core/provider/capture/intensity_icon_render.dart';
import 'package:eqmonitor/core/provider/debugger/debugger_provider.dart';
import 'package:eqmonitor/core/provider/estimated_intensity/provider/estimated_intensity_provider.dart';
import 'package:eqmonitor/core/provider/map/map_style.dart';
import 'package:eqmonitor/core/provider/ntp/ntp_provider.dart';
import 'package:eqmonitor/core/provider/travel_time/provider/travel_time_provider.dart';
import 'package:eqmonitor/core/provider/websocket/websocket_provider.dart';
import 'package:eqmonitor/core/theme/platform_brightness.dart';
import 'package:eqmonitor/feature/home/features/map/viewmodel/main_map_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

class MainMapView extends HookConsumerWidget {
  const MainMapView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(mainMapViewModelProvider);
    final isDark = useState(Theme.of(context).brightness == Brightness.dark);
    ref.listen(
      platformBrightnessProvider,
      (_, value) =>
          isDark.value = Theme.of(context).brightness == Brightness.dark,
    );
    final mapStyle = ref.watch(mapStyleProvider);
    final stylePath = useState<String?>(null);
    final getStyleJsonFuture = useMemoized(
      () async {
        final path = await mapStyle.getStyle(
          isDark: isDark.value,
          scheme: Theme.of(context).colorScheme,
        );
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
    useEffect(
      () {
        controller
          ..repeat()
          ..addListener(
            () {
              final now =
                  ref.read(ntpProvider.notifier).now() ?? DateTime.now();
              ref.read(mainMapViewModelProvider.notifier).onTick(now);
            },
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

    final map = RepaintBoundary(
      child: MaplibreMap(
        minMaxZoomPreference: const MinMaxZoomPreference(
          0,
          10,
        ),
        initialCameraPosition: const CameraPosition(
          target: LatLng(35.681236, 139.767125),
          zoom: 5,
        ),
        styleString: stylePath.value ?? '',
        onMapCreated: (controller) {
          mapController.value = controller;
          if (ref.read(debuggerProvider).isDebugger) {
            controller.addListener(
              () {
                final position = controller.cameraPosition;
                if (position != null) {
                  try {
                    cameraPosition.value = const JsonEncoder.withIndent(' ')
                        .convert(position.toMap());
                    // ignore: avoid_catching_errors
                  } on JsonUnsupportedObjectError {
                    log('JsonUnsupportedObjectError');
                  }
                }
              },
            );
          }
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
          await notifier.onMapControllerRegistered();
          await notifier.startUpdateEew();
        },
        rotateGesturesEnabled: false,
        tiltGesturesEnabled: false,
        trackCameraPosition: true,
      ),
    );
    return Stack(
      children: [
        map,
        if (ref.watch(debuggerProvider.select((value) => value.isDebugger)))
          const SafeArea(
            child: _MapDebugWidget(),
          ),
      ],
    );
  }
}

class _MapDebugWidget extends HookConsumerWidget {
  const _MapDebugWidget();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isExpanded = useState(false);
    final isVisible = useState(true);
    if (!isVisible.value) {
      return const SizedBox();
    }
    if (!isExpanded.value) {
      return AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: FilledButton.tonalIcon(
              onPressed: () => isExpanded.value = true,
              label: const Text('Debug'),
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
                TextButton(
                  child: const Text('CLOSE'),
                  onPressed: () => isVisible.value = false,
                ),
                TextButton(
                  child: const Text('EEW'),
                  onPressed: () async {
                    final message = await showDialog<String>(
                      context: context,
                      builder: (context) {
                        return SimpleDialog(
                          title: const Text('EEW Debug'),
                          children: [
                            for (final message in <String>[
                              'eew/20170701a',
                              'eew/20171213a',
                              'eew/20171213b',
                              'eew/20220721085038',
                              'eew/tech566',
                            ])
                              ListTile(
                                title: Text(message),
                                onTap: () => Navigator.of(context).pop(message),
                              ),
                          ],
                        );
                      },
                    );
                    if (message != null) {
                      ref.read(websocketProvider).send(message);
                    }
                  },
                ),
                Text(
                  'EewEstimatedIntensity: ${ref.watch(estimatedIntensityProvider).firstOrNull}\n'
                  'Websocket: ${ref.watch(websocketStatusProvider)}\n',
                  style: const TextStyle(
                    fontSize: 10,
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
