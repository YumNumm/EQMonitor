import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/debug/earthquake_vxse_apply_mode.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/debug/earthquake_vxse_debug_draft.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/debug/earthquake_vxse_field_ownership.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_intensity.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_telegram_comment.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_telegram_type.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_tree.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/lpgm_intensity_tree.dart';

class EarthquakeVxseDebugReducer {
  const EarthquakeVxseDebugReducer();

  Earthquake apply({
    required Earthquake current,
    required EarthquakeVxseDebugDraft draft,
    required EarthquakeVxseApplyMode mode,
  }) {
    final type = earthquakeVxseDraftTelegramType(draft: draft);
    final base = switch (mode) {
      .merge => current,
      .clearAndApply => clearEarthquakeVxseOwnedFields(
        current: current,
        type: type,
      ),
    };
    return mergeEarthquakeVxseDraft(current: base, draft: draft, type: type);
  }
}

EarthquakeTelegramType earthquakeVxseDraftTelegramType({
  required EarthquakeVxseDebugDraft draft,
}) => switch (draft) {
  EarthquakeVxse51DebugDraft() => .vxse51,
  EarthquakeVxse52DebugDraft() => .vxse52,
  EarthquakeVxse53DebugDraft() => .vxse53,
  EarthquakeVxse61DebugDraft() => .vxse61,
  EarthquakeVxse62DebugDraft() => .vxse62,
};

Earthquake clearEarthquakeVxseOwnedFields({
  required Earthquake current,
  required EarthquakeTelegramType type,
}) {
  final ownership = EarthquakeVxseFieldOwnership.forType(type);
  return current.copyWith(
    originTime: ownership.owns(EarthquakeVxseOwnedField.originTime)
        ? null
        : current.originTime,
    arrivalTime: ownership.owns(EarthquakeVxseOwnedField.arrivalTime)
        ? null
        : current.arrivalTime,
    hypocenter: ownership.owns(EarthquakeVxseOwnedField.hypocenter)
        ? null
        : current.hypocenter,
    earthquakeType: ownership.owns(EarthquakeVxseOwnedField.earthquakeType)
        ? null
        : current.earthquakeType,
    telegramComments: ownership.owns(EarthquakeVxseOwnedField.comments)
        ? current.telegramComments
              .where((comment) => comment.type != type)
              .toList()
        : current.telegramComments,
    intensity: clearEarthquakeVxseOwnedIntensity(
      intensity: current.intensity,
      ownership: ownership,
    ),
  );
}

EarthquakeIntensity? clearEarthquakeVxseOwnedIntensity({
  required EarthquakeIntensity? intensity,
  required EarthquakeVxseFieldOwnership ownership,
}) {
  if (intensity == null) {
    return null;
  }
  return intensity.copyWith(
    maxLpgmIntensity: ownership.owns(EarthquakeVxseOwnedField.maxLpgmIntensity)
        ? null
        : intensity.maxLpgmIntensity,
    regions: ownership.owns(EarthquakeVxseOwnedField.intensityRegions)
        ? const {}
        : intensity.regions,
    intensityTree: clearOwnedOrdinaryIntensityTree(
      tree: intensity.intensityTree,
      ownership: ownership,
    ),
    lpgmIntensityTree:
        ownership.owns(EarthquakeVxseOwnedField.lpgmRegions) ||
            ownership.owns(EarthquakeVxseOwnedField.lpgmPrefectures) ||
            ownership.owns(EarthquakeVxseOwnedField.lpgmStations)
        ? clearOwnedLpgmIntensityTree(
            tree: intensity.lpgmIntensityTree,
            ownership: ownership,
          )
        : intensity.lpgmIntensityTree,
  );
}

Map<JmaIntensity, List<PrefectureIntensityNode>>
clearOwnedOrdinaryIntensityTree({
  required Map<JmaIntensity, List<PrefectureIntensityNode>> tree,
  required EarthquakeVxseFieldOwnership ownership,
}) {
  if (ownership.owns(EarthquakeVxseOwnedField.intensityCities)) {
    return const {};
  }
  return {
    for (final entry in tree.entries)
      entry.key: [
        for (final node in entry.value)
          node.copyWith(
            prefecture:
                ownership.owns(EarthquakeVxseOwnedField.intensityPrefectures)
                ? node.prefecture.copyWith(maxIntensity: null)
                : node.prefecture,
            cities: [
              for (final city in node.cities)
                city.copyWith(
                  stations:
                      ownership.owns(EarthquakeVxseOwnedField.intensityStations)
                      ? const []
                      : city.stations,
                ),
            ],
          ),
      ],
  };
}

