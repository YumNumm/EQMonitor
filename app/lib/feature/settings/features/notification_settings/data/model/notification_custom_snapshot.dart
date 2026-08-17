import 'package:eqmonitor/feature/notification/data/model/general_notification_settings.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/earthquake_global_settings.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/eew_global_settings.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/eew_warning_settings.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_slot_draft.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_custom_snapshot.freezed.dart';
part 'notification_custom_snapshot.g.dart';

const int notificationCustomSnapshotSchemaVersion = 1;

/// カスタムプリセットの設定をローカルへ退避・復元するためのスナップショット。
@freezed
abstract class NotificationCustomSnapshot with _$NotificationCustomSnapshot {
  const factory NotificationCustomSnapshot({
    required int schemaVersion,
    required List<NotificationSlotDraft> slots,
    required EewWarningSettings eewWarning,
    required EewGlobalSettings eewGlobal,
    required EarthquakeGlobalSettings earthquakeGlobal,
    required GeneralNotificationSettings general,
  }) = _NotificationCustomSnapshot;

  factory NotificationCustomSnapshot.fromJson(Map<String, dynamic> json) =>
      _$NotificationCustomSnapshotFromJson(json);
}
