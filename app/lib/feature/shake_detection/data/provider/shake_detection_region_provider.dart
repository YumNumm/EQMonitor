import 'package:eqmonitor/core/provider/jma_parameter/jma_parameter.dart';
import 'package:eqmonitor/core/provider/kmoni_observation_points/provider/kyoshin_observation_points_provider.dart';
import 'package:eqmonitor/feature/shake_detection/data/logic/shake_detection_region_resolver.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_event.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_region_catalog.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_region_summary.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'shake_detection_region_provider.g.dart';

@Riverpod(keepAlive: true)
Future<ShakeDetectionRegionCatalog> shakeDetectionRegionCatalog(Ref ref) async {
  final stations = await ref.watch(
    kyoshinImageObservationPointsProvider.future,
  );
  final earthquake = (await ref.watch(jmaParameterProvider.future)).earthquake;
  return ShakeDetectionRegionCatalog(
    stations: stations,
    prefectureNames: {
      for (final prefecture in earthquake.prefectures)
        prefecture.code: prefecture.name.ja,
    },
    regionNames: {
      for (final prefecture in earthquake.prefectures)
        for (final region in prefecture.regions) region.code: region.name.ja,
    },
  );
}

/// 揺れ検知イベントの最大レベルで揺れた範囲の要約。
///
/// 観測点の地域コードは地震情報の細分区域で、名前は震度観測点のパラメータから引く。
@riverpod
ShakeDetectionRegionSummary? shakeDetectionEventRegions(
  Ref ref,
  ShakeDetectionEvent event,
) {
  final catalog = ref.watch(shakeDetectionRegionCatalogProvider).value;
  if (catalog == null) {
    return null;
  }
  return ref
      .watch(shakeDetectionRegionResolverProvider)
      .resolve(
        event: event,
        stations: catalog.stations,
        prefectureNames: catalog.prefectureNames,
        regionNames: catalog.regionNames,
      );
}
