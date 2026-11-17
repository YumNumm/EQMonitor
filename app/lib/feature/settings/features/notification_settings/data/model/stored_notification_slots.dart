import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_slot.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'stored_notification_slots.freezed.dart';
part 'stored_notification_slots.g.dart';

/// 端末に保存する、最後にサーバーと一致していた通知スロット一覧。
@freezed
abstract class StoredNotificationSlots with _$StoredNotificationSlots {
  @JsonSerializable(explicitToJson: true)
  const factory({
    required List<NotificationSlot> slots,
  }) = _StoredNotificationSlots;

  factory fromJson(Map<String, dynamic> json) =>
      _$StoredNotificationSlotsFromJson(json);
}
