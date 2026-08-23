import 'dart:async';
import 'dart:ui';

import 'package:background_location_tracker/src/background_location.g.dart';
import 'package:background_location_tracker/src/callback_dispatcher.dart';

class BackgroundLocationTracker {
  new _();

  static final _hostApi = BackgroundLocationHostApi();
  // アプリ全体のライフタイムで生存する singleton 用 controller のため close 不要。
  // ignore: close_sinks
  static final _locationController =
      StreamController<PendingLocationMessage>.broadcast();
  static PendingLocationMessage? _pendingLiveLocation;

  /// アプリ起動時に必ず呼ぶ。killed状態復帰用コールバックハンドルをネイティブへ永続保存する。
  static Future<void> initialize() async {
    BackgroundLocationFlutterApi.setUp(_FlutterApiHandler());
    final handle = PluginUtilities.getCallbackHandle(
      locationUpdateCallbackDispatcher,
    );
    if (handle != null) {
      await _hostApi.initialize(handle.toRawHandle());
    }
  }

  static Future<void> startMonitoring() => _hostApi.startMonitoring();
  static Future<void> stopMonitoring() => _hostApi.stopMonitoring();

  static Stream<PendingLocationMessage> get locationStream async* {
    final pending = _pendingLiveLocation;
    if (pending != null) {
      _pendingLiveLocation = null;
      yield pending;
    }
    yield* _locationController.stream;
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

  /// 互換API。読出し時点ではappEffectsを完了扱いにせず、pendingを保持する。
  static Future<PendingLocationMessage?> consumePendingLocation() =>
      peekPendingLocation(
        consumer: PendingLocationConsumer.appEffects,
      );
}

class _FlutterApiHandler implements BackgroundLocationFlutterApi {
  @override
  void onLocationUpdate(PendingLocationMessage location) {
    if (!BackgroundLocationTracker._locationController.hasListener) {
      BackgroundLocationTracker._pendingLiveLocation = location;
      return;
    }
    BackgroundLocationTracker._locationController.add(location);
  }
}
