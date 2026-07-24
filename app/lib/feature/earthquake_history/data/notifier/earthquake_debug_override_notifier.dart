import 'dart:convert';

import 'package:eqmonitor/feature/earthquake_history/data/model/debug/earthquake_vxse_apply_mode.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/debug/earthquake_vxse_debug_draft.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/debug/earthquake_vxse_debug_reducer.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'earthquake_debug_override_notifier.g.dart';

@riverpod
class EarthquakeDebugOverrideNotifier
    extends _$EarthquakeDebugOverrideNotifier {
  @override
  Earthquake? build(String eventId) => null;

  void applyDraft({
    required Earthquake current,
    required EarthquakeVxseDebugDraft draft,
    required EarthquakeVxseApplyMode mode,
  }) {
    if (current.eventId != eventId) {
      throw ArgumentError.value(current.eventId, 'current.eventId');
    }
    if (draft.eventId != eventId) {
      throw ArgumentError.value(draft.eventId, 'draft.eventId');
    }
    state = const EarthquakeVxseDebugReducer().apply(
      current: state ?? current,
      draft: draft,
      mode: mode,
    );
  }

  void applyJson({
    required Earthquake current,
    required String json,
    required EarthquakeVxseApplyMode mode,
  }) {
    applyDraft(
      current: current,
      draft: EarthquakeVxseDebugDraft.fromJson(
        jsonDecode(json) as Map<String, dynamic>,
      ),
      mode: mode,
    );
  }

  void reset() {
    state = null;
  }
}
