import 'dart:async';
import 'dart:ui';

import 'package:background_location_tracker/src/background_location.g.dart';
import 'package:background_location_tracker/src/callback_dispatcher.dart';
import 'package:flutter/services.dart';

class BackgroundLocationTracker {
  new _();

  static final _hostApi = BackgroundLocationHostApi();
  static const _persistenceChannel = MethodChannel(
    'background_location_tracker/persistence',
  );
  // アプリ全体のライフタイムで生存する singleton 用 controller のため close 不要。
  // ignore: close_sinks
  static final _locationController =
      StreamController<LocationUpdateMessage>.broadcast();
  static LocationUpdateMessage? _pendingLiveLocation;

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

  static Stream<LocationUpdateMessage> get locationStream async* {
    final pending = _pendingLiveLocation;
    if (pending != null) {
      _pendingLiveLocation = null;
      yield pending;
    }
    yield* _locationController.stream;
  }

  /// killed状態でheadless runnerが永続化した位置情報を取り出して即時消費する。
  /// 通常起動直後に1度だけ呼び、戻り値があれば現在地リージョンへ反映すること。
  static Future<LocationUpdateMessage?> consumePendingLocation() async {
    final raw = await _persistenceChannel.invokeMapMethod<Object?, Object?>(
      'consumePending',
    );
    if (raw == null) {
      return null;
    }
    final lat = (raw['latitude'] as num?)?.toDouble();
    final lon = (raw['longitude'] as num?)?.toDouble();
    if (lat == null || lon == null) {
      return null;
    }
    return LocationUpdateMessage(latitude: lat, longitude: lon, accuracy: 0);
  }
}

class _FlutterApiHandler implements BackgroundLocationFlutterApi {
  @override
  void onLocationUpdate(LocationUpdateMessage location) {
    if (!BackgroundLocationTracker._locationController.hasListener) {
      BackgroundLocationTracker._pendingLiveLocation = location;
      return;
    }
    BackgroundLocationTracker._locationController.add(location);
  }
}
