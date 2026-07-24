import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/debug/earthquake_vxse_apply_mode.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/debug/earthquake_vxse_debug_draft.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/debug/earthquake_vxse_field_ownership.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_intensity.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_telegram_comment.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_telegram_metadata.dart';
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
    final validationIssues = validateEarthquakeVxseDebugDraft(
      draft: draft,
      type: type,
    );
    if (validationIssues.isNotEmpty) {
      throw EarthquakeVxseDebugDraftValidationException(validationIssues);
    }
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

sealed class EarthquakeVxseDebugDraftValidationIssue {
  const EarthquakeVxseDebugDraftValidationIssue();
}

final class EarthquakeVxseDebugCommentTypeValidationIssue
    extends EarthquakeVxseDebugDraftValidationIssue {
  const EarthquakeVxseDebugCommentTypeValidationIssue({
    required this.commentIndex,
    required this.actualType,
    required this.expectedType,
  });

  final int commentIndex;
  final EarthquakeTelegramType actualType;
  final EarthquakeTelegramType expectedType;
}

final class EarthquakeVxseDebugStationParentValidationIssue
    extends EarthquakeVxseDebugDraftValidationIssue {
  const EarthquakeVxseDebugStationParentValidationIssue({
    required this.stationCode,
    required this.cityCodes,
  });

  final String stationCode;
  final Set<String> cityCodes;
}

final class EarthquakeVxseDebugDuplicateIdentityValidationIssue
    extends EarthquakeVxseDebugDraftValidationIssue {
  const EarthquakeVxseDebugDuplicateIdentityValidationIssue({
    required this.collection,
    required this.identity,
  });

  final String collection;
  final String identity;
}

class EarthquakeVxseDebugDraftValidationException implements Exception {
  const EarthquakeVxseDebugDraftValidationException(this.issues);

  final List<EarthquakeVxseDebugDraftValidationIssue> issues;
}

List<EarthquakeVxseDebugDraftValidationIssue> validateEarthquakeVxseDebugDraft({
  required EarthquakeVxseDebugDraft draft,
  required EarthquakeTelegramType type,
}) {
  final stationParents = switch (draft) {
    EarthquakeVxse62DebugDraft() => vxse62DraftStationParents(draft: draft),
    _ => const <String, Set<String>>{},
  };
  final duplicateIdentities = duplicateEarthquakeVxseDebugIdentities(
    draft: draft,
  );
  return [
    for (final (index, comment) in draft.comments.indexed)
      if (comment.type != type)
        EarthquakeVxseDebugCommentTypeValidationIssue(
          commentIndex: index,
          actualType: comment.type,
          expectedType: type,
        ),
    for (final entry in stationParents.entries)
      if (entry.value.length > 1)
        EarthquakeVxseDebugStationParentValidationIssue(
          stationCode: entry.key,
          cityCodes: entry.value,
        ),
    for (final duplicate in duplicateIdentities)
      EarthquakeVxseDebugDuplicateIdentityValidationIssue(
        collection: duplicate.collection,
        identity: duplicate.identity,
      ),
  ];
}

