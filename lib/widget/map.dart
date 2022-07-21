import 'package:eqmonitor/state/all_state.dart';
import 'package:eqmonitor/widget/custom_map/custommap.dart';
import 'package:flutter/material.dart' hide Theme;
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MapWidget extends ConsumerWidget {
  const MapWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final kmoniMap = ref.watch(kmoniMapNotifier);
    final mapSource =
        ref.watch(kmoniMapNotifier.select((value) => value.mapPolygons ));
    final kmoni = ref.watch(kmoniNotifier);

    return GestureDetector(
      child: InteractiveViewer(
        maxScale: 10000,
        scaleEnabled: true,
        panEnabled: true,
        child: Transform(
          transform: kmoniMap.mapMatrix4,
          child: CustomPaint(
            painter: CustomMap(
              mapPolygons: mapSource,
              outlineStrokeWidth: 0.1,
              obsPoints: kmoni.analyzedPoint,
            ),
            size: Size.infinite,
          ),
        ),
      ),
    );
  }
}
