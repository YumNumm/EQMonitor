import 'dart:developer';

import 'package:background_location_tracker/background_location_tracker.dart';
import 'package:dio/dio.dart';
import 'package:eqmonitor/feature/location/data/logic/device_location_sync_service.dart';
import 'package:eqmonitor/feature/location/data/model/pending_device_location.dart';

typedef CreateHeadlessDeviceLocationSyncService =
    Future<DeviceLocationSyncService> Function();

typedef RecordHeadlessTerminalFailure = Future<void> Function({
  required String updateId,
  required int statusCode,
});

typedef LogHeadlessTaskResult = void Function({
  required String updateId,
  required HeadlessTaskResult result,
});

abstract interface class HeadlessBackgroundLocationBridge {
  Future<PendingLocationMessage?> peekPendingLocation({
    required PendingLocationConsumer consumer,
  });

  Future<bool> acknowledgePendingLocation({
    required String updateId,
    required PendingLocationConsumer consumer,
  });

  Future<void> completeHeadlessTask({
    required String updateId,
    required HeadlessTaskResult result,
  });
}

class BackgroundLocationTrackerHeadlessBridge
    implements HeadlessBackgroundLocationBridge {
  const new();

  @override
  Future<bool> acknowledgePendingLocation({
    required String updateId,
    required PendingLocationConsumer consumer,
  }) => BackgroundLocationTracker.acknowledgePendingLocation(
    updateId: updateId,
    consumer: consumer,
  );

  @override
  Future<void> completeHeadlessTask({
    required String updateId,
    required HeadlessTaskResult result,
  }) => BackgroundLocationTracker.completeHeadlessTask(
    updateId: updateId,
    result: result,
  );

  @override
  Future<PendingLocationMessage?> peekPendingLocation({
    required PendingLocationConsumer consumer,
  }) => BackgroundLocationTracker.peekPendingLocation(consumer: consumer);
}

class HeadlessDeviceLocationErrorClassifier {
  const new();

  HeadlessTaskResult classify(Object error) {
    if (error is! DioException) {
      return HeadlessTaskResult.retry;
    }
    final statusCode = error.response?.statusCode;
    // The Device Location OpenAPI contract lists 400 as Bad Request.
    // Unlisted 4xx responses may be recoverable, so keep them pending.
    const terminalPayloadValidationStatusCodes = {400};
    if (terminalPayloadValidationStatusCodes.contains(statusCode)) {
      return HeadlessTaskResult.terminalFailure;
    }
    return HeadlessTaskResult.retry;
  }
}

class HeadlessDeviceLocationRunner {
  new({
    required this.bridge,
    required this.createSyncService,
    RecordHeadlessTerminalFailure? recordTerminalFailure,
    LogHeadlessTaskResult? logResult,
    this.errorClassifier = const HeadlessDeviceLocationErrorClassifier(),
  }) : recordTerminalFailure =
           recordTerminalFailure ?? HeadlessDeviceLocationRunner.ignoreFailure,
       logResult = logResult ?? HeadlessDeviceLocationRunner.logSafeResult;

  final HeadlessBackgroundLocationBridge bridge;
  final CreateHeadlessDeviceLocationSyncService createSyncService;
  final RecordHeadlessTerminalFailure recordTerminalFailure;
  final LogHeadlessTaskResult logResult;
  final HeadlessDeviceLocationErrorClassifier errorClassifier;

  static Future<void> ignoreFailure({
    required String updateId,
    required int statusCode,
  }) async {}

  static void logSafeResult({
    required String updateId,
    required HeadlessTaskResult result,
  }) {
    log(
      'updateId=$updateId result=${result.name}',
      name: 'HeadlessDeviceLocationRunner',
    );
  }

  Future<HeadlessTaskResult> run({required String taskUpdateId}) async {
    var result = HeadlessTaskResult.retry;
    try {
      final pending = await bridge.peekPendingLocation(
        consumer: PendingLocationConsumer.deviceLocation,
      );
      if (pending == null) {
        result = HeadlessTaskResult.success;
      } else {
        result = await syncPending(pending: pending);
      }
    } on Object {
      result = HeadlessTaskResult.retry;
    }

    await bridge.completeHeadlessTask(updateId: taskUpdateId, result: result);
    logResult(updateId: taskUpdateId, result: result);
    return result;
  }

  Future<HeadlessTaskResult> syncPending({
    required PendingLocationMessage pending,
  }) async {
    try {
      final service = await createSyncService();
      final syncResult = await service.syncPending(
        location: PendingDeviceLocation(
          updateId: pending.updateId,
          latitude: pending.latitude,
          longitude: pending.longitude,
          accuracy: pending.accuracy,
          timestampMillis: pending.timestampMillis,
        ),
      );
      return await completeSuccessfulSync(
        pending: pending,
        syncResult: syncResult,
      );
    } on Object catch (error) {
      return completeFailedSync(pending: pending, error: error);
    }
  }

  Future<HeadlessTaskResult> completeSuccessfulSync({
    required PendingLocationMessage pending,
    required DeviceLocationSyncResult syncResult,
  }) async {
    final shouldAcknowledge = switch (syncResult) {
      DeviceLocationSyncResult.sent ||
      DeviceLocationSyncResult.unchanged ||
      DeviceLocationSyncResult.disabled => true,
      DeviceLocationSyncResult.uninitialized ||
      DeviceLocationSyncResult.noPending => false,
    };
    if (!shouldAcknowledge) {
      return syncResult == DeviceLocationSyncResult.noPending
          ? HeadlessTaskResult.success
          : HeadlessTaskResult.retry;
    }
    return await acknowledge(pending: pending)
        ? HeadlessTaskResult.success
        : HeadlessTaskResult.retry;
  }

  Future<HeadlessTaskResult> completeFailedSync({
    required PendingLocationMessage pending,
    required Object error,
  }) async {
    final result = errorClassifier.classify(error);
    if (result != HeadlessTaskResult.terminalFailure) {
      return result;
    }
    final statusCode = (error as DioException).response?.statusCode;
    if (statusCode == null) {
      return HeadlessTaskResult.retry;
    }
    try {
      await recordTerminalFailure(
        updateId: pending.updateId,
        statusCode: statusCode,
      );
      return await acknowledge(pending: pending)
          ? HeadlessTaskResult.terminalFailure
          : HeadlessTaskResult.retry;
    } on Object {
      return HeadlessTaskResult.retry;
    }
  }

  Future<bool> acknowledge({required PendingLocationMessage pending}) =>
      bridge.acknowledgePendingLocation(
        updateId: pending.updateId,
        consumer: PendingLocationConsumer.deviceLocation,
      );
}
