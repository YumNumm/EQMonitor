import 'package:eqmonitor/gen/assets.gen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:kyoshin_observation_point_types/kyoshin_observation_point.pb.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'kyoshin_observation_points_provider.g.dart';

@Riverpod(keepAlive: true)
KyoshinObservationPoints kyoshinObservationPoints(
  KyoshinObservationPointsRef ref,
) =>
    throw UnimplementedError();

Future<KyoshinObservationPoints> loadKmoniObservationPoints() async {
  if (kIsWeb) {
    return KyoshinObservationPoints(points: []);
  }
  final binary = await rootBundle.load(Assets.kyoshinObservationPoint);
  final result =
      KyoshinObservationPoints.fromBuffer(binary.buffer.asUint8List());
  return result;
}
