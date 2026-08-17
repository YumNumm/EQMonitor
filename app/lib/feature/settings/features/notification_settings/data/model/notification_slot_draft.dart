import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_override.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_slot.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_slot_draft.freezed.dart';
part 'notification_slot_draft.g.dart';

/// サーバ払い出しの id を持たない通知スロット。全件置換とローカル退避に使う。
@freezed
abstract class NotificationSlotDraft with _$NotificationSlotDraft {
  const factory NotificationSlotDraft({
    required NotificationSlotType slotType,
    required bool eewEnabled,
    required bool earthquakeEnabled,
    int? regionId,
    String? regionName,
    String? cityCode,
    String? cityName,
    int? displayOrder,
    JmaIntensity? eewMinIntensity,
    List<NotificationOverride>? eewOverrides,
    JmaIntensity? earthquakeMinIntensity,
    List<NotificationOverride>? earthquakeOverrides,
  }) = _NotificationSlotDraft;

  factory NotificationSlotDraft.fromJson(Map<String, dynamic> json) =>
      _$NotificationSlotDraftFromJson(json);
}

extension NotificationSlotToDraft on NotificationSlot {
  NotificationSlotDraft toDraft() => NotificationSlotDraft(
    slotType: slotType,
    regionId: regionId,
    regionName: regionName,
    cityCode: cityCode,
    cityName: cityName,
    displayOrder: displayOrder,
    eewEnabled: eewEnabled,
    eewMinIntensity: eewMinIntensity,
    eewOverrides: eewOverrides,
    earthquakeEnabled: earthquakeEnabled,
    earthquakeMinIntensity: earthquakeMinIntensity,
    earthquakeOverrides: earthquakeOverrides,
  );
}

extension NotificationSlotDraftToApi on NotificationSlotDraft {
  api.ReplaceSlotEntry toApiReplaceSlotEntry() => api.ReplaceSlotEntry(
    slotType: slotType.toApiSlotType,
    regionId: regionId,
    regionName: regionName,
    cityCode: cityCode,
    cityName: cityName,
    displayOrder: displayOrder,
    eewEnabled: eewEnabled,
    eewMinIntensity: eewEnabled ? eewMinIntensity?.toApiJmaIntensity : null,
    eewOverrides: eewOverrides?.map((o) => o.toApiSlotOverride()).toList(),
    earthquakeEnabled: earthquakeEnabled,
    earthquakeMinIntensity: earthquakeEnabled
        ? earthquakeMinIntensity?.toApiJmaIntensity
        : null,
    earthquakeOverrides: earthquakeOverrides
        ?.map((o) => o.toApiSlotOverride())
        .toList(),
  );
}

extension NotificationSlotTypeToApi on NotificationSlotType {
  api.SlotType get toApiSlotType => switch (this) {
    .currentLocation => .currentLocation,
    .nationwide => .nationwide,
    .region => .region,
  };
}
