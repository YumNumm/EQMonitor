import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/feature/live_activity/data/model/unified_live_activity_content_state.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/live_activity/data/controller/live_activity_local_controller.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/live_activity/data/model/debug_live_activity_session.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/live_activity/data/repository/debug_live_activity_json_codec.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

final debugLiveActivityActionProvider = Provider<DebugLiveActivityAction>(
  (ref) => const DebugLiveActivityAction(),
);

enum DebugLiveActivityActionResult { success, failure, activityNotFound }

class DebugLiveActivityAction {
  const new();

  Future<DebugLiveActivitySession?> start({
    required WidgetRef ref,
    required BuildContext context,
    required String rawJson,
  }) async {
    final state = parseOrNotify(ref: ref, context: context, rawJson: rawJson);
    if (state == null) {
      return null;
    }
    try {
      final session = await ref
          .read(liveActivityLocalControllerProvider)
          .start(state: state);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('開始しました: ${session.activityId}')),
        );
      }
      return session;
    } on LiveActivityLocalException catch (error) {
      notifyFailure(context: context, operation: '開始', error: error);
      return null;
    }
  }

  Future<DebugLiveActivityActionResult> update({
    required WidgetRef ref,
    required BuildContext context,
    required String activityId,
    required String rawJson,
  }) async {
    if (activityId.isEmpty) {
      notify(context: context, message: '先に Live Activity を選択してください');
      return .failure;
    }
    final state = parseOrNotify(ref: ref, context: context, rawJson: rawJson);
    if (state == null) {
      return .failure;
    }
    try {
      await ref
          .read(liveActivityLocalControllerProvider)
          .update(activityId: activityId, state: state);
      notify(context: context, message: '更新しました');
      return .success;
    } on LiveActivityLocalException catch (error) {
      notifyFailure(context: context, operation: '更新', error: error);
      return error.code == 'activity_not_found' ? .activityNotFound : .failure;
    }
  }

  Future<DebugLiveActivityActionResult> end({
    required WidgetRef ref,
    required BuildContext context,
    required String activityId,
    required String rawJson,
  }) async {
    if (activityId.isEmpty) {
      notify(context: context, message: '先に Live Activity を選択してください');
      return .failure;
    }
    final trimmed = rawJson.trim();
    final state = trimmed.isEmpty
        ? null
        : parseOrNotify(ref: ref, context: context, rawJson: rawJson);
    if (trimmed.isNotEmpty && state == null) {
      return .failure;
    }
    try {
      await ref
          .read(liveActivityLocalControllerProvider)
          .end(activityId: activityId, state: state);
      notify(context: context, message: '終了しました');
      return .success;
    } on LiveActivityLocalException catch (error) {
      notifyFailure(context: context, operation: '終了', error: error);
      return error.code == 'activity_not_found' ? .activityNotFound : .failure;
    }
  }

  UnifiedLiveActivityContentState? parseOrNotify({
    required WidgetRef ref,
    required BuildContext context,
    required String rawJson,
  }) {
    final result = ref.read(debugLiveActivityJsonCodecProvider).parse(rawJson);
    return switch (result) {
      Success(:final value) => value,
      Failure() => notifyInvalidJson(context),
    };
  }

  UnifiedLiveActivityContentState? notifyInvalidJson(BuildContext context) {
    notify(context: context, message: 'JSON または ContentState が不正です');
    return null;
  }

  void notifyFailure({
    required BuildContext context,
    required String operation,
    required LiveActivityLocalException error,
  }) =>
      notify(context: context, message: '$operation に失敗しました: ${error.message}');

  void notify({required BuildContext context, required String message}) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }
}