List<({String collection, String identity})>
duplicateEarthquakeVxseDebugIdentities({
  required EarthquakeVxseDebugDraft draft,
}) {
  final identities = <({String collection, String identity})>[];
  final comments = draft.comments.map(
    (comment) => '${comment.type.name}/${comment.reportedAt.toIso8601String()}',
  );
  identities.addAll(
    duplicateEarthquakeVxseDebugKeys(collection: 'comments', keys: comments),
  );

  final ordinaryRegions = switch (draft) {
    EarthquakeVxse51DebugDraft(:final regions) ||
    EarthquakeVxse53DebugDraft(:final regions) ||
    EarthquakeVxse62DebugDraft(:final regions) => regions,
    _ => const <JmaIntensity, List<IntensityRegion>>{},
  };
  identities.addAll(
    duplicateEarthquakeVxseDebugKeys(
      collection: 'ordinaryRegions',
      keys: ordinaryRegions.values
          .expand((nodes) => nodes)
          .map((node) => node.region.code),
    ),
  );

  final ordinaryPrefectureCodes = switch (draft) {
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
  identities.addAll(
    duplicateEarthquakeVxseDebugKeys(
      collection: 'ordinaryPrefectures',
      keys: ordinaryPrefectureCodes,
    ),
  );

  final ordinaryTree = switch (draft) {
    EarthquakeVxse53DebugDraft(:final intensityTree) ||
    EarthquakeVxse62DebugDraft(:final intensityTree) => intensityTree,
    _ => const <JmaIntensity, List<PrefectureIntensityNode>>{},
  };
  final ordinaryCities = ordinaryTree.values
      .expand((nodes) => nodes)
      .expand((node) => node.cities);
  identities
    ..addAll(
      duplicateEarthquakeVxseDebugKeys(
        collection: 'ordinaryCities',
        keys: ordinaryCities.map((node) => node.city.code),
      ),
    )
    ..addAll(
      duplicateEarthquakeVxseDebugKeys(
        collection: 'ordinaryStations',
        keys: ordinaryCities
            .expand((node) => node.stations)
            .map((node) => node.station.code),
      ),
    );

  if (draft case EarthquakeVxse62DebugDraft(
    :final lpgmRegions,
    :final lpgmIntensityTree,
  )) {
    final lpgmCities = lpgmIntensityTree.values
        .expand((nodes) => nodes)
        .expand((node) => node.cities);
    identities
      ..addAll(
        duplicateEarthquakeVxseDebugKeys(
          collection: 'lpgmRegions',
          keys: lpgmRegions.values
              .expand((nodes) => nodes)
              .map((node) => node.region.code),
        ),
      )
      ..addAll(
        duplicateEarthquakeVxseDebugKeys(
          collection: 'lpgmPrefectures',
          keys: lpgmIntensityTree.values
              .expand((nodes) => nodes)
              .map((node) => node.region.code),
        ),
      )
      ..addAll(
        duplicateEarthquakeVxseDebugKeys(
          collection: 'lpgmCities',
          keys: lpgmCities.map((node) => node.city.code),
        ),
      )
      ..addAll(
        duplicateEarthquakeVxseDebugKeys(
          collection: 'lpgmStations',
          keys: lpgmCities
              .expand((node) => node.stations)
              .map((node) => node.station.code),
        ),
      );
  }
  return identities;
}

List<({String collection, String identity})> duplicateEarthquakeVxseDebugKeys({
  required String collection,
  required Iterable<String> keys,
}) {
  final seen = <String>{};
  final duplicates = <String>{};
  for (final key in keys) {
    if (!seen.add(key)) {
      duplicates.add(key);
    }
  }
  return [
    for (final identity in duplicates)
      (collection: collection, identity: identity),
  ];
}

Map<String, Set<String>> vxse62DraftStationParents({
  required EarthquakeVxse62DebugDraft draft,
}) {
  final parents = <String, Set<String>>{};
  for (final prefectures in draft.intensityTree.values) {
    for (final prefecture in prefectures) {
      for (final city in prefecture.cities) {
        for (final station in city.stations) {
          (parents[station.station.code] ??= {}).add(city.city.code);
        }
      }
    }
  }
  for (final prefectures in draft.lpgmIntensityTree.values) {
    for (final prefecture in prefectures) {
      for (final city in prefecture.cities) {
        for (final station in city.stations) {
          (parents[station.station.code] ??= {}).add(city.city.code);
        }
      }
    }
  }
  return parents;
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
    telegramMetadata: current.telegramMetadata
        .where((entry) => entry.type != type)
        .toList(),
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
                      ? [
                          for (final station in city.stations)
                            station.copyWith(intensity: null),
                        ]
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
                    ? [
                        for (final station in city.stations)
                          station.copyWith(intensity: null),
                      ]
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
  final telegramMetadata = [
    ...current.telegramMetadata.where((entry) => entry.type != type),
    EarthquakeTelegramMetadata(type: type, reportedAt: draft.reportedAt),
  ];
  return switch (draft) {
    EarthquakeVxse51DebugDraft() => current.copyWith(
      status: draft.status,
      telegramTypes: telegramTypes,
      telegramComments: comments,
      telegramMetadata: telegramMetadata,
      intensity: applyVxse51Intensity(current: current.intensity, draft: draft),
    ),
    EarthquakeVxse52DebugDraft() => current.copyWith(
      status: draft.status,
      originTime: draft.originTime,
      arrivalTime: draft.arrivalTime,
      hypocenter: draft.hypocenter,
      telegramTypes: telegramTypes,
      telegramComments: comments,
      telegramMetadata: telegramMetadata,
    ),
    EarthquakeVxse53DebugDraft() => current.copyWith(
      status: draft.status,
      originTime: draft.originTime,
      arrivalTime: draft.arrivalTime,
      hypocenter: draft.hypocenter,
      earthquakeType: draft.earthquakeType,
      telegramTypes: telegramTypes,
      telegramComments: comments,
      telegramMetadata: telegramMetadata,
      intensity: applyVxse53Intensity(current: current.intensity, draft: draft),
    ),
    EarthquakeVxse61DebugDraft() => current.copyWith(
      status: draft.status,
      originTime: draft.originTime,
      arrivalTime: draft.arrivalTime,
      hypocenter: draft.hypocenter,
      telegramTypes: telegramTypes,
      telegramComments: comments,
      telegramMetadata: telegramMetadata,
    ),
    EarthquakeVxse62DebugDraft() => current.copyWith(
      status: draft.status,
      originTime: draft.originTime,
      arrivalTime: draft.arrivalTime,
      hypocenter: draft.hypocenter,
      telegramTypes: telegramTypes,
      telegramComments: comments,
      telegramMetadata: telegramMetadata,
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
  regions: upsertOrdinaryRegionsByCode(
    current: current?.regions ?? const {},
    updates: draft.regions,
  ),
  intensityTree: mergeVxse51IntensityTree(
    current: current?.intensityTree ?? const {},
    prefectures: draft.prefectures,
  ),
  lpgmIntensityTree: current?.lpgmIntensityTree ?? const {},
);

Map<JmaIntensity, List<PrefectureIntensityNode>> mergeVxse51IntensityTree({
  required Map<JmaIntensity, List<PrefectureIntensityNode>> current,
  required Map<JmaIntensity, List<IntensityPrefecture>> prefectures,
}) {
  final updates = {
    for (final entry in prefectures.entries)
      for (final prefecture in entry.value)
        prefecture.prefecture.code: (
          level: entry.key,
          node: PrefectureIntensityNode(
            prefecture: prefecture,
            cities:
                findOrdinaryPrefectureNode(
                  tree: current,
                  code: prefecture.prefecture.code,
                )?.cities ??
                const [],
          ),
        ),
  };
  return upsertOrdinaryPrefectureNodesByCode(
    current: current,
    updates: updates,
  );
}

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
  regions: upsertOrdinaryRegionsByCode(
    current: current?.regions ?? const {},
    updates: draft.regions,
  ),
  intensityTree: mergeVxse53IntensityTree(
    current: current?.intensityTree ?? const {},
    updates: draft.intensityTree,
  ),
  lpgmIntensityTree: current?.lpgmIntensityTree ?? const {},
);

EarthquakeIntensity applyVxse62Intensity({
  required EarthquakeIntensity? current,
  required EarthquakeVxse62DebugDraft draft,
}) => EarthquakeIntensity(
  maxIntensity: draft.maxIntensity,
  maxLpgmIntensity: draft.maxLpgmIntensity,
  regions: upsertOrdinaryRegionsByCode(
    current: current?.regions ?? const {},
    updates: draft.regions,
  ),
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
}) {
  final currentStationCodes = {
    for (final prefectures in current.values)
      for (final prefecture in prefectures)
        for (final city in prefecture.cities)
          for (final station in city.stations) station.station.code,
  };
  final stationUpdates = {
    for (final prefectures in updates.values)
      for (final prefecture in prefectures)
        for (final city in prefecture.cities)
          for (final station in city.stations) station.station.code: station,
  };
  final newStationsByCityCode = {
    for (final prefectures in updates.values)
      for (final prefecture in prefectures)
        for (final city in prefecture.cities)
          city.city.code: [
            for (final station in city.stations)
              if (!currentStationCodes.contains(station.station.code)) station,
          ],
  };
  final prefectureUpdates = {
    for (final entry in updates.entries)
      for (final update in entry.value)
        update.prefecture.prefecture.code: (
          level: entry.key,
          node: mergeVxse62OrdinaryPrefecture(
            currentTree: current,
            update: update,
            newStationsByCityCode: newStationsByCityCode,
          ),
        ),
  };
  final merged = upsertOrdinaryPrefectureNodesByCode(
    current: current,
    updates: prefectureUpdates,
  );
  return {
    for (final entry in merged.entries)
      entry.key: [
        for (final prefecture in entry.value)
          prefecture.copyWith(
            cities: [
              for (final city in prefecture.cities)
                city.copyWith(
                  stations: mergeVxse62OrdinaryStations(
                    current: city.stations,
                    updatesByCode: stationUpdates,
                    additions:
                        newStationsByCityCode[city.city.code] ?? const [],
                  ),
                ),
            ],
          ),
      ],
  };
}

PrefectureIntensityNode mergeVxse62OrdinaryPrefecture({
  required Map<JmaIntensity, List<PrefectureIntensityNode>> currentTree,
  required PrefectureIntensityNode update,
  required Map<String, List<StationIntensityNode>> newStationsByCityCode,
}) {
  final currentPrefecture = findOrdinaryPrefectureNode(
    tree: currentTree,
    code: update.prefecture.prefecture.code,
  );
  final currentCityCodes = {
    for (final prefectures in currentTree.values)
      for (final prefecture in prefectures)
        for (final city in prefecture.cities) city.city.code,
  };
  return update.copyWith(
    cities: [
      ...?currentPrefecture?.cities,
      for (final city in update.cities)
        if (!currentCityCodes.contains(city.city.code) &&
            (newStationsByCityCode[city.city.code]?.isNotEmpty ?? false))
          city.copyWith(
            maxIntensity: null,
            maxLpgmIntensity: null,
            stations: newStationsByCityCode[city.city.code] ?? const [],
          ),
    ],
  );
}

List<StationIntensityNode> mergeVxse62OrdinaryStations({
  required List<StationIntensityNode> current,
  required Map<String, StationIntensityNode> updatesByCode,
  required List<StationIntensityNode> additions,
}) {
  final values = {
    for (final station in current)
      station.station.code: updatesByCode[station.station.code] ?? station,
    for (final station in additions) station.station.code: station,
  };
  return values.values.toList();
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
}) {
  final currentStationCodes = {
    for (final prefectures in current.values)
      for (final prefecture in prefectures)
        for (final city in prefecture.cities)
          for (final station in city.stations) station.station.code,
  };
  final stationUpdates = {
    for (final prefectures in updates.values)
      for (final prefecture in prefectures)
        for (final city in prefecture.cities)
          for (final station in city.stations) station.station.code: station,
  };
  final newStationsByCityCode = {
    for (final prefectures in updates.values)
      for (final prefecture in prefectures)
        for (final city in prefecture.cities)
          city.city.code: [
            for (final station in city.stations)
              if (!currentStationCodes.contains(station.station.code)) station,
          ],
  };
  final regionUpdates = {
    for (final entry in regions.entries)
      for (final region in entry.value)
        region.region.code: (
          level: entry.key,
          node: PrefectureLpgmIntensityNode(
            region: region.region,
            maxLpgmIntensity: region.maxLpgmIntensity,
            cities:
                findLpgmPrefectureNode(
                  tree: current,
                  code: region.region.code,
                )?.cities ??
                const [],
          ),
        ),
  };
  final treeUpdates = {
    for (final entry in updates.entries)
      for (final update in entry.value)
        update.region.code: (
          level: regionUpdates[update.region.code]?.level ?? entry.key,
          node: mergeVxse62LpgmPrefecture(
            current: current,
            regions: regions,
            update: update,
            newStationsByCityCode: newStationsByCityCode,
          ),
        ),
  };
  final merged = upsertLpgmPrefectureNodesByCode(
    current: current,
    updates: {...regionUpdates, ...treeUpdates},
  );
  return {
    for (final entry in merged.entries)
      entry.key: [
        for (final prefecture in entry.value)
          prefecture.copyWith(
            cities: [
              for (final city in prefecture.cities)
                city.copyWith(
                  stations: mergeVxse62LpgmStations(
                    current: city.stations,
                    updatesByCode: stationUpdates,
                    additions:
                        newStationsByCityCode[city.city.code] ?? const [],
                  ),
                ),
            ],
          ),
      ],
  };
}

