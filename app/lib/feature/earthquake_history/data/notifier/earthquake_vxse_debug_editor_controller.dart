import 'dart:convert';

import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/debug/earthquake_vxse_apply_mode.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/debug/earthquake_vxse_debug_draft.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/debug/earthquake_vxse_debug_draft_factory.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/debug/earthquake_vxse_debug_reducer.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_hypocenter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_telegram_comment.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_telegram_type.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_type.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_tree.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/lpgm_intensity_tree.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'earthquake_vxse_debug_editor_controller.g.dart';

class EarthquakeVxseDebugEditorState {
  const EarthquakeVxseDebugEditorState({
    required this.selectedType,
    required this.applyMode,
    required this.draft,
    required this.jsonText,
    required this.validationError,
    required this.canApply,
    this.typedInputValues = const {},
    this.typedInputErrors = const {},
  });

  final EarthquakeTelegramType selectedType;
  final EarthquakeVxseApplyMode applyMode;
  final EarthquakeVxseDebugDraft draft;
  final String jsonText;
  final String? validationError;
  final bool canApply;
  final Map<String, String> typedInputValues;
  final Map<String, String> typedInputErrors;

  EarthquakeVxseDebugEditorState copyWith({
    EarthquakeTelegramType? selectedType,
    EarthquakeVxseApplyMode? applyMode,
    EarthquakeVxseDebugDraft? draft,
    String? jsonText,
    String? validationError,
    bool clearValidationError = false,
    bool? canApply,
    Map<String, String>? typedInputValues,
    Map<String, String>? typedInputErrors,
  }) => EarthquakeVxseDebugEditorState(
    selectedType: selectedType ?? this.selectedType,
    applyMode: applyMode ?? this.applyMode,
    draft: draft ?? this.draft,
    jsonText: jsonText ?? this.jsonText,
    validationError: clearValidationError
        ? null
        : validationError ?? this.validationError,
    canApply: canApply ?? this.canApply,
    typedInputValues: typedInputValues ?? this.typedInputValues,
    typedInputErrors: typedInputErrors ?? this.typedInputErrors,
  );
}

/// Provider identity is the event ID; [current] only bootstraps the session.
class EarthquakeVxseDebugEditorSession {
  const EarthquakeVxseDebugEditorSession({required this.current});

  final Earthquake current;

  @override
  int get hashCode => current.eventId.hashCode;

  @override
  bool operator ==(Object other) =>
      other is EarthquakeVxseDebugEditorSession &&
      other.current.eventId == current.eventId;
}

