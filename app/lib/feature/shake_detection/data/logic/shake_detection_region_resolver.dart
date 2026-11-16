import 'package:eqmonitor/feature/parameter/data/model/kyoshin/kyoshin_observation_points_parameter.dart';
import 'package:eqmonitor/feature/shake_detection/data/logic/shake_detection_grid_cell_builder.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_event.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_region_summary.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'shake_detection_region_resolver.g.dart';

@riverpod
ShakeDetectionRegionResolver shakeDetectionRegionResolver(Ref ref) =>
    ShakeDetectionRegionResolver();

class ShakeDetectionRegionResolver {
  /// 都道府県内の地域のうち、この割合以上で検知した場合に「全域」とする。
  ///
  /// 地域が 2・3 個の都道府県ではすべて、4 個では 3 個、5 個では 4 個が必要になる。
  /// 観測点の少ない離島の地域が 1 つ欠けるだけで全域にならない、という状態を避ける。
  static const wholePrefectureRatio = 0.75;

  /// 全域にならない都道府県で、名前を並べる地域の上限。超えた分は件数で示す。
  static const maxListedRegions = 3;

  /// 検知した都道府県がこの数以上になったら、地域の内訳を出さず地方単位にまとめる。
  ///
  /// 3 県までは 1 県 1 行で内訳を出してもカードが 3 行に収まる。
  static const groupingPrefectureCount = 4;

  /// 地方に属する都道府県のうち、この割合以上で検知した場合に地方名へまとめる。
  static const areaGroupingRatio = 2 / 3;

  /// 地方名へまとめるのに必要な、検知した都道府県の最小数。
  /// 1 県だけで地方名に置き換えると、範囲を広く見せすぎるため。
  static const areaGroupingMinimumPrefectures = 2;

  /// 緊急地震速報の地方予報区に合わせた、地方と都道府県コードの対応。
  static const areas = <({String name, List<String> prefectureCodes})>[
    (name: '北海道', prefectureCodes: ['01']),
    (name: '東北', prefectureCodes: ['02', '03', '04', '05', '06', '07']),
    (name: '関東', prefectureCodes: ['08', '09', '10', '11', '12', '13', '14']),
    (name: '北陸', prefectureCodes: ['15', '16', '17', '18']),
    (name: '甲信', prefectureCodes: ['19', '20']),
    (name: '東海', prefectureCodes: ['21', '22', '23', '24']),
    (name: '近畿', prefectureCodes: ['25', '26', '27', '28', '29', '30']),
    (name: '中国', prefectureCodes: ['31', '32', '33', '34', '35']),
    (name: '四国', prefectureCodes: ['36', '37', '38', '39']),
    (name: '九州', prefectureCodes: ['40', '41', '42', '43', '44', '45', '46']),
    (name: '沖縄', prefectureCodes: ['47']),
  ];

  final _levels = ShakeDetectionGridCellBuilder();

  /// イベントの最大レベルで揺れた観測点が属する範囲を要約する。
  ///
  /// 最大レベルの観測点を特定できない場合は、すべての観測点を対象にする。
  /// [stations] は地域の全体を知るために使う、検知対象のすべての観測点。
  ShakeDetectionRegionSummary resolve({
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
    final detected = <String, Set<String>>{};
    for (final point in peakPoints.isEmpty ? event.points : peakPoints) {
      final prefectureCode = point.prefectureCode;
      final regionCode = point.regionCode;
      if (prefectureCode == null ||
          regionCode == null ||
          !prefectureNames.containsKey(prefectureCode)) {
        continue;
      }
      (detected[prefectureCode] ??= {}).add(regionCode);
    }
    final prefectureCodes = detected.keys.toList()..sort();

    if (prefectureCodes.length >= groupingPrefectureCount) {
      return ShakeDetectionRegionSummary(
        isGrouped: true,
        entries: [
          for (final name in groupedNames(
            prefectureCodes: prefectureCodes,
            prefectureNames: prefectureNames,
          ))
            ShakeDetectionRegionEntry(name: name, detail: null),
        ],
      );
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
    return ShakeDetectionRegionSummary(
      isGrouped: false,
      entries: [
        for (final prefectureCode in prefectureCodes)
          if (prefectureNames[prefectureCode] case final prefectureName?)
            ShakeDetectionRegionEntry(
              name: prefectureName,
              detail: regionDetail(
                prefectureName: prefectureName,
                detectedRegionCodes: detected[prefectureCode] ?? const {},
                allRegionCodes: all[prefectureCode] ?? const {},
                regionNames: regionNames,
              ),
            ),
      ],
    );
  }

  /// 都道府県内の地域の内訳。地域が 1 つしかない都道府県では出さない。
  String? regionDetail({
    required String prefectureName,
    required Set<String> detectedRegionCodes,
    required Set<String> allRegionCodes,
    required Map<String, String> regionNames,
  }) {
    if (allRegionCodes.length <= 1) {
      return null;
    }
    final detectedCount = allRegionCodes
        .where(detectedRegionCodes.contains)
        .length;
    if (detectedCount / allRegionCodes.length >= wholePrefectureRatio) {
      return '全域';
    }
    final names = [
      for (final regionCode in detectedRegionCodes.toList()..sort())
        if (regionNames[regionCode] case final regionName?)
          regionName.startsWith(prefectureName) &&
                  regionName.length > prefectureName.length
              ? regionName.substring(prefectureName.length)
              : regionName,
    ];
    if (names.isEmpty) {
      return null;
    }
    final rest = names.length - maxListedRegions;
    return rest > 0
        ? '${names.take(maxListedRegions).join(' ')} ほか$rest地域'
        : names.join(' ');
  }

  /// 検知した都道府県を、地方名にまとめられるものはまとめて北から順に並べる。
  List<String> groupedNames({
    required List<String> prefectureCodes,
    required Map<String, String> prefectureNames,
  }) {
    final detected = prefectureCodes.toSet();
    final grouped = <String>{};
    final names = <String>[];
    for (final area in areas) {
      final detectedInArea = [
        for (final prefectureCode in area.prefectureCodes)
          if (detected.contains(prefectureCode)) prefectureCode,
      ];
      grouped.addAll(detectedInArea);
      if (detectedInArea.length >= areaGroupingMinimumPrefectures &&
          detectedInArea.length / area.prefectureCodes.length >=
              areaGroupingRatio) {
        names.add(area.name);
        continue;
      }
      for (final prefectureCode in detectedInArea) {
        if (prefectureNames[prefectureCode] case final prefectureName?) {
          names.add(prefectureName);
        }
      }
    }
    for (final prefectureCode in prefectureCodes) {
      if (!grouped.contains(prefectureCode)) {
        if (prefectureNames[prefectureCode] case final prefectureName?) {
          names.add(prefectureName);
        }
      }
    }
    return names;
  }
}
