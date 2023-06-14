import 'package:eqmonitor/feature/home/features/kmoni_observation_points/data/kmoni_obervation_points_data_source.dart';
import 'package:eqmonitor/feature/home/features/kmoni_observation_points/model/kmoni_observation_point.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'kmoni_observation_points_provider.g.dart';

@Riverpod(keepAlive: true)
Future<List<KmoniObservationPoint>> kmoniObservationPoints(
  KmoniObservationPointsRef ref,
) async {
  final dataSource = ref.read(kmoniObservationPointsDataSourceProvider);
  return dataSource.load();
}
