import 'dart:async';

import 'package:eqmonitor/core/fcm/notification_deep_link.dart';

/// 通知による起動の確認が終わるまで、splash の遷移を待たせる。
class PendingNotificationDeepLinkGate {
  NotificationDeepLink? _pending;
  final _resolved = Completer<void>();

  Future<void> get whenResolved => _resolved.future;

  void store(NotificationDeepLink? link) {
    _pending = link;
  }

  void resolve() {
    if (!_resolved.isCompleted) {
      _resolved.complete();
    }
  }

  NotificationDeepLink? consumePending() {
    final link = _pending;
    _pending = null;
    return link;
  }
}
