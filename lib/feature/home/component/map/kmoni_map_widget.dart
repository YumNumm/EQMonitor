import 'package:eqapi_schema/model/lat_lng.dart';
import 'package:eqmonitor/common/component/map/model/map_state.dart';
import 'package:eqmonitor/common/component/map/view_model/map_viemwodel.dart';
import 'package:eqmonitor/common/feature/map/utils/web_mercator_projection.dart';
import 'package:eqmonitor/feature/home/providers/kmoni/data/asset/kmoni_observation_point.dart';
import 'package:eqmonitor/feature/home/providers/kmoni/viewmodel/kmoni_view_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class KmoniMapWidget extends HookConsumerWidget {
  const KmoniMapWidget({
    super.key,
    required this.mapKey,
  });
  final Key mapKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(MapViewModelProvider(mapKey));
    final kmoniState = ref
        .watch(kmoniViewModelProvider.select((value) => value.analyzedPoints));
    return CustomPaint(
      painter: _KmoniPainter(
        state: state,
        kmoniState: kmoniState,
      ),
      size: Size.infinite,
    );
  }
}

class _KmoniPainter extends CustomPainter {
  _KmoniPainter({
    required this.state,
    required this.kmoniState,
  });

  final MapState state;
  final List<AnalyzedKmoniObservationPoint>? kmoniState;

  @override
  void paint(Canvas canvas, Size size) {
    if (kmoniState == null) {
      return;
    }
    final circleSize = switch (state.zoomLevel) {
      < 30 => 2.0,
      > 60 => 5.0,
      _ => 3.0,
    };
    for (final e in kmoniState!) {
      final offset = state.globalPointToOffset(
        WebMercatorProjection().project(
          LatLng(e.lat, e.lon),
        ),
      );
      // 画面外の場合は描画しない
      if (offset.dx < 0 ||
          offset.dx > size.width ||
          offset.dy < 0 ||
          offset.dy > size.height) {
        continue;
      }
      final paint = Paint()
        ..color = e.intensityColor ?? Colors.transparent
        ..style = PaintingStyle.fill;
      canvas.drawCircle(
        offset,
        circleSize,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _KmoniPainter oldDelegate) => true;
}
