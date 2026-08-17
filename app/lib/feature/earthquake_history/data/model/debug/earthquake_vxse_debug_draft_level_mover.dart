import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_tree.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/lpgm_intensity_tree.dart';

/// デバッグ編集画面のドロップダウンで、階級グループ間の項目移動を行う。
///
/// 移動元と移動先の階級が同じ場合を除き、移動先に既存の衝突があっても
/// 上書きしない。重複コードの拒否は [EarthquakeVxseDebugDraftValidator] の
/// 責務であり、ここでは既存データを黙って破棄しない。
class EarthquakeVxseDebugDraftLevelMover {
  const EarthquakeVxseDebugDraftLevelMover();

  Map<JmaIntensity, List<IntensityRegion>> moveIntensityRegionLevel({
    required Map<JmaIntensity, List<IntensityRegion>> source,
    required JmaIntensity from,
    required int index,
    required JmaIntensity to,
  }) {
    final fromList = source[from];
    final node = fromList?[index];
    if (fromList == null || node == null) {
      return source;
    }
    return {
      for (final entry in source.entries)
        if (entry.key != from && entry.key != to) entry.key: entry.value,
      if (from != to && fromList.length > 1)
        from: [
          for (final (currentIndex, current) in fromList.indexed)
            if (currentIndex != index) current,
        ],
      to: [
        if (to != from) ...source[to] ?? const [],
        node.copyWith(maxIntensity: to),
        if (to == from)
          for (final (currentIndex, current) in fromList.indexed)
            if (currentIndex != index) current,
      ],
    };
  }

  Map<JmaLpgmIntensity, List<LpgmIntensityRegion>> moveLpgmRegionLevel({
    required Map<JmaLpgmIntensity, List<LpgmIntensityRegion>> source,
    required JmaLpgmIntensity from,
    required int index,
    required JmaLpgmIntensity to,
  }) {
    final fromList = source[from];
    final node = fromList?[index];
    if (fromList == null || node == null) {
      return source;
    }
    return {
      for (final entry in source.entries)
        if (entry.key != from && entry.key != to) entry.key: entry.value,
      if (from != to && fromList.length > 1)
        from: [
          for (final (currentIndex, current) in fromList.indexed)
            if (currentIndex != index) current,
        ],
      to: [
        if (to != from) ...source[to] ?? const [],
        node.copyWith(maxLpgmIntensity: to),
        if (to == from)
          for (final (currentIndex, current) in fromList.indexed)
            if (currentIndex != index) current,
      ],
    };
  }

  Map<JmaIntensity, List<IntensityPrefecture>> moveIntensityPrefectureLevel({
    required Map<JmaIntensity, List<IntensityPrefecture>> source,
    required JmaIntensity from,
    required int index,
    required JmaIntensity to,
  }) {
    final fromList = source[from];
    final node = fromList?[index];
    if (fromList == null || node == null) {
      return source;
    }
    return {
      for (final entry in source.entries)
        if (entry.key != from && entry.key != to) entry.key: entry.value,
      if (from != to && fromList.length > 1)
        from: [
          for (final (currentIndex, current) in fromList.indexed)
            if (currentIndex != index) current,
        ],
      to: [
        if (to != from) ...source[to] ?? const [],
        node.copyWith(maxIntensity: to),
        if (to == from)
          for (final (currentIndex, current) in fromList.indexed)
            if (currentIndex != index) current,
      ],
    };
  }

  Map<JmaIntensity, List<PrefectureIntensityNode>>
  moveIntensityTreePrefectureLevel({
    required Map<JmaIntensity, List<PrefectureIntensityNode>> source,
    required JmaIntensity from,
    required int index,
    required JmaIntensity to,
  }) {
    final fromList = source[from];
    final node = fromList?[index];
    if (fromList == null || node == null) {
      return source;
    }
    return {
      for (final entry in source.entries)
        if (entry.key != from && entry.key != to) entry.key: entry.value,
      if (from != to && fromList.length > 1)
        from: [
          for (final (currentIndex, current) in fromList.indexed)
            if (currentIndex != index) current,
        ],
      to: [
        if (to != from) ...source[to] ?? const [],
        node.copyWith(prefecture: node.prefecture.copyWith(maxIntensity: to)),
        if (to == from)
          for (final (currentIndex, current) in fromList.indexed)
            if (currentIndex != index) current,
      ],
    };
  }

  Map<JmaLpgmIntensity, List<PrefectureLpgmIntensityNode>>
  moveLpgmPrefectureLevel({
    required Map<JmaLpgmIntensity, List<PrefectureLpgmIntensityNode>> source,
    required JmaLpgmIntensity from,
    required int index,
    required JmaLpgmIntensity to,
  }) {
    final fromList = source[from];
    final node = fromList?[index];
    if (fromList == null || node == null) {
      return source;
    }
    return {
      for (final entry in source.entries)
        if (entry.key != from && entry.key != to) entry.key: entry.value,
      if (from != to && fromList.length > 1)
        from: [
          for (final (currentIndex, current) in fromList.indexed)
            if (currentIndex != index) current,
        ],
      to: [
        if (to != from) ...source[to] ?? const [],
        node.copyWith(maxLpgmIntensity: to),
        if (to == from)
          for (final (currentIndex, current) in fromList.indexed)
            if (currentIndex != index) current,
      ],
    };
  }
}
