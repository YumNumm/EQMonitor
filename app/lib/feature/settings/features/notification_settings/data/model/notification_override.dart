import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_override.freezed.dart';
part 'notification_override.g.dart';

@freezed
abstract class NotificationOverride with _$NotificationOverride {
  const factory({
    required JmaIntensity minJmaIntensity,
    required String sound,
    required InterruptionLevel interruptionLevel,
  }) = _NotificationOverride;

  factory fromJson(Map<String, dynamic> json) =>
      _$NotificationOverrideFromJson(json);
}

// InterruptionLevel のアプリ側 enum
// API の InterruptionLevel / DefaultInterruptionLevel / NationwideInterruptionLevel
// をアプリ内で統一的に扱う
enum InterruptionLevel { passive, active, timeSensitive, critical }

extension InterruptionLevelLabel on InterruptionLevel {
  String get label => switch (this) {
    .passive => '通常',
    .active => 'アクティブ',
    .timeSensitive => '時間重要',
    .critical => 'クリティカル',
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
    .passive => .passive,
    .active => .active,
    .timeSensitive => .timeSensitive,
    .critical => .critical,
  };
}

extension ApiDefaultInterruptionLevelConverter on api.DefaultInterruptionLevel {
  InterruptionLevel get toAppInterruptionLevel => switch (this) {
    .passive => .passive,
    .active => .active,
    .timeSensitive => .timeSensitive,
    .critical => .critical,
  };
}

extension ApiNationwideInterruptionLevelConverter
    on api.NationwideInterruptionLevel {
  InterruptionLevel get toAppInterruptionLevel => switch (this) {
    .passive => .passive,
    .active => .active,
    .timeSensitive => .timeSensitive,
    .critical => .critical,
  };
}

extension ApiCurrentLocationInterruptionLevelConverter
    on api.CurrentLocationInterruptionLevel {
  InterruptionLevel get toAppInterruptionLevel => switch (this) {
    .passive => .passive,
    .active => .active,
    .timeSensitive => .timeSensitive,
    .critical => .critical,
  };
}

extension InterruptionLevelToApi on InterruptionLevel {
  api.InterruptionLevel get toApiInterruptionLevel => switch (this) {
    .passive => .passive,
    .active => .active,
    .timeSensitive => .timeSensitive,
    .critical => .critical,
  };

  api.DefaultInterruptionLevel get toApiDefaultInterruptionLevel =>
      switch (this) {
        .passive => api.DefaultInterruptionLevel.passive,
        .active => api.DefaultInterruptionLevel.active,
        .timeSensitive => api.DefaultInterruptionLevel.timeSensitive,
        .critical => api.DefaultInterruptionLevel.critical,
      };

  api.NationwideInterruptionLevel get toApiNationwideInterruptionLevel =>
      switch (this) {
        .passive => .passive,
        .active => .active,
        .timeSensitive => .timeSensitive,
        .critical => .critical,
      };

  api.CurrentLocationInterruptionLevel
  get toApiCurrentLocationInterruptionLevel => switch (this) {
    .passive => .passive,
    .active => .active,
    .timeSensitive => .timeSensitive,
    .critical => .critical,
  };
}

extension NotificationOverrideToApi on NotificationOverride {
  api.SlotOverride toApiSlotOverride() => api.SlotOverride(
    minJmaIntensity:
        minJmaIntensity.toApiMinJmaIntensity ??
        (throw StateError('unknown intensity cannot be serialized')),
    sound: sound,
    interruptionLevel: interruptionLevel.toApiInterruptionLevel,
  );
}