Map<JmaLpgmIntensity, List<PrefectureLpgmIntensityNode>>
clearOwnedLpgmIntensityTree({
  required Map<JmaLpgmIntensity, List<PrefectureLpgmIntensityNode>> tree,
  required EarthquakeVxseFieldOwnership ownership,
}) => {
  for (final entry in tree.entries)
    entry.key: [
      for (final node in entry.value)
        node.copyWith(
          maxLpgmIntensity:
              ownership.owns(EarthquakeVxseOwnedField.lpgmRegions) ||
                  ownership.owns(EarthquakeVxseOwnedField.lpgmPrefectures)
              ? null
              : node.maxLpgmIntensity,
          cities: [
            for (final city in node.cities)
              city.copyWith(
                stations: ownership.owns(EarthquakeVxseOwnedField.lpgmStations)
                    ? const []
                    : city.stations,
              ),
          ],
        ),
    ],
};

Earthquake mergeEarthquakeVxseDraft({
  required Earthquake current,
  required EarthquakeVxseDebugDraft draft,
  required EarthquakeTelegramType type,
}) {
  final telegramTypes = mergeEarthquakeTelegramTypes(
    current: current.telegramTypes,
    type: type,
  );
  final comments = upsertEarthquakeTelegramComments(
    current: current.telegramComments,
    updates: draft.comments,
  );
  return switch (draft) {
    EarthquakeVxse51DebugDraft() => current.copyWith(
      status: draft.status,
      telegramTypes: telegramTypes,
      telegramComments: comments,
      intensity: applyVxse51Intensity(current: current.intensity, draft: draft),
    ),
    EarthquakeVxse52DebugDraft() => current.copyWith(
      status: draft.status,
      originTime: draft.originTime,
      arrivalTime: draft.arrivalTime,
      hypocenter: draft.hypocenter,
      telegramTypes: telegramTypes,
      telegramComments: comments,
    ),
    EarthquakeVxse53DebugDraft() => current.copyWith(
      status: draft.status,
      originTime: draft.originTime,
      arrivalTime: draft.arrivalTime,
      hypocenter: draft.hypocenter,
      earthquakeType: draft.earthquakeType,
      telegramTypes: telegramTypes,
      telegramComments: comments,
      intensity: applyVxse53Intensity(current: current.intensity, draft: draft),
    ),
    EarthquakeVxse61DebugDraft() => current.copyWith(
      status: draft.status,
      originTime: draft.originTime,
      arrivalTime: draft.arrivalTime,
      hypocenter: draft.hypocenter,
      telegramTypes: telegramTypes,
      telegramComments: comments,
    ),
    EarthquakeVxse62DebugDraft() => current.copyWith(
      status: draft.status,
      originTime: draft.originTime,
      arrivalTime: draft.arrivalTime,
      hypocenter: draft.hypocenter,
      telegramTypes: telegramTypes,
      telegramComments: comments,
      intensity: applyVxse62Intensity(current: current.intensity, draft: draft),
    ),
  };
}

List<EarthquakeTelegramType> mergeEarthquakeTelegramTypes({
  required List<EarthquakeTelegramType> current,
  required EarthquakeTelegramType type,
}) => [
  ...{...current, type},
];

List<EarthquakeTelegramComment> upsertEarthquakeTelegramComments({
  required List<EarthquakeTelegramComment> current,
  required List<EarthquakeTelegramComment> updates,
}) {
  final updatesByKey = {
    for (final comment in updates) (comment.type, comment.reportedAt): comment,
  };
  final preservedByKey =
      <(EarthquakeTelegramType, DateTime), EarthquakeTelegramComment>{};
  for (final comment in current) {
    final key = (comment.type, comment.reportedAt);
    if (!updatesByKey.containsKey(key)) {
      preservedByKey[key] = comment;
    }
  }
  return [...preservedByKey.values, ...updatesByKey.values];
}

EarthquakeIntensity applyVxse51Intensity({
  required EarthquakeIntensity? current,
  required EarthquakeVxse51DebugDraft draft,
}) => EarthquakeIntensity(
  maxIntensity: draft.maxIntensity,
  maxLpgmIntensity: current?.maxLpgmIntensity,
  regions: draft.regions,
  intensityTree: mergeVxse51IntensityTree(
    current: current?.intensityTree ?? const {},
    prefectures: draft.prefectures,
  ),
  lpgmIntensityTree: current?.lpgmIntensityTree ?? const {},
);

Map<JmaIntensity, List<PrefectureIntensityNode>> mergeVxse51IntensityTree({
  required Map<JmaIntensity, List<PrefectureIntensityNode>> current,
  required Map<JmaIntensity, List<IntensityPrefecture>> prefectures,
}) => {
  for (final entry in prefectures.entries)
    entry.key: [
      for (final prefecture in entry.value)
        PrefectureIntensityNode(
          prefecture: prefecture,
          cities:
              findOrdinaryPrefectureNode(
                tree: current,
                code: prefecture.prefecture.code,
              )?.cities ??
              const [],
        ),
    ],
};

PrefectureIntensityNode? findOrdinaryPrefectureNode({
  required Map<JmaIntensity, List<PrefectureIntensityNode>> tree,
  required String code,
}) {
  for (final nodes in tree.values) {
    for (final node in nodes) {
      if (node.prefecture.prefecture.code == code) {
        return node;
      }
    }
  }
  return null;
}