PrefectureLpgmIntensityNode mergeVxse62LpgmPrefecture({
  required Map<JmaLpgmIntensity, List<PrefectureLpgmIntensityNode>> current,
  required Map<JmaLpgmIntensity, List<LpgmIntensityRegion>> regions,
  required PrefectureLpgmIntensityNode update,
  required Map<String, List<StationLpgmIntensityNode>> newStationsByCityCode,
}) {
  final region = findLpgmRegion(regions: regions, code: update.region.code);
  final currentPrefecture = findLpgmPrefectureNode(
    tree: current,
    code: update.region.code,
  );
  final currentCityCodes = {
    for (final prefectures in current.values)
      for (final prefecture in prefectures)
        for (final city in prefecture.cities) city.city.code,
  };
  return update.copyWith(
    region: region?.region ?? update.region,
    maxLpgmIntensity: region?.maxLpgmIntensity ?? update.maxLpgmIntensity,
    cities: [
      ...?currentPrefecture?.cities,
      for (final city in update.cities)
        if (!currentCityCodes.contains(city.city.code) &&
            (newStationsByCityCode[city.city.code]?.isNotEmpty ?? false))
          city.copyWith(
            maxLpgmIntensity: null,
            stations: newStationsByCityCode[city.city.code] ?? const [],
          ),
    ],
  );
}

