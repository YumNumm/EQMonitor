import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_override.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_slot.freezed.dart';

enum NotificationSlotType {
  currentLocation,
  nationwide,
  region;

  String get label => switch (this) {
    .currentLocation => '現在地',
    .nationwide => '全国',
    .region => '地域',
  };
}

@freezed
abstract class NotificationSlot with _$NotificationSlot {
  const factory NotificationSlot({
    required String id,
    required NotificationSlotType slotType,
    required int? regionId,
    required String? regionName,
    required String? cityCode,
    required String? cityName,
    required int displayOrder,
    required bool eewEnabled,
    required JmaIntensity? eewMinIntensity,
    required List<NotificationOverride>? eewOverrides,
    required bool earthquakeEnabled,
    required JmaIntensity? earthquakeMinIntensity,
    required List<NotificationOverride>? earthquakeOverrides,
  }) = _NotificationSlot;
}

extension ApiSlotResponseConverter on api.SlotResponse {
  NotificationSlot toNotificationSlot() => NotificationSlot(
    id: id,
    slotType: slotType.toAppSlotType,
    regionId: regionId?.toInt(),
    regionName: regionName,
    cityCode: cityCode,
    cityName: cityName,
    displayOrder: displayOrder.toInt(),
    eewEnabled: eewEnabled,
    eewMinIntensity: eewMinIntensity?.toJmaIntensity,
    eewOverrides: eewOverrides
        ?.map((o) => o.toNotificationOverride())
        .toList(),
    earthquakeEnabled: earthquakeEnabled,
    earthquakeMinIntensity: earthquakeMinIntensity?.toJmaIntensity,
    earthquakeOverrides: earthquakeOverrides
        ?.map((o) => o.toNotificationOverride())
        .toList(),
  );
}

extension ApiSlotTypeConverter on api.SlotType {
  NotificationSlotType get toAppSlotType => switch (this) {
    .currentLocation => NotificationSlotType.currentLocation,
    .nationwide => NotificationSlotType.nationwide,
    .region => NotificationSlotType.region,
  };
}
