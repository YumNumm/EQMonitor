import 'package:eqmonitor/feature/map_libre/provider/map_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

class MainMapWidget extends HookConsumerWidget {
  const MainMapWidget({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapStyle = ref.watch(mapStyleProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final styleJsonFuture = useFuture(mapStyle.getStyle(isDark: isDark));
    final path = styleJsonFuture.data;
    if (path == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      );
    }

    final mapLibreController = useState<MaplibreMapController?>(null);
    final visibleRegion = useState<LatLngBounds?>(null);

    return Stack(
      children: [
        MaplibreMap(
          styleString: path,
          initialCameraPosition: const CameraPosition(
            target: LatLng(35, 135),
            zoom: 6,
          ),
          rotateGesturesEnabled: false,
          tiltGesturesEnabled: false,
          onMapCreated: (controller) {
            mapLibreController.value = controller;
            controller.addListener(() async {
              visibleRegion.value = await controller.getVisibleRegion();
            });
          },
        ),
        Center(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                'visibleRegion: ${visibleRegion.value}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
