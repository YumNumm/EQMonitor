import 'package:eqmonitor/core/provider/kmoni_observation_points/provider/kyoshin_observation_points_provider.dart';
import 'package:kyoshin_monitor_image_parser/kyoshin_monitor_image_parser.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'kyoshin_monitor_analyzer_isolate_provider.g.dart';

@Riverpod(keepAlive: true)
Future<KyoshinMonitorAnalyzerIsolate> kyoshinMonitorAnalyzerIsolate(
  Ref ref,
) async {
  final named = await ref.watch(kyoshinNamedObservationPointsProvider.future);
  final analyzer = await KyoshinMonitorAnalyzerIsolate.spawn(points: named);
  ref.onDispose(analyzer.dispose);
  return analyzer;
}
