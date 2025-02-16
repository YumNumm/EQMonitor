import 'package:eqmonitor/gen/assets.gen.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kyoshin_monitor_image_parser/kyoshin_monitor_image_parser.dart';
import 'package:kyoshin_observation_point_types/kyoshin_observation_point.pb.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'kyoshin_observation_points_provider.g.dart';

@Riverpod(keepAlive: true)
List<KyoshinMonitorObservationPoint>
kyoshinMonitorObservationPoints(Ref ref) =>
    ref
        .watch(
          kyoshinMonitorInternalObservationPointsConvertedProvider,
        )
        .requireValue;

@Riverpod(keepAlive: true)
Future<List<KyoshinMonitorObservationPoint>>
kyoshinMonitorInternalObservationPointsConverted(
  Ref ref,
) async {
  final result = await ref.watch(
    kyoshinMonitorInternalObservationPointsProvider.future,
  );
  final points =
      result.points
          .map(
            (e) => KyoshinMonitorObservationPoint(
              code: e.code,
              x: e.point.x,
              y: e.point.y,
            ),
          )
          .toList();

  return points;
}

@Riverpod(keepAlive: true)
KyoshinObservationPoints kyoshinObservationPoints(
  Ref ref,
) =>
    ref
        .watch(
          kyoshinMonitorInternalObservationPointsProvider,
        )
        .requireValue;

@Riverpod(keepAlive: true)
Future<KyoshinObservationPoints>
kyoshinMonitorInternalObservationPoints(Ref ref) async {
  final binary = await rootBundle.load(
    Assets.kyoshinObservationPoint,
  );
  return KyoshinObservationPoints.fromBuffer(
    binary.buffer.asUint8List(),
  );
}