EarthquakeIntensity applyVxse53Intensity({
  required EarthquakeIntensity? current,
  required EarthquakeVxse53DebugDraft draft,
}) => EarthquakeIntensity(
  maxIntensity: draft.maxIntensity,
  maxLpgmIntensity: current?.maxLpgmIntensity,
  regions: draft.regions,
  intensityTree: draft.intensityTree,
  lpgmIntensityTree: current?.lpgmIntensityTree ?? const {},
);

EarthquakeIntensity applyVxse62Intensity({
  required EarthquakeIntensity? current,
  required EarthquakeVxse62DebugDraft draft,
}) => EarthquakeIntensity(
  maxIntensity: draft.maxIntensity,
  maxLpgmIntensity: draft.maxLpgmIntensity,
  regions: draft.regions,
  intensityTree: mergeVxse62IntensityTree(
    current: current?.intensityTree ?? const {},
    updates: draft.intensityTree,
  ),
  lpgmIntensityTree: mergeVxse62LpgmIntensityTree(
    current: current?.lpgmIntensityTree ?? const {},
    regions: draft.lpgmRegions,
    updates: draft.lpgmIntensityTree,
  ),
);

Map<JmaIntensity, List<PrefectureIntensityNode>> mergeVxse62IntensityTree({
  required Map<JmaIntensity, List<PrefectureIntensityNode>> current,
  required Map<JmaIntensity, List<PrefectureIntensityNode>> updates,
}) => {
  for (final entry in updates.entries)
    entry.key: [
      for (final node in entry.value)
        node.copyWith(
          cities: [
            for (final city in node.cities)
              mergeVxse62OrdinaryCity(current: current, update: city),
          ],
        ),
    ],
};

CityIntensityNode mergeVxse62OrdinaryCity({
  required Map<JmaIntensity, List<PrefectureIntensityNode>> current,
  required CityIntensityNode update,
}) {
  final existing = findOrdinaryCityNode(tree: current, code: update.city.code);
  return update.copyWith(
    maxIntensity: existing?.maxIntensity,
    maxLpgmIntensity: existing?.maxLpgmIntensity,
  );
}

CityIntensityNode? findOrdinaryCityNode({
  required Map<JmaIntensity, List<PrefectureIntensityNode>> tree,
  required String code,
}) {
  for (final prefectures in tree.values) {
    for (final prefecture in prefectures) {
      for (final city in prefecture.cities) {
        if (city.city.code == code) {
          return city;
        }
      }
    }
  }
  return null;
}

Map<JmaLpgmIntensity, List<PrefectureLpgmIntensityNode>>
mergeVxse62LpgmIntensityTree({
  required Map<JmaLpgmIntensity, List<PrefectureLpgmIntensityNode>> current,
  required Map<JmaLpgmIntensity, List<LpgmIntensityRegion>> regions,
  required Map<JmaLpgmIntensity, List<PrefectureLpgmIntensityNode>> updates,
}) => {
  for (final entry in updates.entries)
    entry.key: [
      for (final node in entry.value)
        mergeVxse62LpgmPrefecture(
          current: current,
          regions: regions,
          update: node,
        ),
    ],
};

PrefectureLpgmIntensityNode mergeVxse62LpgmPrefecture({
  required Map<JmaLpgmIntensity, List<PrefectureLpgmIntensityNode>> current,
  required Map<JmaLpgmIntensity, List<LpgmIntensityRegion>> regions,
  required PrefectureLpgmIntensityNode update,
}) {
  final region = findLpgmRegion(regions: regions, code: update.region.code);
  return update.copyWith(
    region: region?.region ?? update.region,
    maxLpgmIntensity: region?.maxLpgmIntensity ?? update.maxLpgmIntensity,
    cities: [
      for (final city in update.cities)
        mergeVxse62LpgmCity(current: current, update: city),
    ],
  );
}

LpgmIntensityRegion? findLpgmRegion({
  required Map<JmaLpgmIntensity, List<LpgmIntensityRegion>> regions,
  required String code,
}) {
  for (final values in regions.values) {
    for (final region in values) {
      if (region.region.code == code) {
        return region;
      }
    }
  }
  return null;
}

CityLpgmIntensityNode mergeVxse62LpgmCity({
  required Map<JmaLpgmIntensity, List<PrefectureLpgmIntensityNode>> current,
  required CityLpgmIntensityNode update,
}) {
  final existing = findLpgmCityNode(tree: current, code: update.city.code);
  return update.copyWith(maxLpgmIntensity: existing?.maxLpgmIntensity);
}

CityLpgmIntensityNode? findLpgmCityNode({
  required Map<JmaLpgmIntensity, List<PrefectureLpgmIntensityNode>> tree,
  required String code,
}) {
  for (final prefectures in tree.values) {
    for (final prefecture in prefectures) {
      for (final city in prefecture.cities) {
        if (city.city.code == code) {
          return city;
        }
      }
    }
  }
  return null;
}
