import 'dart:ui' as ui;

import 'package:eqapi_types/model/telegram_v3.dart';
import 'package:eqmonitor/core/component/map/model/map_state.dart';
import 'package:eqmonitor/core/component/map/utils/web_mercator_projection.dart';
import 'package:eqmonitor/core/component/map/view_model/map_viewmodel.dart';
import 'package:eqmonitor/feature/home/features/eew/eew_provider.dart';
import 'package:eqmonitor/feature/home/features/travel_time/model/travel_time_table.dart';
import 'package:eqmonitor/feature/home/features/travel_time/provider/travel_time_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lat_lng/lat_lng.dart';
import 'package:latlong2/latlong.dart' as latlong2;

class EewPsWaveArrivalCircleWidget extends HookConsumerWidget {
  factory EewPsWaveArrivalCircleWidget.border({
    required Key mapKey,
  }) =>
      EewPsWaveArrivalCircleWidget._(
        mapKey: mapKey,
        drawBorder: true,
      );

  factory EewPsWaveArrivalCircleWidget.gradient({
    required Key mapKey,
  }) =>
      EewPsWaveArrivalCircleWidget._(
        mapKey: mapKey,
        drawGradient: true,
      );

  const EewPsWaveArrivalCircleWidget._({
    required this.mapKey,
    this.drawBorder = false,
    this.drawGradient = false,
  });
  final Key mapKey;
  final bool drawBorder;
  final bool drawGradient;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(mapViewModelProvider(mapKey));
    final travelTimeTables = ref.watch(travelTimeProvider);
    final eews = ref.watch(eewFilteredTelegramProvider);

    final controller = useAnimationController(
      duration: const Duration(microseconds: 78000),
    );
    useAnimation(controller);
    useEffect(
      () {
        controller.repeat();
        return null;
      },
      [],
    );

    final hypoWidget = CustomPaint(
      willChange: true,
      painter: _HypocenterPainter(
        state: state,
        eews: eews,
        travelTimeTables: travelTimeTables,
        drawBorder: drawBorder,
        drawGradient: drawGradient,
      ),
      size: Size.infinite,
    );
    return hypoWidget;
  }
}

class _HypocenterPainter extends CustomPainter {
  _HypocenterPainter({
    required this.state,
    required this.eews,
    required this.travelTimeTables,
    required this.drawBorder,
    required this.drawGradient,
  });

  final MapState state;
  List<(TelegramVxse45Body, TelegramV3)> eews;
  final TravelTimeTables travelTimeTables;

  final bool drawBorder;
  final bool drawGradient;

  @override
  void paint(Canvas canvas, Size size) {
    final projection = WebMercatorProjection();
    for (final e in eews) {
      final eew = e.$1;
      final telegram = e.$2;
      final hypo = latlong2.LatLng(
        eew.hypocenter!.coordinate!.lat,
        eew.hypocenter!.coordinate!.lon,
      );
      final globalPoint = WebMercatorProjection().project(
        eew.hypocenter!.coordinate!,
      );

      final travel = travelTimeTables.getValue(
        eew.depth!,
        DateTime.now()
                .difference(
                  eew.originTime!.toLocal(),
                )
                .inMilliseconds /
            1000,
      );

      final sOffsets = <Offset>[];

      final offset = state.globalPointToOffset(globalPoint);
      if (travel.sDistance != null) {
        for (final bearing in List<int>.generate(360, (index) => index)) {
          final result = const latlong2.Distance().offset(
            hypo,
            ((travel.sDistance!) * 1000).toInt(),
            bearing,
          );
          sOffsets.add(
            state.globalPointToOffset(
              projection.project(
                LatLng(result.latitude, result.longitude),
              ),
            ),
          );
        }
        final isWarning = telegram.headline?.contains('強い揺れ') ?? false;
        final sPath = Path()..addPolygon(sOffsets, true);
        if (drawGradient) {
          canvas.drawPath(
            sPath,
            Paint()
              ..shader = ui.Gradient.radial(
                offset,
                ((sOffsets.firstOrNull ?? Offset.zero) - offset).distance,
                isWarning
                    ? [
                        const ui.Color.fromARGB(255, 255, 0, 0).withOpacity(0),
                        const ui.Color.fromARGB(255, 255, 0, 0)
                            .withOpacity(0.3),
                      ]
                    : [
                        const ui.Color.fromARGB(255, 255, 89, 0).withOpacity(0),
                        const ui.Color.fromARGB(255, 255, 89, 0)
                            .withOpacity(0.3),
                      ],
              ),
          );
        }
        if (drawBorder) {
          canvas.drawPath(
            sPath,
            Paint()
              ..color = isWarning
                  ? const ui.Color.fromARGB(255, 255, 0, 0)
                  : const ui.Color.fromARGB(255, 255, 89, 0)
              ..isAntiAlias = true
              ..strokeCap = StrokeCap.square
              ..style = PaintingStyle.stroke
              ..strokeWidth = 1,
          );
        }
      }
      // Pwave
      if (travel.pDistance != null && drawBorder) {
        final pOffsets = <Offset>[];
        for (final bearing in List<int>.generate(360, (index) => index)) {
          final result = const latlong2.Distance().offset(
            hypo,
            ((travel.pDistance!) * 1000).toInt(),
            bearing,
          );
          pOffsets.add(
            state.globalPointToOffset(
              projection.project(
                LatLng(result.latitude, result.longitude),
              ),
            ),
          );
        }
        final pPath = Path()..addPolygon(pOffsets, true);
        canvas.drawPath(
          pPath,
          Paint()
            ..color = const ui.Color.fromARGB(255, 0, 0, 255)
            ..isAntiAlias = true
            ..strokeCap = StrokeCap.square
            ..style = PaintingStyle.stroke
            ..strokeWidth = 0,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant _HypocenterPainter oldDelegate) => true;
}
