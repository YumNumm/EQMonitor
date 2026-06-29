import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_override.freezed.dart';

@freezed
abstract class NotificationOverride with _$NotificationOverride {
  const factory NotificationOverride({
    required JmaIntensity minJmaIntensity,
    required String sound,
    required InterruptionLevel interruptionLevel,
  }) = _NotificationOverride;
}

// InterruptionLevel のアプリ側 enum
// API の InterruptionLevel / DefaultInterruptionLevel / NationwideInterruptionLevel
// をアプリ内で統一的に扱う
enum InterruptionLevel {
  passive,
  active,
  timeSensitive,
  critical;

  String get label => switch (this) {
    .passive => 'サイレント',
    .active => '通常',
    .timeSensitive => '即時',
    .critical => '重大な通知',
  };
}

extension ApiSlotOverrideConverter on api.SlotOverride {
  NotificationOverride toNotificationOverride() => NotificationOverride(
    minJmaIntensity: minJmaIntensity.toJmaIntensity,
    sound: sound,
    interruptionLevel: interruptionLevel.toAppInterruptionLevel,
  );
}

extension ApiInterruptionLevelConverter on api.InterruptionLevel {
  InterruptionLevel get toAppInterruptionLevel => switch (this) {
    .passive => InterruptionLevel.passive,
    .active => InterruptionLevel.active,
    .timeSensitive => InterruptionLevel.timeSensitive,
    .critical => InterruptionLevel.critical,
  };
}

extension ApiDefaultInterruptionLevelConverter on api.DefaultInterruptionLevel {
  InterruptionLevel get toAppInterruptionLevel => switch (this) {
    .passive => InterruptionLevel.passive,
    .active => InterruptionLevel.active,
    .timeSensitive => InterruptionLevel.timeSensitive,
    .critical => InterruptionLevel.critical,
  };
}

extension ApiNationwideInterruptionLevelConverter
    on api.NationwideInterruptionLevel {
  InterruptionLevel get toAppInterruptionLevel => switch (this) {
    .passive => InterruptionLevel.passive,
    .active => InterruptionLevel.active,
  };
}

extension InterruptionLevelToApi on InterruptionLevel {
  api.InterruptionLevel get toApiInterruptionLevel => switch (this) {
    .passive => api.InterruptionLevel.passive,
    .active => api.InterruptionLevel.active,
    .timeSensitive => api.InterruptionLevel.timeSensitive,
    .critical => api.InterruptionLevel.critical,
  };

  api.NationwideInterruptionLevel? get toApiNationwideInterruptionLevel =>
      switch (this) {
        .passive => api.NationwideInterruptionLevel.passive,
        .active => api.NationwideInterruptionLevel.active,
        _ => null,
      };
}

extension NotificationOverrideToApi on NotificationOverride {
  api.SlotOverride toApiSlotOverride() => api.SlotOverride(
    minJmaIntensity:
        minJmaIntensity.toApiMinJmaIntensity ?? api.MinJmaIntensity.value4,
    sound: sound,
    interruptionLevel: interruptionLevel.toApiInterruptionLevel,
  );
}
