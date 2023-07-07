import 'dart:ui' as ui;

import 'package:eqapi_schema/extension/telegram_v3.dart';
import 'package:eqapi_schema/model/telegram_v3.dart';
import 'package:eqmonitor/common/component/map/model/map_state.dart';
import 'package:eqmonitor/common/component/map/utils/web_mercator_projection.dart';
import 'package:eqmonitor/common/component/map/view_model/map_viewmodel.dart';
import 'package:eqmonitor/feature/home/features/eew/eew_provider.dart';
import 'package:eqmonitor/feature/home/features/travel_time/model/travel_time_table.dart';
import 'package:eqmonitor/feature/home/features/travel_time/provider/travel_time_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lat_lng/lat_lng.dart';
import 'package:latlong2/latlong.dart' as latlong2;

class EewPsWaveArrivalCircleWidget extends StatefulHookConsumerWidget {
  const EewPsWaveArrivalCircleWidget({required this.mapKey, super.key});

  final Key mapKey;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EewPsWaveArrivalCircleWidgetState();
}

class _EewPsWaveArrivalCircleWidgetState
    extends ConsumerState<EewPsWaveArrivalCircleWidget> {
  @override
  Widget build(BuildContext context) {
    final mapKey = widget.mapKey;

    final state = ref.watch(MapViewModelProvider(mapKey));
    final travelTimeTables = ref.watch(travelTimeProvider);
    final eewTelegrams = ref.watch(eewTelegramProvider);
    final eews = useMemoized(
      () => eewTelegrams
          .where(
            (e) => e.latestEew != null && e.latestEew is TelegramVxse45Body,
          )
          .map(
            (e) => (e.latestEew! as TelegramVxse45Body, e.latestEewTelegram!),
          )
          .where(
        (e) {
          final eew = e.$1;
          return eew.magnitude != null &&
              eew.magnitude != null &&
              eew.hypocenter != null &&
              !(eew.isLevelEew && eew.isPlum && eew.isIpfOnePoint);
        },
      ).toList(),
      [eewTelegrams],
    );

    final controller = useAnimationController(
      duration: const Duration(microseconds: 1000),
    );
    final tween = Tween<double>(
      begin: 0,
      end: 1,
    );
    useMemoized(
      () {
        final animation = tween.animate(controller)
          ..addListener(
            () => setState(() {}),
          )
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              controller.reverse();
            } else if (status == AnimationStatus.dismissed) {
              controller.forward();
            }
          });
        controller.forward();

        return animation;
      },
      [state],
    );

    final hypoWidget = CustomPaint(
      willChange: true,
      painter: _HypocenterPainter(
        state: state,
        eews: eews,
        travelTimeTables: travelTimeTables,
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
  });

  final MapState state;
  List<(TelegramVxse45Body, TelegramV3)> eews;
  final TravelTimeTables travelTimeTables;

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
                .subtract(const Duration(hours: 48681, minutes: 5))
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
        canvas
          ..drawPath(
            sPath,
            Paint()
              ..shader = ui.Gradient.radial(
                offset,
                ((sOffsets.firstOrNull ?? Offset.zero) - offset).distance,
                isWarning
                    ? [
                        const ui.Color.fromARGB(255, 255, 0, 0).withOpacity(0),
                        const ui.Color.fromARGB(255, 255, 0, 0).withOpacity(0.3)
                      ]
                    : [
                        const ui.Color.fromARGB(255, 255, 89, 0).withOpacity(0),
                        const ui.Color.fromARGB(255, 255, 89, 0)
                            .withOpacity(0.3),
                      ],
              ),
          )
          ..drawPath(
            sPath,
            Paint()
              ..color = isWarning ? Colors.red : Colors.orange
              ..isAntiAlias = true
              ..strokeCap = StrokeCap.square
              ..style = PaintingStyle.stroke
              ..strokeWidth = 1,
          );
      }
      // Pwave
      if (travel.pDistance != null) {
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
            ..color = Colors.blueAccent
            ..isAntiAlias = true
            ..strokeCap = StrokeCap.square
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant _HypocenterPainter oldDelegate) => true;
}

enum _HypocenterType {
  normal,
  lowPrecise,
  ;
}

class _HypoWithTravelTime {
  _HypoWithTravelTime({
    required this.globalPoint,
    required this.result,
  });

  final GlobalPoint? globalPoint;
  final TravelTimeResult result;
}
