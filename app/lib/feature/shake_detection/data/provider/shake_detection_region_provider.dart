import 'package:eqmonitor/core/provider/jma_code_table_provider.dart';
import 'package:eqmonitor/core/provider/kmoni_observation_points/provider/kyoshin_observation_points_provider.dart';
import 'package:eqmonitor/feature/shake_detection/data/logic/shake_detection_region_resolver.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_event.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_region_group.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'shake_detection_region_provider.g.dart';

/// 揺れ検知イベントの最大レベルで揺れた都道府県と地域。
@riverpod
Future<List<ShakeDetectionRegionGroup>> shakeDetectionEventRegions(
  Ref ref,
  ShakeDetectionEvent event,
) async {
  final stations = await ref.watch(
    kyoshinImageObservationPointsProvider.future,
  );
  final codeTable = await ref.watch(jmaCodeTableProvider.future);
  return ref
      .watch(shakeDetectionRegionResolverProvider)
      .resolve(
        event: event,
        stations: stations,
        prefectureNames: {
          for (final item
              in codeTable.codeTables.areaInformationPrefectureEarthquake)
            item.code: item.name.ja,
        },
        regionNames: {
          for (final item in codeTable.codeTables.areaForecastLocalEew)
            item.code: item.name.ja,
        },
      );
}
