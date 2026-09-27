import 'package:eqmonitor/feature/settings/children/config/debug/live_activity/data/model/debug_live_activity_kind.dart';

/// ローカル開始した Live Activity の識別情報。
///
/// `activityId` は iOS の `Activity.id`（開始時にネイティブが払い出す）。
/// 更新・終了時に同じ ID を指定する。
class const DebugLiveActivitySession({
  required final String activityId,
  required final DebugLiveActivityKind kind,
  required final String eventId,
});