@riverpod
class EarthquakeVxseDebugEditorController
    extends _$EarthquakeVxseDebugEditorController {
  @override
  EarthquakeVxseDebugEditorState build(
    EarthquakeVxseDebugEditorSession session,
  ) {
    _latestCurrent = session.current;
    final type = initialEarthquakeVxseDebugType(current: current);
    final draft = const EarthquakeVxseDebugDraftFactory().create(
      current: current,
      type: type,
    );
    return validEarthquakeVxseDebugEditorState(
      selectedType: type,
      applyMode: EarthquakeVxseApplyMode.merge,
      draft: draft,
    );
  }

  late Earthquake _latestCurrent;

  Earthquake get current => _latestCurrent;

  /// Refreshes only the source used by an explicit type switch or reload.
  void updateCurrent(Earthquake value) {
    if (value.eventId != current.eventId) {
      throw ArgumentError.value(value.eventId, 'value', 'event ID mismatch');
    }
    _latestCurrent = value;
  }

  void selectType(EarthquakeTelegramType type) {
    final draft = const EarthquakeVxseDebugDraftFactory().create(
      current: current,
      type: type,
    );
    state = validEarthquakeVxseDebugEditorState(
      selectedType: type,
      applyMode: state.applyMode,
      draft: draft,
    );
  }

  void setApplyMode(EarthquakeVxseApplyMode mode) {
    state = state.copyWith(applyMode: mode);
  }

  void setTypedInput({
    required String fieldId,
    required String text,
    String? error,
  }) {
    final values = {...state.typedInputValues, fieldId: text};
    final errors = {...state.typedInputErrors};
    if (error == null) {
      errors.remove(fieldId);
    } else {
      errors[fieldId] = error;
    }
    state = state.copyWith(
      typedInputValues: values,
      typedInputErrors: errors,
      canApply: state.validationError == null && errors.isEmpty,
    );
  }

  String typedInputText({required String fieldId, required String fallback}) =>
      state.typedInputValues[fieldId] ?? fallback;

  String? typedInputError({required String fieldId}) =>
      state.typedInputErrors[fieldId];

  void pruneTypedInputPrefix(String prefix) {
    final values = {
      for (final entry in state.typedInputValues.entries)
        if (!entry.key.startsWith('$prefix.')) entry.key: entry.value,
    };
    final errors = {
      for (final entry in state.typedInputErrors.entries)
        if (!entry.key.startsWith('$prefix.')) entry.key: entry.value,
    };
    state = state.copyWith(
      typedInputValues: values,
      typedInputErrors: errors,
      canApply: state.validationError == null && errors.isEmpty,
    );
  }

  void migrateTypedInputPrefix({required String from, required String to}) {
    final values = {
      for (final entry in state.typedInputValues.entries)
        if (entry.key.startsWith('$from.'))
          '$to${entry.key.substring(from.length)}': entry.value,
      for (final entry in state.typedInputValues.entries)
        if (!entry.key.startsWith('$from.')) entry.key: entry.value,
    };
    final errors = {
      for (final entry in state.typedInputErrors.entries)
        if (entry.key.startsWith('$from.'))
          '$to${entry.key.substring(from.length)}': entry.value,
      for (final entry in state.typedInputErrors.entries)
        if (!entry.key.startsWith('$from.')) entry.key: entry.value,
    };
    state = state.copyWith(
      typedInputValues: values,
      typedInputErrors: errors,
      canApply: state.validationError == null && errors.isEmpty,
    );
  }

  void setReportedAt(DateTime value) {
    updateDraft(state.draft.copyWith(reportedAt: value));
  }

  void setStatus(TelegramStatus value) {
    updateDraft(state.draft.copyWith(status: value));
  }

  void setArrivalTime(DateTime? value) {
    updateDraft(switch (state.draft) {
      EarthquakeVxse51DebugDraft() => state.draft,
      EarthquakeVxse52DebugDraft(:final copyWith) => copyWith(
        arrivalTime: value,
      ),
      EarthquakeVxse53DebugDraft(:final copyWith) => copyWith(
        arrivalTime: value,
      ),
      EarthquakeVxse61DebugDraft(:final copyWith) => copyWith(
        arrivalTime: value,
      ),
      EarthquakeVxse62DebugDraft(:final copyWith) => copyWith(
        arrivalTime: value,
      ),
    });
  }

  void setOriginTime(DateTime? value) {
    updateDraft(switch (state.draft) {
      EarthquakeVxse51DebugDraft() => state.draft,
      EarthquakeVxse52DebugDraft(:final copyWith) => copyWith(
        originTime: value,
      ),
      EarthquakeVxse53DebugDraft(:final copyWith) => copyWith(
        originTime: value,
      ),
      EarthquakeVxse61DebugDraft(:final copyWith) => copyWith(
        originTime: value,
      ),
      EarthquakeVxse62DebugDraft(:final copyWith) => copyWith(
        originTime: value,
      ),
    });
  }

  void setHypocenter(EarthquakeHypocenter value) {
    updateDraft(switch (state.draft) {
      EarthquakeVxse51DebugDraft() => state.draft,
      EarthquakeVxse52DebugDraft(:final copyWith) => copyWith(
        hypocenter: value,
      ),
      EarthquakeVxse53DebugDraft(:final copyWith) => copyWith(
        hypocenter: value,
      ),
      EarthquakeVxse61DebugDraft(:final copyWith) => copyWith(
        hypocenter: value,
      ),
      EarthquakeVxse62DebugDraft(:final copyWith) => copyWith(
        hypocenter: value,
      ),
    });
  }

  void setEarthquakeType(EarthquakeType value) {
    final draft = state.draft;
    if (draft is EarthquakeVxse53DebugDraft) {
      updateDraft(draft.copyWith(earthquakeType: value));
    }
  }

  void setMaxIntensity(JmaIntensity value) {
    updateDraft(switch (state.draft) {
      EarthquakeVxse51DebugDraft(:final copyWith) => copyWith(
        maxIntensity: value,
      ),
      EarthquakeVxse52DebugDraft() ||
      EarthquakeVxse61DebugDraft() => state.draft,
      EarthquakeVxse53DebugDraft(:final copyWith) => copyWith(
        maxIntensity: value,
      ),
      EarthquakeVxse62DebugDraft(:final copyWith) => copyWith(
        maxIntensity: value,
      ),
    });
  }

  void setMaxLpgmIntensity(JmaLpgmIntensity value) {
    final draft = state.draft;
    if (draft is EarthquakeVxse62DebugDraft) {
      updateDraft(draft.copyWith(maxLpgmIntensity: value));
    }
  }

  void setRegions(Map<JmaIntensity, List<IntensityRegion>> value) {
    updateDraft(switch (state.draft) {
      EarthquakeVxse51DebugDraft(:final copyWith) => copyWith(regions: value),
      EarthquakeVxse52DebugDraft() ||
      EarthquakeVxse61DebugDraft() => state.draft,
      EarthquakeVxse53DebugDraft(:final copyWith) => copyWith(regions: value),
      EarthquakeVxse62DebugDraft(:final copyWith) => copyWith(regions: value),
    });
  }

  void setPrefectures(Map<JmaIntensity, List<IntensityPrefecture>> value) {
    final draft = state.draft;
    if (draft is EarthquakeVxse51DebugDraft) {
      updateDraft(draft.copyWith(prefectures: value));
    }
  }

  void setIntensityTree(
    Map<JmaIntensity, List<PrefectureIntensityNode>> value,
  ) {
    final draft = state.draft;
    switch (draft) {
      case EarthquakeVxse53DebugDraft():
        updateDraft(draft.copyWith(intensityTree: value));
      case EarthquakeVxse62DebugDraft():
        updateDraft(draft.copyWith(intensityTree: value));
      default:
        return;
    }
  }

  void setLpgmRegions(Map<JmaLpgmIntensity, List<LpgmIntensityRegion>> value) {
    final draft = state.draft;
    if (draft is EarthquakeVxse62DebugDraft) {
      updateDraft(draft.copyWith(lpgmRegions: value));
    }
  }

  void setLpgmIntensityTree(
    Map<JmaLpgmIntensity, List<PrefectureLpgmIntensityNode>> value,
  ) {
    final draft = state.draft;
    if (draft is EarthquakeVxse62DebugDraft) {
      updateDraft(draft.copyWith(lpgmIntensityTree: value));
    }
  }

  void setVxse62StationParentCity({
    required String currentCode,
    required String code,
    required String name,
  }) {
    final draft = state.draft;
    if (draft is! EarthquakeVxse62DebugDraft) {
      return;
    }
    updateDraft(
      draft.copyWith(
        intensityTree: {
          for (final entry in draft.intensityTree.entries)
            entry.key: [
              for (final prefecture in entry.value)
                prefecture.copyWith(
                  cities: [
                    for (final city in prefecture.cities)
                      city.city.code == currentCode
                          ? city.copyWith(
                              city: city.city.copyWith(
                                code: code,
                                name: city.city.name.copyWith(ja: name),
                              ),
                            )
                          : city,
                  ],
                ),
            ],
        },
        lpgmIntensityTree: {
          for (final entry in draft.lpgmIntensityTree.entries)
            entry.key: [
              for (final prefecture in entry.value)
                prefecture.copyWith(
                  cities: [
                    for (final city in prefecture.cities)
                      city.city.code == currentCode
                          ? city.copyWith(
                              city: city.city.copyWith(
                                code: code,
                                name: city.city.name.copyWith(ja: name),
                              ),
                            )
                          : city,
                  ],
                ),
            ],
        },
      ),
    );
  }

  void setComments(List<EarthquakeTelegramComment> value) {
    updateDraft(state.draft.copyWith(comments: value));
  }

  void updateDraft(EarthquakeVxseDebugDraft draft) {
    final error = validateEditorDraft(
      current: current,
      selectedType: state.selectedType,
      draft: draft,
    );
    state = error == null
        ? validEarthquakeVxseDebugEditorState(
            selectedType: state.selectedType,
            applyMode: state.applyMode,
            draft: draft,
            typedInputValues: state.typedInputValues,
            typedInputErrors: state.typedInputErrors,
          )
        : state.copyWith(
            draft: draft,
            jsonText: prettyEarthquakeVxseDebugJson(draft: draft),
            validationError: error,
            canApply: false,
          );
  }

  void validateJson(String text) {
    try {
      final decoded = switch (jsonDecode(text)) {
        Map<String, dynamic> value => value,
        _ => null,
      };
      if (decoded == null) {
        state = invalidEarthquakeVxseDebugEditorState(
          state: state,
          text: text,
          error: 'JSONオブジェクトを入力してください',
        );
        return;
      }
      final draft = EarthquakeVxseDebugDraft.fromJson(decoded);
      final error = validateEditorDraft(
        current: current,
        selectedType: state.selectedType,
        draft: draft,
      );
      state = error == null
          ? state.copyWith(
              draft: draft,
              jsonText: text,
              clearValidationError: true,
              canApply: true,
              typedInputValues: const {},
              typedInputErrors: const {},
            )
          : invalidEarthquakeVxseDebugEditorState(
              state: state,
              text: text,
              error: error,
            );
    } on FormatException {
      state = invalidEarthquakeVxseDebugEditorState(
        state: state,
        text: text,
        error: 'JSONの形式が正しくありません',
      );
    } on CheckedFromJsonException {
      state = invalidEarthquakeVxseDebugEditorState(
        state: state,
        text: text,
        error: 'JSONの内容が正しくありません',
      );
    } on TypeError {
      state = invalidEarthquakeVxseDebugEditorState(
        state: state,
        text: text,
        error: 'JSONの内容が正しくありません',
      );
    }
  }
}

