import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_debug_override_notifier.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_vxse_debug_editor_controller.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'earthquake_vxse_debug_action.g.dart';

@riverpod
EarthquakeVxseDebugAction earthquakeVxseDebugAction(Ref ref) =>
    const EarthquakeVxseDebugAction();

class EarthquakeVxseDebugAction {
  const EarthquakeVxseDebugAction();

  void apply({
    required WidgetRef ref,
    required BuildContext context,
    required Earthquake current,
    required EarthquakeVxseDebugEditorState editorState,
  }) {
    if (!editorState.canApply) {
      return;
    }
    ref
        .read(earthquakeDebugOverrideProvider(current.eventId).notifier)
        .applyDraft(
          current: current,
          draft: editorState.draft,
          mode: editorState.applyMode,
        );
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('デバッグ変更を適用しました')));
  }
}
