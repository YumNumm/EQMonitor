import 'dart:async';
import 'dart:ui';

import 'background_location.g.dart';
import 'callback_dispatcher.dart';

class BackgroundLocationTracker {
  BackgroundLocationTracker._();

  static final _hostApi = BackgroundLocationHostApi();
  static final _locationController =
      StreamController<LocationUpdateMessage>.broadcast();

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

  static Stream<LocationUpdateMessage> get locationStream =>
      _locationController.stream;
}

class _FlutterApiHandler implements BackgroundLocationFlutterApi {
  @override
  void onLocationUpdate(LocationUpdateMessage location) {
    BackgroundLocationTracker._locationController.add(location);
  }
}
