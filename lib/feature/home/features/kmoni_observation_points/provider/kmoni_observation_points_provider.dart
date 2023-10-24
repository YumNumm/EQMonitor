import 'package:eqmonitor/core/component/map/utils/web_mercator_projection.dart';
import 'package:eqmonitor/feature/home/features/kmoni_observation_points/model/kmoni_observation_point.dart';
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'kmoni_observation_points_provider.g.dart';

@Riverpod(keepAlive: true)
List<KmoniObservationPoint> kmoniObservationPoints(
  KmoniObservationPointsRef ref,
) =>
    throw UnimplementedError();

Future<List<KmoniObservationPoint>> loadKmoniObservationPoints() async {
  final file = await rootBundle.loadString('assets/kmoni/kansokuten.csv');
  final lines = file.split('\n');
  final result = <KmoniObservationPoint>[];
  final defaultProjection = WebMercatorProjection();
  for (final line in lines) {
    try {
      result.add(
        KmoniObservationPoint.fromList(
          line.split(','),
          projection: defaultProjection,
        ),
      );
    } on Exception catch (_) {}
  }
  return result;
}
