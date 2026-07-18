import 'dart:async';

import 'package:eqmonitor/core/fcm/notification_deep_link.dart';

/// Coordinates cold-start app link capture so splash can wait until
/// [getInitialLink] finishes before consuming the pending link.
///
/// Also suppresses the first `uriLinkStream` emission when it duplicates the
/// cold-start initial URI (app_links may emit both).
class AppLinksColdStartGate {
  NotificationDeepLink? _pending;
  Uri? _initialUri;
  var _initialDuplicatePending = false;
  final Completer<void> _resolved = Completer<void>();

  Future<void> get whenResolved => _resolved.future;

  void resolveInitial(Uri? uri) {
    _initialUri = uri;
    if (uri != null) {
      _pending = NotificationDeepLink.fromUri(uri);
      _initialDuplicatePending = true;
    }
    if (!_resolved.isCompleted) {
      _resolved.complete();
    }
  }

  NotificationDeepLink? consumePending() {
    final link = _pending;
    _pending = null;
    return link;
  }

  /// Whether a stream URI should trigger immediate navigation.
  bool shouldNavigateForStreamUri(Uri uri) {
    if (_initialDuplicatePending && uri == _initialUri) {
      _initialDuplicatePending = false;
      return false;
    }
    return true;
  }
}
