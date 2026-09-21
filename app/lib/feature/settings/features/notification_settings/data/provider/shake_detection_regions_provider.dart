import 'package:eqmonitor/feature/parameter/data/model/earthquake/earthquake_parameter.dart';
import 'package:eqmonitor/feature/parameter/data/notifier/parameter_set_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'shake_detection_regions_provider.g.dart';

@Riverpod(keepAlive: true)
Future<List<EarthquakeParameterPrefectureItem>> shakeDetectionRegions(
  Ref ref,
) async =>
    (await ref.watch(parameterSetProvider.future)).earthquake.prefectures;
