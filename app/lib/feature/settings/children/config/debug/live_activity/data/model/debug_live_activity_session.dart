import 'package:eqmonitor/feature/settings/children/config/debug/live_activity/data/model/debug_live_activity_kind.dart';

/// ローカル開始した Live Activity の識別情報。
///
/// `activityId` は iOS の `Activity.id`（開始時にネイティブが払い出す）。
/// 更新・終了時に同じ ID を指定する。
class DebugLiveActivitySession {
  const new({
    required this.activityId,
    required this.kind,
    required this.eventId,
  });

  final String activityId;
  final DebugLiveActivityKind kind;
  final String eventId;
}
