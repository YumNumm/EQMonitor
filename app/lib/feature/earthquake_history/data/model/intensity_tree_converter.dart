import 'package:collection/collection.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/core/provider/jma_parameter/jma_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_tree.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/lpgm_intensity_tree.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'intensity_tree_converter.g.dart';

@Riverpod(keepAlive: true)
Future<IntensityTreeConverter> intensityTreeConverter(Ref ref) async {
  final jmaParam = await ref.watch(jmaParameterProvider.future);
  return IntensityTreeConverter(
    parameter: jmaParam.earthquake,
  );
}

class IntensityTreeConverter {
  const IntensityTreeConverter({
    required this.parameter,
  });

  final EarthquakeParameter parameter;

  Map<JmaIntensity, List<PrefectureIntensityNode>> convertToIntensityTree({
    required api.Intensity intensity,
  }) {
    final apiTree = intensity.intensityTree;

    final tree = <JmaIntensity, List<PrefectureIntensityNode>>{};
    for (final entry in apiTree) {
      final entryIntensity = entry.intensity.toJmaIntensity;
      for (final station in stations) {
      }
    }
  }

  Map<JmaLpgmIntensity, List<PrefectureLpgmIntensityNode>>
  convertToLpgmIntensityTree({
    required api.Intensity intensity,
  }) {
    final trees = intensity.lpgmIntensityTree;
    if (trees == null || trees.isEmpty) {
      return {};
    }

    final cityPrefixToCityCode = _cityIdentificationPrefixMap();
    final stationParam = _stationParamMap();
    final stationCityCode = _stationCityCodeMap();

    final result = <JmaLpgmIntensity, List<PrefectureLpgmIntensityNode>>{};

    for (final tree in trees) {
      final lpgm = tree.lpgmIntensity.toJmaLpgmIntensity;
      final prefecturesByCode = _buildLpgmPrefectureCityStations(
        tree: tree,
        cityPrefixToCityCode: cityPrefixToCityCode,
        stationCityCode: stationCityCode,
      );
      if (prefecturesByCode.isEmpty) {
        continue;
      }

      final nodes = _toPrefectureLpgmIntensityNodes(
        prefecturesByCode: prefecturesByCode,
        tree: tree,
        stationParam: stationParam,
        levelLpgm: lpgm,
      );
      final existing = result[lpgm];
      result[lpgm] = existing == null
          ? nodes
          : _mergePrefectureLpgmIntensityNodeLists(existing, nodes);
    }

    return Map.fromEntries(
      result.entries.toList()
        ..sort((a, b) => b.key.orderIndex.compareTo(a.key.orderIndex)),
    );
  }
}
