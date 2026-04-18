import 'package:eqmonitor/core/gen/assets.gen.dart';
import 'package:flutter/services.dart';
import 'package:kyoshin_monitor_image_parser/kyoshin_monitor_image_parser.dart';
import 'package:kyoshin_observation_point_types/kyoshin_observation_point.pb.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'kyoshin_observation_points_provider.g.dart';

@Riverpod(keepAlive: true)
Future<List<KyoshinMonitorObservationPoint>> kyoshinMonitorObservationPoints(
  Ref ref,
) async =>
    ref.watch(kyoshinMonitorInternalObservationPointsConvertedProvider.future);

@Riverpod(keepAlive: true)
Future<List<KyoshinMonitorObservationPoint>>
kyoshinMonitorInternalObservationPointsConverted(Ref ref) async {
  final result = await ref.watch(
    kyoshinMonitorInternalObservationPointsProvider.future,
  );
  final points = result.points
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
Future<KyoshinObservationPoints> kyoshinObservationPoints(Ref ref) async =>
    ref.watch(kyoshinMonitorInternalObservationPointsProvider.future);

/// protobuf の観測点を GeoJSON 生成用の純 Dart 型へ変換（Worker Isolate 境界用）。
@Riverpod(keepAlive: true)
Future<List<NamedObservationPoint>> kyoshinNamedObservationPoints(Ref ref) async {
  final protobuf = await ref.watch(kyoshinObservationPointsProvider.future);
  return protobuf.points
      .map(
        (p) => NamedObservationPoint(
          code: p.code,
          name: p.name,
          latitude: p.location.latitude,
          longitude: p.location.longitude,
          x: p.point.x,
          y: p.point.y,
        ),
      )
      .toList();
}

@Riverpod(keepAlive: true)
Future<KyoshinObservationPoints> kyoshinMonitorInternalObservationPoints(
  Ref ref,
) async {
  final binary = await rootBundle.load(Assets.kyoshinObservationPoint);
  return KyoshinObservationPoints.fromBuffer(binary.buffer.asUint8List());
}
