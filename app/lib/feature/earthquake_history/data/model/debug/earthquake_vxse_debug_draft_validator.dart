import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/debug/earthquake_vxse_debug_draft.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/debug/earthquake_vxse_debug_reducer.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_telegram_type.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_tree.dart';

/// [EarthquakeVxseDebugEditorController] の編集中ドラフトを検証する。
class EarthquakeVxseDebugDraftValidator {
  const new();

  EarthquakeTelegramType initialType({required Earthquake current}) {
    const supported = {
      EarthquakeTelegramType.vxse51,
      EarthquakeTelegramType.vxse52,
      EarthquakeTelegramType.vxse53,
      EarthquakeTelegramType.vxse61,
      EarthquakeTelegramType.vxse62,
    };
    return current.telegramTypes.where(supported.contains).lastOrNull ??
        EarthquakeTelegramType.vxse53;
  }

  String? validate({
    required Earthquake current,
    required EarthquakeTelegramType selectedType,
    required EarthquakeVxseDebugDraft draft,
  }) {
    const reducer = EarthquakeVxseDebugReducer();
    if (reducer.earthquakeVxseDraftTelegramType(draft: draft) != selectedType) {
      return '選択中の電文種類と一致しません';
    }
    if (draft.eventId != current.eventId) {
      return '現在の地震とevent IDが一致しません';
    }
    if (hasDuplicateGroupedCodes(draft: draft)) {
      return '同じコードの階級項目が重複しています';
    }
    if (reducer
        .validateEarthquakeVxseDebugDraft(draft: draft, type: selectedType)
        .isNotEmpty) {
      return '入力内容の関連付けが正しくありません';
    }
    if (!hasConsistentGroupLevels(draft: draft)) {
      return '階級グループと項目の階級が一致しません';
    }
    return null;
  }

  bool hasDuplicateGroupedCodes({required EarthquakeVxseDebugDraft draft}) {
    final ordinaryRegionCodes = <String>{};
    final ordinaryRegions = switch (draft) {
      EarthquakeVxse51DebugDraft(:final regions) ||
      EarthquakeVxse53DebugDraft(:final regions) ||
      EarthquakeVxse62DebugDraft(:final regions) => regions,
      _ => const <JmaIntensity, List<IntensityRegion>>{},
    };
    for (final node in ordinaryRegions.values.expand((nodes) => nodes)) {
      if (!ordinaryRegionCodes.add(node.region.code)) {
        return true;
      }
    }
    final ordinaryPrefectureCodes = <String>{};
    final ordinaryPrefectures = switch (draft) {
      EarthquakeVxse51DebugDraft(:final prefectures) =>
        prefectures.values
            .expand((nodes) => nodes)
            .map((node) => node.prefecture.code),
      EarthquakeVxse53DebugDraft(:final intensityTree) ||
      EarthquakeVxse62DebugDraft(:final intensityTree) =>
        intensityTree.values
            .expand((nodes) => nodes)
            .map((node) => node.prefecture.prefecture.code),
      _ => const <String>[],
    };
    for (final code in ordinaryPrefectures) {
      if (!ordinaryPrefectureCodes.add(code)) {
        return true;
      }
    }
    if (draft case EarthquakeVxse62DebugDraft(
      :final lpgmRegions,
      :final lpgmIntensityTree,
    )) {
      final lpgmRegionCodes = <String>{};
      for (final node in lpgmRegions.values.expand((nodes) => nodes)) {
        if (!lpgmRegionCodes.add(node.region.code)) {
          return true;
        }
      }
      final lpgmPrefectureCodes = <String>{};
      for (final node in lpgmIntensityTree.values.expand((nodes) => nodes)) {
        if (!lpgmPrefectureCodes.add(node.region.code)) {
          return true;
        }
      }
    }
    return false;
  }

  bool hasConsistentGroupLevels({required EarthquakeVxseDebugDraft draft}) {
    final regions = switch (draft) {
      EarthquakeVxse51DebugDraft(:final regions) ||
      EarthquakeVxse53DebugDraft(:final regions) ||
      EarthquakeVxse62DebugDraft(:final regions) => regions,
      _ => const <JmaIntensity, List<IntensityRegion>>{},
    };
    if (regions.entries.any(
      (entry) => entry.value.any(
        (node) => node.maxIntensity != null && node.maxIntensity != entry.key,
      ),
    )) {
      return false;
    }
    final ordinaryTree = switch (draft) {
      EarthquakeVxse53DebugDraft(:final intensityTree) ||
      EarthquakeVxse62DebugDraft(:final intensityTree) => intensityTree,
      _ => const <JmaIntensity, List<PrefectureIntensityNode>>{},
    };
    if (ordinaryTree.entries.any(
      (entry) => entry.value.any(
        (node) =>
            node.prefecture.maxIntensity != null &&
            node.prefecture.maxIntensity != entry.key,
      ),
    )) {
      return false;
    }
    if (draft case EarthquakeVxse51DebugDraft(:final prefectures)) {
      if (prefectures.entries.any(
        (entry) => entry.value.any(
          (node) => node.maxIntensity != null && node.maxIntensity != entry.key,
        ),
      )) {
        return false;
      }
    }
    if (draft case EarthquakeVxse62DebugDraft(
      :final lpgmRegions,
      :final lpgmIntensityTree,
    )) {
      if (lpgmRegions.entries.any(
            (entry) => entry.value.any(
              (node) =>
                  node.maxLpgmIntensity != null &&
                  node.maxLpgmIntensity != entry.key,
            ),
          ) ||
          lpgmIntensityTree.entries.any(
            (entry) => entry.value.any(
              (node) =>
                  node.maxLpgmIntensity != null &&
                  node.maxLpgmIntensity != entry.key,
            ),
          )) {
        return false;
      }
    }
    return true;
  }
}
