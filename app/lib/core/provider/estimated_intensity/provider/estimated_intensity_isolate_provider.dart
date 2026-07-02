import 'package:eqmonitor/core/provider/estimated_intensity/data/estimated_intensity_station_index.dart';
import 'package:eqmonitor/core/provider/estimated_intensity/worker/estimated_intensity_isolate.dart';
import 'package:eqmonitor/core/provider/jma_parameter/jma_parameter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'estimated_intensity_isolate_provider.g.dart';

@Riverpod(keepAlive: true)
Future<EstimatedIntensityIsolate> estimatedIntensityIsolate(Ref ref) async {
  final stationIndex = await ref.watch(
    estimatedIntensityStationIndexProvider.future,
  );
  final isolate = await EstimatedIntensityIsolate.spawn(
    points: stationIndex.calculationPoints,
  );
  ref.onDispose(isolate.dispose);
  return isolate;
}

@Riverpod(keepAlive: true)
Future<EstimatedIntensityStationIndex> estimatedIntensityStationIndex(
  Ref ref,
) async {
  final parameter = await ref.watch(jmaParameterProvider.future);
  return EstimatedIntensityStationIndex.fromEarthquakeParameter(
    parameter.earthquake,
  );
}
