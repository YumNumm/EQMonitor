import 'dart:async';

import 'package:eqmonitor/core/provider/capture/intensity_icon_render.dart';
import 'package:eqmonitor/feature/home/features/map/viewmodel/main_map_viewmodel.dart';
import 'package:eqmonitor/feature/map_libre/provider/map_style.dart';
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
    if (stylePath.value == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      );
    }

    // 震央画像 / 震度アイコンの登録
    final images = (
      intenistyIcon: ref.watch(intensityIconRenderProvider),
      intensityIconFill: ref.watch(intensityIconFillRenderProvider),
      hypocenterIcon: ref.watch(hypocenterIconRenderProvider),
      hypocenterLowPreciseIcon:
          ref.watch(hypocenterLowPreciseIconRenderProvider),
    );
    // 初回描画が終わるまで待つ
    if (images.hypocenterIcon == null ||
        images.hypocenterLowPreciseIcon == null ||
        !images.intenistyIcon.isAllRendered() ||
        !images.intensityIconFill.isAllRendered()) {
      return const SizedBox.shrink();
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
        onMapCreated: (controller) => mapController.value = controller,
        onStyleLoadedCallback: () async {
          final controller = mapController.value;
          await controller?.setSymbolIconAllowOverlap(true);
          await controller?.setSymbolIconIgnorePlacement(true);
          final notifier = ref.read(mainMapViewModelProvider.notifier)
            ..registerMapController(
              controller!,
            )
            ..moveCameraToDefaultPosition();
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
              notifier.startUpdateKmoni(),
              notifier.startUpdateEew(),
            ].wait,
          );
        },
        rotateGesturesEnabled: false,
        tiltGesturesEnabled: false,
      ),
    );
    return map;
  }
}
