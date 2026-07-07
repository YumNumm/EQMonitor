import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:telemetry_store/src/models/live_activity_end_reason.dart';
import 'package:telemetry_store/src/models/live_activity_type.dart';
import 'package:telemetry_store/src/models/notification_framework.dart';

part 'telemetry_event.freezed.dart';

@Freezed(toJson: false, fromJson: false)
sealed class TelemetryEvent with _$TelemetryEvent {
  const TelemetryEvent._();

  const factory TelemetryEvent.notificationReceived({
    required NotificationFramework framework,
    required String channelId,
    String? title,
    String? eventId,
    String? priority,
  }) = NotificationReceivedEvent;

  const factory TelemetryEvent.notificationOpened({
    required bool coldStart,
    String? eventId,
    int? elapsedMs,
  }) = NotificationOpenedEvent;

  const factory TelemetryEvent.liveActivityStarted({
    required LiveActivityType activityType,
    required String activityId,
  }) = LiveActivityStartedEvent;

  const factory TelemetryEvent.liveActivityUpdated({
    required LiveActivityType activityType,
    required String activityId,
    String? eventId,
  }) = LiveActivityUpdatedEvent;

  const factory TelemetryEvent.liveActivityEnded({
    required LiveActivityType activityType,
    required String activityId,
    required LiveActivityEndReason endReason,
    int? durationMs,
  }) = LiveActivityEndedEvent;

  const factory TelemetryEvent.error({
    required String errorType,
    required String message,
    String? stackTrace,
  }) = ErrorTelemetryEvent;

  const factory TelemetryEvent.startupTiming({
    required Map<String, int> phasesMicros,
  }) = StartupTimingEvent;

  const factory TelemetryEvent.appLaunch({
    required String launchType,
    required String appVersion,
    required int buildNumber,
    required String platform,
    required String osVersion,
    required String deviceModel,
    required String locale,
    required bool isPhysicalDevice,
    required int physicalRamMb,
    required int cpuCores,
    required String manufacturer,
    int? androidSdkInt,
    String? securityPatch,
    bool? isLowRamDevice,
    String? installerStore,
  }) = AppLaunchEvent;

  String get eventType => switch (this) {
    NotificationReceivedEvent() => 'notification_received',
    NotificationOpenedEvent() => 'notification_opened',
    LiveActivityStartedEvent() => 'live_activity_started',
    LiveActivityUpdatedEvent() => 'live_activity_updated',
    LiveActivityEndedEvent() => 'live_activity_ended',
    ErrorTelemetryEvent() => 'error',
    StartupTimingEvent() => 'startup_timing',
    AppLaunchEvent() => 'app_launch',
  };

  String? get eventId => switch (this) {
    NotificationReceivedEvent(:final eventId) => eventId,
    NotificationOpenedEvent(:final eventId) => eventId,
    LiveActivityUpdatedEvent(:final eventId) => eventId,
    _ => null,
  };

  Map<String, dynamic> toPayload() => switch (this) {
    NotificationReceivedEvent(
      :final framework,
      :final channelId,
      :final title,
      :final priority,
    ) =>
      {
        'framework': framework.name,
        'channel_id': channelId,
        'title': ?title,
        'priority': ?priority,
      },
    NotificationOpenedEvent(:final coldStart, :final elapsedMs) => {
      'cold_start': coldStart,
      'elapsed_ms': ?elapsedMs,
    },
    LiveActivityStartedEvent(:final activityType, :final activityId) => {
      'activity_type': activityType.name,
      'activity_id': activityId,
    },
    LiveActivityUpdatedEvent(:final activityType, :final activityId) => {
      'activity_type': activityType.name,
      'activity_id': activityId,
    },
    LiveActivityEndedEvent(
      :final activityType,
      :final activityId,
      :final endReason,
      :final durationMs,
    ) =>
      {
        'activity_type': activityType.name,
        'activity_id': activityId,
        'end_reason': endReason.name,
        'duration_ms': ?durationMs,
      },
    ErrorTelemetryEvent(
      :final errorType,
      :final message,
      :final stackTrace,
    ) =>
      {
        'error_type': errorType,
        'message': message,
        'stack_trace': ?stackTrace,
      },
    StartupTimingEvent(:final phasesMicros) => {
      'phases_micros': phasesMicros,
    },
    AppLaunchEvent(
      :final launchType,
      :final appVersion,
      :final buildNumber,
      :final platform,
      :final osVersion,
      :final deviceModel,
      :final locale,
      :final isPhysicalDevice,
      :final physicalRamMb,
      :final cpuCores,
      :final manufacturer,
      :final androidSdkInt,
      :final securityPatch,
      :final isLowRamDevice,
      :final installerStore,
    ) =>
      {
        'launch_type': launchType,
        'app_version': appVersion,
        'build_number': buildNumber,
        'platform': platform,
        'os_version': osVersion,
        'device_model': deviceModel,
        'locale': locale,
        'is_physical_device': isPhysicalDevice,
        'physical_ram_mb': physicalRamMb,
        'cpu_cores': cpuCores,
        'manufacturer': manufacturer,
        'android_sdk_int': ?androidSdkInt,
        'security_patch': ?securityPatch,
        'is_low_ram_device': ?isLowRamDevice,
        'installer_store': ?installerStore,
      },
  };
}
