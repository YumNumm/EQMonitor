import 'package:eqmonitor/feature/home/features/kmoni_observation_points/model/kmoni_observation_point.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'kmoni_observation_points_provider.g.dart';

@Riverpod(keepAlive: true)
List<KmoniObservationPoint> kmoniObservationPoints(
  KmoniObservationPointsRef ref,
) =>
    throw UnimplementedError();

Future<List<KmoniObservationPoint>> loadKmoniObservationPoints() async {
  if (kIsWeb) {
    return [];
  }
  final file = await rootBundle.loadString('assets/kmoni/kansokuten.csv');
  final lines = file.split('\n');
  final result = <KmoniObservationPoint>[];
  for (final line in lines) {
    try {
      result.add(
        KmoniObservationPoint.fromList(
          line.split(','),
        ),
      );
    } on Exception catch (_) {}
  }
  return result;
}
