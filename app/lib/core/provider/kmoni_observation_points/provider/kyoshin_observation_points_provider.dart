import 'package:eqmonitor/feature/parameter/data/model/parameter.dart';
import 'package:eqmonitor/feature/parameter/data/notifier/parameter_set_notifier.dart';
import 'package:kyoshin_monitor_image_parser/kyoshin_monitor_image_parser.dart';
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
  final points = <KyoshinMonitorObservationPoint>[];
  for (final point in result.points) {
    final mapPoint = point.point;
    if (mapPoint == null) {
      continue;
    }
    points.add(
      KyoshinMonitorObservationPoint(
        code: point.code,
        x: mapPoint.center.x.toInt(),
        y: mapPoint.center.y.toInt(),
      ),
    );
  }

  return points;
}

@Riverpod(keepAlive: true)
Future<KyoshinObservationPointsParameter> kyoshinObservationPoints(
  Ref ref,
) async => ref.watch(kyoshinMonitorInternalObservationPointsProvider.future);

/// protobuf の観測点を GeoJSON 生成用の純 Dart 型へ変換（Worker Isolate 境界用）。
@Riverpod(keepAlive: true)
Future<List<NamedObservationPoint>> kyoshinNamedObservationPoints(
  Ref ref,
) async {
  final imagePoints = await ref.watch(
    kyoshinImageObservationPointsProvider.future,
  );
  final points = <NamedObservationPoint>[];
  for (final point in imagePoints) {
    final mapPoint = point.point;
    if (mapPoint == null) {
      continue;
    }
    points.add(
      NamedObservationPoint(
        code: point.code,
        name: point.name,
        latitude: point.location.lat,
        longitude: point.location.lon,
        x: mapPoint.center.x.toInt(),
        y: mapPoint.center.y.toInt(),
      ),
    );
  }
  return points;
}

/// 画像上の座標を持つ観測点。解析用 Isolate に渡す観測点と同じ並びで、
/// 揺れ検知の観測点インデックスはこの並びを指す。
@Riverpod(keepAlive: true)
Future<List<KyoshinObservationPoint>> kyoshinImageObservationPoints(
  Ref ref,
) async {
  final parameter = await ref.watch(kyoshinObservationPointsProvider.future);
  return [
    for (final point in parameter.points)
      if (point.point != null) point,
  ];
}

@Riverpod(keepAlive: true)
Future<KyoshinObservationPointsParameter>
kyoshinMonitorInternalObservationPoints(
  Ref ref,
) async =>
    (await ref.watch(parameterSetProvider.future)).kyoshinObservationPoints;