EarthquakeTelegramType initialEarthquakeVxseDebugType({
  required Earthquake current,
}) {
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

EarthquakeVxseDebugEditorState validEarthquakeVxseDebugEditorState({
  required EarthquakeTelegramType selectedType,
  required EarthquakeVxseApplyMode applyMode,
  required EarthquakeVxseDebugDraft draft,
  Map<String, String> typedInputValues = const {},
  Map<String, String> typedInputErrors = const {},
}) => EarthquakeVxseDebugEditorState(
  selectedType: selectedType,
  applyMode: applyMode,
  draft: draft,
  jsonText: prettyEarthquakeVxseDebugJson(draft: draft),
  validationError: null,
  canApply: typedInputErrors.isEmpty,
  typedInputValues: typedInputValues,
  typedInputErrors: typedInputErrors,
);

EarthquakeVxseDebugEditorState invalidEarthquakeVxseDebugEditorState({
  required EarthquakeVxseDebugEditorState state,
  required String text,
  required String error,
}) => state.copyWith(jsonText: text, validationError: error, canApply: false);

String prettyEarthquakeVxseDebugJson({
  required EarthquakeVxseDebugDraft draft,
}) => const JsonEncoder.withIndent('  ').convert(draft.toJson());

String nextEarthquakeVxseDebugCode({
  required String prefix,
  required Set<String> usedCodes,
}) {
  var suffix = 1;
  while (usedCodes.contains('$prefix-$suffix')) {
    suffix++;
  }
  return '$prefix-$suffix';
}

DateTime nextEarthquakeVxseDebugCommentTime({
  required DateTime base,
  required Set<DateTime> usedTimes,
}) {
  var candidate = base;
  do {
    candidate = candidate.add(const Duration(seconds: 1));
  } while (usedTimes.contains(candidate));
  return candidate;
}

double nextEarthquakeVxseDebugPrePeriodBand({required Set<double> usedBands}) {
  var tenths = 16;
  while (usedBands.contains(tenths / 10)) {
    tenths++;
  }
  return tenths / 10;
}

String? validateEditorDraft({
  required Earthquake current,
  required EarthquakeTelegramType selectedType,
  required EarthquakeVxseDebugDraft draft,
}) {
  if (earthquakeVxseDraftTelegramType(draft: draft) != selectedType) {
    return '選択中の電文種類と一致しません';
  }
  if (draft.eventId != current.eventId) {
    return '現在の地震とevent IDが一致しません';
  }
  if (hasDuplicateEarthquakeVxseGroupedCodes(draft: draft)) {
    return '同じコードの階級項目が重複しています';
  }
  if (validateEarthquakeVxseDebugDraft(
    draft: draft,
    type: selectedType,
  ).isNotEmpty) {
    return '入力内容の関連付けが正しくありません';
  }
  if (!hasConsistentEarthquakeVxseGroupLevels(draft: draft)) {
    return '階級グループと項目の階級が一致しません';
  }
  return null;
}

bool hasDuplicateEarthquakeVxseGroupedCodes({
  required EarthquakeVxseDebugDraft draft,
}) {
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

bool hasConsistentEarthquakeVxseGroupLevels({
  required EarthquakeVxseDebugDraft draft,
}) {
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

/// Moves a node without replacing destination collisions; validation owns
/// duplicate-code rejection so no existing payload is silently discarded.
Map<JmaIntensity, List<IntensityRegion>> moveIntensityRegionLevel({
  required Map<JmaIntensity, List<IntensityRegion>> source,
  required JmaIntensity from,
  required int index,
  required JmaIntensity to,
}) {
  final node = source[from]?[index];
  if (node == null) {
    return source;
  }
  return {
    for (final entry in source.entries)
      if (entry.key != from && entry.key != to) entry.key: entry.value,
    if (from != to && (source[from]?.length ?? 0) > 1)
      from: [
        for (final (currentIndex, current) in source[from]!.indexed)
          if (currentIndex != index) current,
      ],
    to: [
      if (to != from) ...source[to] ?? const [],
      node.copyWith(maxIntensity: to),
      if (to == from)
        for (final (currentIndex, current) in source[from]!.indexed)
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
  final node = source[from]?[index];
  if (node == null) {
    return source;
  }
  return {
    for (final entry in source.entries)
      if (entry.key != from && entry.key != to) entry.key: entry.value,
    if (from != to && (source[from]?.length ?? 0) > 1)
      from: [
        for (final (currentIndex, current) in source[from]!.indexed)
          if (currentIndex != index) current,
      ],
    to: [
      if (to != from) ...source[to] ?? const [],
      node.copyWith(maxLpgmIntensity: to),
      if (to == from)
        for (final (currentIndex, current) in source[from]!.indexed)
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
  final node = source[from]?[index];
  if (node == null) {
    return source;
  }
  return {
    for (final entry in source.entries)
      if (entry.key != from && entry.key != to) entry.key: entry.value,
    if (from != to && (source[from]?.length ?? 0) > 1)
      from: [
        for (final (currentIndex, current) in source[from]!.indexed)
          if (currentIndex != index) current,
      ],
    to: [
      if (to != from) ...source[to] ?? const [],
      node.copyWith(maxIntensity: to),
      if (to == from)
        for (final (currentIndex, current) in source[from]!.indexed)
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
  final node = source[from]?[index];
  if (node == null) {
    return source;
  }
  return {
    for (final entry in source.entries)
      if (entry.key != from && entry.key != to) entry.key: entry.value,
    if (from != to && (source[from]?.length ?? 0) > 1)
      from: [
        for (final (currentIndex, current) in source[from]!.indexed)
          if (currentIndex != index) current,
      ],
    to: [
      if (to != from) ...source[to] ?? const [],
      node.copyWith(prefecture: node.prefecture.copyWith(maxIntensity: to)),
      if (to == from)
        for (final (currentIndex, current) in source[from]!.indexed)
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
  final node = source[from]?[index];
  if (node == null) {
    return source;
  }
  return {
    for (final entry in source.entries)
      if (entry.key != from && entry.key != to) entry.key: entry.value,
    if (from != to && (source[from]?.length ?? 0) > 1)
      from: [
        for (final (currentIndex, current) in source[from]!.indexed)
          if (currentIndex != index) current,
      ],
    to: [
      if (to != from) ...source[to] ?? const [],
      node.copyWith(maxLpgmIntensity: to),
      if (to == from)
        for (final (currentIndex, current) in source[from]!.indexed)
          if (currentIndex != index) current,
    ],
  };
}
