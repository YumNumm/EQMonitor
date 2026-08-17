import 'dart:convert';

import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/debug/earthquake_vxse_apply_mode.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/debug/earthquake_vxse_debug_draft.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/debug/earthquake_vxse_debug_draft_factory.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/debug/earthquake_vxse_debug_draft_validator.dart';
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
  const new({
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

  /// バリデーション済みのドラフトから、エラーの無い状態を作る。
  factory valid({
    required EarthquakeTelegramType selectedType,
    required EarthquakeVxseApplyMode applyMode,
    required EarthquakeVxseDebugDraft draft,
    Map<String, String> typedInputValues = const {},
    Map<String, String> typedInputErrors = const {},
  }) => EarthquakeVxseDebugEditorState(
    selectedType: selectedType,
    applyMode: applyMode,
    draft: draft,
    jsonText: const JsonEncoder.withIndent('  ').convert(draft.toJson()),
    validationError: null,
    canApply: typedInputErrors.isEmpty,
    typedInputValues: typedInputValues,
    typedInputErrors: typedInputErrors,
  );

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
  const new({required this.current});

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
    final type = const EarthquakeVxseDebugDraftValidator().initialType(
      current: current,
    );
    final draft = const EarthquakeVxseDebugDraftFactory().create(
      current: current,
      type: type,
    );
    return EarthquakeVxseDebugEditorState.valid(
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
    state = EarthquakeVxseDebugEditorState.valid(
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
    final error = const EarthquakeVxseDebugDraftValidator().validate(
      current: current,
      selectedType: state.selectedType,
      draft: draft,
    );
    state = error == null
        ? EarthquakeVxseDebugEditorState.valid(
            selectedType: state.selectedType,
            applyMode: state.applyMode,
            draft: draft,
            typedInputValues: state.typedInputValues,
            typedInputErrors: state.typedInputErrors,
          )
        : state.copyWith(
            draft: draft,
            jsonText: const JsonEncoder.withIndent('  ')
                .convert(draft.toJson()),
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
        state = state.copyWith(
          jsonText: text,
          validationError: 'JSONオブジェクトを入力してください',
          canApply: false,
        );
        return;
      }
      final draft = EarthquakeVxseDebugDraft.fromJson(decoded);
      final error = const EarthquakeVxseDebugDraftValidator().validate(
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
          : state.copyWith(
              jsonText: text,
              validationError: error,
              canApply: false,
            );
    } on FormatException {
      state = state.copyWith(
        jsonText: text,
        validationError: 'JSONの形式が正しくありません',
        canApply: false,
      );
    } on CheckedFromJsonException {
      state = state.copyWith(
        jsonText: text,
        validationError: 'JSONの内容が正しくありません',
        canApply: false,
      );
    } on TypeError {
      state = state.copyWith(
        jsonText: text,
        validationError: 'JSONの内容が正しくありません',
        canApply: false,
      );
    }
  }
}
