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
  });

  final EarthquakeTelegramType selectedType;
  final EarthquakeVxseApplyMode applyMode;
  final EarthquakeVxseDebugDraft draft;
  final String jsonText;
  final String? validationError;
  final bool canApply;

  EarthquakeVxseDebugEditorState copyWith({
    EarthquakeTelegramType? selectedType,
    EarthquakeVxseApplyMode? applyMode,
    EarthquakeVxseDebugDraft? draft,
    String? jsonText,
    String? validationError,
    bool clearValidationError = false,
    bool? canApply,
  }) => EarthquakeVxseDebugEditorState(
    selectedType: selectedType ?? this.selectedType,
    applyMode: applyMode ?? this.applyMode,
    draft: draft ?? this.draft,
    jsonText: jsonText ?? this.jsonText,
    validationError: clearValidationError
        ? null
        : validationError ?? this.validationError,
    canApply: canApply ?? this.canApply,
  );
}

@riverpod
class EarthquakeVxseDebugEditorController
    extends _$EarthquakeVxseDebugEditorController {
  @override
  EarthquakeVxseDebugEditorState build(Earthquake current) {
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
}) => EarthquakeVxseDebugEditorState(
  selectedType: selectedType,
  applyMode: applyMode,
  draft: draft,
  jsonText: prettyEarthquakeVxseDebugJson(draft: draft),
  validationError: null,
  canApply: true,
);

EarthquakeVxseDebugEditorState invalidEarthquakeVxseDebugEditorState({
  required EarthquakeVxseDebugEditorState state,
  required String text,
  required String error,
}) => state.copyWith(jsonText: text, validationError: error, canApply: false);

String prettyEarthquakeVxseDebugJson({
  required EarthquakeVxseDebugDraft draft,
}) => const JsonEncoder.withIndent('  ').convert(draft.toJson());

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
  if (validateEarthquakeVxseDebugDraft(
    draft: draft,
    type: selectedType,
  ).isNotEmpty) {
    return '入力内容の関連付けが正しくありません';
  }
  return null;
}
