import 'package:eqmonitor/common/feature/map/utils/web_mercator_projection.dart';
import 'package:eqmonitor/feature/home/features/kmoni_observation_points/model/kmoni_observation_point.dart';
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'kmoni_obervation_points_data_source.g.dart';

@Riverpod(keepAlive: true)
KmoniObservationPointsDataSource kmoniObservationPointsDataSource(
  KmoniObservationPointsDataSourceRef ref,
) =>
    KmoniObservationPointsDataSource();

class KmoniObservationPointsDataSource {
  /// Assetから観測点情報を読み込む
  Future<List<KmoniObservationPoint>> load({
    String path = 'assets/kmoni/kansokuten.csv',
    WebMercatorProjection? projection,
  }) async {
    final file = await rootBundle.loadString(path);
    final lines = file.split('\n');
    final result = <KmoniObservationPoint>[];
    final defaultProjection = WebMercatorProjection();
    for (final line in lines) {
      try {
        result.add(
          KmoniObservationPoint.fromList(
            line.split(','),
            projection: projection ?? defaultProjection,
          ),
        );
      } on Exception catch (_) {}
    }
    return result;
  }
}
