import 'dart:async';
import 'dart:ui';

import 'package:background_location_tracker/src/background_location.g.dart';
import 'package:background_location_tracker/src/location_update_message.dart';

class BackgroundLocationTracker {
  new _();

  static final _hostApi = BackgroundLocationHostApi();
  // アプリ全体のライフタイムで生存する singleton 用 controller のため close 不要。
  // ignore: close_sinks
  static final _pendingLocationController =
      StreamController<PendingLocationMessage>.broadcast();
  // ignore: deprecated_member_use_from_same_package
  static final _legacyLocationController =
      StreamController<LocationUpdateMessage>.broadcast();
  static PendingLocationMessage? _pendingLivePendingLocation;
  // ignore: deprecated_member_use_from_same_package
  static LocationUpdateMessage? _pendingLiveLegacyLocation;

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

  @Deprecated('Use pendingLocationStream for update ID based processing.')
  // ignore: deprecated_member_use_from_same_package
  static Stream<LocationUpdateMessage> get locationStream async* {
    final pending = _pendingLiveLegacyLocation;
    if (pending != null) {
      _pendingLiveLegacyLocation = null;
      yield pending;
    }
    yield* _legacyLocationController.stream;
  }

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

  static Future<String?> getActiveHeadlessTaskId() =>
      _hostApi.getActiveHeadlessTaskId();

  static Future<void> completeHeadlessTask({
    required String updateId,
    required HeadlessTaskResult result,
  }) => _hostApi.completeHeadlessTask(updateId, result);

  /// 互換API。appEffectsのacknowledge成功後だけ消費済み位置を返す。
  @Deprecated(
    'Use peekPendingLocation and acknowledgePendingLocation explicitly.',
  )
  // ignore: deprecated_member_use_from_same_package
  static Future<LocationUpdateMessage?> consumePendingLocation() async {
    final pending = await peekPendingLocation(
      consumer: PendingLocationConsumer.appEffects,
    );
    if (pending == null) {
      return null;
    }
    final acknowledged = await acknowledgePendingLocation(
      updateId: pending.updateId,
      consumer: PendingLocationConsumer.appEffects,
    );
    if (!acknowledged) {
      return null;
    }
    return LocationUpdateMessage(
      latitude: pending.latitude,
      longitude: pending.longitude,
      accuracy: pending.accuracy,
    );
  }
}

class _FlutterApiHandler implements BackgroundLocationFlutterApi {
  @override
  void onLocationUpdate(PendingLocationMessage location) {
    final legacyLocation = LocationUpdateMessage(
      latitude: location.latitude,
      longitude: location.longitude,
      accuracy: location.accuracy,
    );
    if (BackgroundLocationTracker._pendingLocationController.hasListener) {
      BackgroundLocationTracker._pendingLocationController.add(location);
    } else {
      BackgroundLocationTracker._pendingLivePendingLocation = location;
    }
    if (BackgroundLocationTracker._legacyLocationController.hasListener) {
      BackgroundLocationTracker._legacyLocationController.add(legacyLocation);
    } else {
      BackgroundLocationTracker._pendingLiveLegacyLocation = legacyLocation;
    }
  }
}
