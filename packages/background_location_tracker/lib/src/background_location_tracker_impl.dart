import 'dart:async';
import 'dart:ui';

import 'package:background_location_tracker/src/background_location.g.dart';

class BackgroundLocationTracker {
  new _();

  static final _hostApi = BackgroundLocationHostApi();
  // アプリ全体のライフタイムで生存する singleton 用 controller のため close 不要。
  // ignore: close_sinks
  static final _pendingLocationController =
      StreamController<PendingLocationMessage>.broadcast();
  static PendingLocationMessage? _pendingLivePendingLocation;

  /// アプリ起動時に必ず呼ぶ。killed状態復帰用コールバックハンドルをネイティブへ永続保存する。
  static Future<void> initialize({
    required void Function() callbackDispatcher,
  }) async {
    BackgroundLocationFlutterApi.setUp(_FlutterApiHandler());
    final handle = PluginUtilities.getCallbackHandle(
      callbackDispatcher,
    );
    if (handle == null) {
      throw StateError('Background location callback handle is unavailable');
    }
    await _hostApi.initialize(handle.toRawHandle());
  }

  static Future<void> startMonitoring() => _hostApi.startMonitoring();
  static Future<void> stopMonitoring() => _hostApi.stopMonitoring();

  static Stream<PendingLocationMessage> get pendingLocationStream async* {
    final pending = _pendingLivePendingLocation;
    if (pending != null) {
      _pendingLivePendingLocation = null;
      yield pending;
    }
    yield* _pendingLocationController.stream;
  }

  static Future<PendingLocationMessage?> peekPendingLocation({
    required PendingLocationConsumer consumer,
  }) => _hostApi.peekPendingLocation(consumer);

  static Future<bool> acknowledgePendingLocation({
    required String updateId,
    required PendingLocationConsumer consumer,
  }) => _hostApi.acknowledgePendingLocation(updateId, consumer);

  static Future<DeviceLocationSyncLeaseMessage?>
  acquireDeviceLocationSyncLease({
    required String updateId,
    required Duration duration,
  }) => _hostApi.acquireDeviceLocationSyncLease(
    updateId,
    duration.inMilliseconds,
  );

  static Future<bool> isDeviceLocationSyncLeaseCurrent({
    required String leaseId,
    required String updateId,
  }) => _hostApi.isDeviceLocationSyncLeaseCurrent(leaseId, updateId);

  static Future<void> releaseDeviceLocationSyncLease({
    required String leaseId,
  }) => _hostApi.releaseDeviceLocationSyncLease(leaseId);

  static Future<String?> getActiveHeadlessTaskId() =>
      _hostApi.getActiveHeadlessTaskId();

  static Future<void> completeHeadlessTask({
    required String updateId,
    required HeadlessTaskResult result,
  }) => _hostApi.completeHeadlessTask(updateId, result);

}

class _FlutterApiHandler implements BackgroundLocationFlutterApi {
  @override
  void onLocationUpdate(PendingLocationMessage location) {
    if (BackgroundLocationTracker._pendingLocationController.hasListener) {
      BackgroundLocationTracker._pendingLocationController.add(location);
    } else {
      BackgroundLocationTracker._pendingLivePendingLocation = location;
    }
  }
}
