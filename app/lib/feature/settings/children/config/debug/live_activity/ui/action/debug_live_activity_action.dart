import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/live_activity/data/controller/live_activity_local_controller.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/live_activity/data/model/debug_live_activity_kind.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/live_activity/data/model/debug_live_activity_session.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/live_activity/data/repository/debug_live_activity_json_codec.dart';
import 'package:material_ui/material_ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final debugLiveActivityActionProvider = Provider<DebugLiveActivityAction>(
  (ref) => const DebugLiveActivityAction(),
);

/// Live Activity デバッグ画面のイベントハンドラ。
///
/// JSON の検証 → ネイティブ操作 → SnackBar 表示までを担う。
class DebugLiveActivityAction {
  const new();

  /// Live Activity を開始する。成功時のみ [DebugLiveActivitySession] を返す。
  Future<DebugLiveActivitySession?> start({
    required WidgetRef ref,
    required BuildContext context,
    required DebugLiveActivityKind kind,
    required String rawJson,
  }) async {
    final messenger = ScaffoldMessenger.of(context);
    final contentState = _parseOrNotify(ref, messenger, rawJson);
    if (contentState == null) {
      return null;
    }
    final eventId = _eventIdOrNotify(messenger, contentState);
    if (eventId == null) {
      return null;
    }

    try {
      final activityId = await ref
          .read(liveActivityLocalControllerProvider)
          .start(kind: kind, eventId: eventId, contentState: contentState);
      messenger.showSnackBar(
        SnackBar(content: Text('開始しました: $activityId')),
      );
      return DebugLiveActivitySession(
        activityId: activityId,
        kind: kind,
        eventId: eventId,
      );
    } on LiveActivityLocalException catch (e) {
      messenger.showSnackBar(SnackBar(content: Text('開始に失敗しました: ${e.message}')));
      return null;
    }
  }

  /// Live Activity を更新する。
  Future<bool> update({
    required WidgetRef ref,
    required BuildContext context,
    required DebugLiveActivityKind kind,
    required String activityId,
    required String rawJson,
  }) async {
    final messenger = ScaffoldMessenger.of(context);
    if (activityId.isEmpty) {
      messenger.showSnackBar(
        const SnackBar(content: Text('activityId が未設定です（先に開始してください）')),
      );
      return false;
    }
    final contentState = _parseOrNotify(ref, messenger, rawJson);
    if (contentState == null) {
      return false;
    }

    try {
      await ref
          .read(liveActivityLocalControllerProvider)
          .update(kind: kind, activityId: activityId, contentState: contentState);
      messenger.showSnackBar(const SnackBar(content: Text('更新しました')));
      return true;
    } on LiveActivityLocalException catch (e) {
      messenger.showSnackBar(SnackBar(content: Text('更新に失敗しました: ${e.message}')));
      return false;
    }
  }

  /// Live Activity を終了する。ContentState は任意（空なら現在の内容で終了）。
  Future<bool> end({
    required WidgetRef ref,
    required BuildContext context,
    required DebugLiveActivityKind kind,
    required String activityId,
    required String rawJson,
  }) async {
    final messenger = ScaffoldMessenger.of(context);
    if (activityId.isEmpty) {
      messenger.showSnackBar(
        const SnackBar(content: Text('activityId が未設定です（先に開始してください）')),
      );
      return false;
    }

    Map<String, dynamic>? contentState;
    if (rawJson.trim().isNotEmpty) {
      contentState = _parseOrNotify(ref, messenger, rawJson);
      if (contentState == null) {
        return false;
      }
    }

    try {
      await ref
          .read(liveActivityLocalControllerProvider)
          .end(kind: kind, activityId: activityId, contentState: contentState);
      messenger.showSnackBar(const SnackBar(content: Text('終了しました')));
      return true;
    } on LiveActivityLocalException catch (e) {
      messenger.showSnackBar(SnackBar(content: Text('終了に失敗しました: ${e.message}')));
      return false;
    }
  }

  Map<String, dynamic>? _parseOrNotify(
    WidgetRef ref,
    ScaffoldMessengerState messenger,
    String rawJson,
  ) {
    final result = ref.read(debugLiveActivityJsonCodecProvider).parse(rawJson);
    switch (result) {
      case Success(:final value):
        return value;
      case Failure(:final exception):
        messenger.showSnackBar(
          SnackBar(content: Text('JSON が不正です: ${exception.message}')),
        );
        return null;
    }
  }

  String? _eventIdOrNotify(
    ScaffoldMessengerState messenger,
    Map<String, dynamic> contentState,
  ) {
    final eventId = contentState['eventId'];
    if (eventId is String && eventId.isNotEmpty) {
      return eventId;
    }
    messenger.showSnackBar(
      const SnackBar(content: Text('ContentState に eventId (String) が必要です')),
    );
    return null;
  }
}