List<StationLpgmIntensityNode> mergeVxse62LpgmStations({
  required List<StationLpgmIntensityNode> current,
  required Map<String, StationLpgmIntensityNode> updatesByCode,
  required List<StationLpgmIntensityNode> additions,
}) {
  final values = {
    for (final station in current)
      station.station.code: updatesByCode[station.station.code] ?? station,
    for (final station in additions) station.station.code: station,
  };
  return values.values.toList();
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

PrefectureLpgmIntensityNode? findLpgmPrefectureNode({
  required Map<JmaLpgmIntensity, List<PrefectureLpgmIntensityNode>> tree,
  required String code,
}) {
  for (final prefectures in tree.values) {
    for (final prefecture in prefectures) {
      if (prefecture.region.code == code) {
        return prefecture;
      }
    }
  }
  return null;
}

Map<JmaIntensity, List<IntensityRegion>> upsertOrdinaryRegionsByCode({
  required Map<JmaIntensity, List<IntensityRegion>> current,
  required Map<JmaIntensity, List<IntensityRegion>> updates,
}) {
  final values = {
    for (final entry in current.entries)
      for (final region in entry.value)
        region.region.code: (level: entry.key, value: region),
    for (final entry in updates.entries)
      for (final region in entry.value)
        region.region.code: (level: entry.key, value: region),
  };
  return {
    for (final level in JmaIntensity.values)
      if (values.values.any((entry) => entry.level == level))
        level: [
          for (final entry in values.values)
            if (entry.level == level) entry.value,
        ],
  };
}

Map<JmaIntensity, List<PrefectureIntensityNode>>
upsertOrdinaryPrefectureNodesByCode({
  required Map<JmaIntensity, List<PrefectureIntensityNode>> current,
  required Map<String, ({JmaIntensity level, PrefectureIntensityNode node})>
  updates,
}) {
  final values = {
    for (final entry in current.entries)
      for (final node in entry.value)
        node.prefecture.prefecture.code: (level: entry.key, node: node),
    ...updates,
  };
  return {
    for (final level in JmaIntensity.values)
      if (values.values.any((entry) => entry.level == level))
        level: [
          for (final entry in values.values)
            if (entry.level == level) entry.node,
        ],
  };
}

Map<JmaLpgmIntensity, List<PrefectureLpgmIntensityNode>>
upsertLpgmPrefectureNodesByCode({
  required Map<JmaLpgmIntensity, List<PrefectureLpgmIntensityNode>> current,
  required Map<
    String,
    ({JmaLpgmIntensity level, PrefectureLpgmIntensityNode node})
  >
  updates,
}) {
  final values = {
    for (final entry in current.entries)
      for (final node in entry.value)
        node.region.code: (level: entry.key, node: node),
    ...updates,
  };
  return {
    for (final level in JmaLpgmIntensity.values)
      if (values.values.any((entry) => entry.level == level))
        level: [
          for (final entry in values.values)
            if (entry.level == level) entry.node,
        ],
  };
}

Map<JmaIntensity, List<PrefectureIntensityNode>> mergeVxse53IntensityTree({
  required Map<JmaIntensity, List<PrefectureIntensityNode>> current,
  required Map<JmaIntensity, List<PrefectureIntensityNode>> updates,
}) {
  final values = {
    for (final entry in updates.entries)
      for (final node in entry.value)
        node.prefecture.prefecture.code: (
          level: entry.key,
          node: mergeVxse53PrefectureNode(
            current: findOrdinaryPrefectureNode(
              tree: current,
              code: node.prefecture.prefecture.code,
            ),
            update: node,
          ),
        ),
  };
  return upsertOrdinaryPrefectureNodesByCode(current: current, updates: values);
}

PrefectureIntensityNode mergeVxse53PrefectureNode({
  required PrefectureIntensityNode? current,
  required PrefectureIntensityNode update,
}) {
  final cities = {
    for (final city in current?.cities ?? const <CityIntensityNode>[])
      city.city.code: city,
    for (final city in update.cities)
      city.city.code: mergeVxse53CityNode(
        current: current?.cities
            .where((value) => value.city.code == city.city.code)
            .firstOrNull,
        update: city,
      ),
  };
  return update.copyWith(cities: cities.values.toList());
}

CityIntensityNode mergeVxse53CityNode({
  required CityIntensityNode? current,
  required CityIntensityNode update,
}) {
  final stations = {
    for (final station in current?.stations ?? const <StationIntensityNode>[])
      station.station.code: station,
    for (final station in update.stations) station.station.code: station,
  };
  return update.copyWith(stations: stations.values.toList());
}
