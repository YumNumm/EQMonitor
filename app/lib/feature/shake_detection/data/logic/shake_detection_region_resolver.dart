import 'package:eqmonitor/feature/parameter/data/model/kyoshin/kyoshin_observation_points_parameter.dart';
import 'package:eqmonitor/feature/shake_detection/data/logic/shake_detection_grid_cell_builder.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_event.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_region_group.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'shake_detection_region_resolver.g.dart';

@riverpod
ShakeDetectionRegionResolver shakeDetectionRegionResolver(Ref ref) =>
    ShakeDetectionRegionResolver();

class ShakeDetectionRegionResolver {
  final _levels = ShakeDetectionGridCellBuilder();

  /// イベントの最大レベルで揺れた観測点が属する都道府県と地域を返す。
  ///
  /// 最大レベルの観測点を特定できない場合は、すべての観測点を対象にする。
  /// [stations] は地域の全体を知るために使う、検知対象のすべての観測点。
  List<ShakeDetectionRegionGroup> resolve({
    required ShakeDetectionEvent event,
    required List<KyoshinObservationPoint> stations,
    required Map<String, String> prefectureNames,
    required Map<String, String> regionNames,
  }) {
    final peakPoints = [
      for (final point in event.points)
        if (point.intensity case final intensity?)
          if (_levels.levelFromIntensity(intensity).index >= event.level.index)
            point,
    ];
    final targets = peakPoints.isEmpty ? event.points : peakPoints;

    final detected = <String, Set<String>>{};
    for (final point in targets) {
      final prefectureCode = point.prefectureCode;
      final regionCode = point.regionCode;
      if (prefectureCode == null || regionCode == null) {
        continue;
      }
      (detected[prefectureCode] ??= {}).add(regionCode);
    }

    final all = <String, Set<String>>{};
    for (final station in stations) {
      final prefectureCode = station.prefectureCode;
      final regionCode = station.regionCode;
      if (prefectureCode == null || regionCode == null) {
        continue;
      }
      (all[prefectureCode] ??= {}).add(regionCode);
    }

    final prefectureCodes = detected.keys.toList()..sort();
    return [
      for (final prefectureCode in prefectureCodes)
        if (prefectureNames[prefectureCode] case final prefectureName?)
          ShakeDetectionRegionGroup(
            prefectureCode: prefectureCode,
            prefectureName: prefectureName,
            regionNames: [
              for (final regionCode
                  in (detected[prefectureCode] ?? const {}).toList()..sort())
                if (regionNames[regionCode] case final regionName?)
                  regionName.startsWith(prefectureName) &&
                          regionName.length > prefectureName.length
                      ? regionName.substring(prefectureName.length)
                      : regionName,
            ],
            isWholePrefecture: (all[prefectureCode] ?? const {}).every(
              (detected[prefectureCode] ?? const {}).contains,
            ),
          ),
    ];
  }
}
