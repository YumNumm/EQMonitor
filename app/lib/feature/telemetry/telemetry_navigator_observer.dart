import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:telemetry_store/telemetry_store.dart';

class TelemetryNavigatorObserver extends NavigatorObserver {
  TelemetryNavigatorObserver({
    required TelemetryRecorder recorder,
    required TelemetryUploader uploader,
  })  : _recorder = recorder,
        _uploader = uploader;

  final TelemetryRecorder _recorder;
  final TelemetryUploader _uploader;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (route is PageRoute) {
      final screenName = route.settings.name;
      if (screenName != null) {
        unawaited(_recordScreenView(screenName));
      }
    }
  }

  Future<void> _recordScreenView(String screenName) async {
    await _recorder.record(
      TelemetryEvent.userAction(
        action: UserActionType.screenView,
        params: {'screen': screenName},
      ),
    );
    await _uploader.flush();
  }
}
